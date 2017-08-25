//
//  YYComponentCenter.m
//  YYProjectNew
//
//  Created by yangyh on 2017/8/1.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import "YYComponentCenter.h"
#import <objc/runtime.h>

NSString *const YYComponentCenter_Native = @"native";
NSString *const YYComponentCenter_Module = @"Module_";
NSString *const YYComponentCenter_Action = @"Action_";
NSString *const YYComponentCenter_Notfount = @"notFound:";

@interface YYComponentCenter ()

@property (nonatomic, strong) NSMutableDictionary *cachedModules;//缓存模块

@property (nonatomic, strong) NSMutableDictionary *cachedControllers;//缓存控制器

@end

@implementation YYComponentCenter

+ (instancetype)sharedInstance {
    
    static YYComponentCenter *sharedManager = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        //函数式编程
        sharedManager = [[self alloc] init];
    });
    
    return sharedManager;
}

- (id)openRemoteUrl:(NSURL *)url completion:(void(^)(NSDictionary *info))completion {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    NSString *urlString = [url query];
    
    //获取所有参数
    for (NSString *param in [urlString componentsSeparatedByString:@"&"]) {
        
        NSArray *array = [param componentsSeparatedByString:@"="];
        if([array count] < 2) continue;
        [params setObject:[array lastObject] forKey:[array firstObject]];
    }
    
    //判断action，防止黑客通过远程方式调用本地模块。
    NSString *actionName = [url.path stringByReplacingOccurrencesOfString:@"/" withString:@""];
    if ([actionName hasPrefix:YYComponentCenter_Native]) {
        
        return @(NO);
    }
    
    //取对应的module名字和method名字
    id result = [self openLocalWithModule:url.host action:actionName params:params shouldCacheModule:NO];
    
    //完成时处理
    if (completion) {
        
        if (result) {
            
            completion(@{@"result":result});
        } else {
            
            completion(nil);
        }
    }
    
    return result;
}

- (id)openLocalWithModule:(NSString *)moduleName
                   action:(NSString *)actionName
                   params:(NSDictionary *)params
        shouldCacheModule:(BOOL)shouldCacheModule {
    
    NSString *moduleClassString = [NSString stringWithFormat:@"%@%@", YYComponentCenter_Module, moduleName];
    NSString *actionString = [NSString stringWithFormat:@"%@%@:", YYComponentCenter_Action, actionName];
    
    if (shouldCacheModule) {
        
        id object = self.cachedControllers[moduleClassString];
        if (object) {
            
            return object;
        }
    }
    
    Class moduleClass;
    
    NSObject *module = self.cachedModules[moduleClassString];
    if (module == nil) {
        
        moduleClass = NSClassFromString(moduleClassString);
        module = [[moduleClass alloc] init];
    }
    
    //给一个固定的module专门用于在这个时候顶上，然后处理这种请求
    if (module == nil) {
        
        return nil;
    }
    
    if (shouldCacheModule) {
        
        self.cachedModules[moduleClassString] = module;
    }
    
    SEL action = NSSelectorFromString(actionString);
    
    if ([module respondsToSelector:action]) {
        
        id object = [self safePerformAction:action module:module params:params];
        
        if (shouldCacheModule) {
            
            self.cachedControllers[moduleClassString] = object;
        }
        
        return object;
    } else {
        
        //有可能module是Swift对象
        actionString = [NSString stringWithFormat:@"%@%@WithParams:", YYComponentCenter_Action, actionName];
        action = NSSelectorFromString(actionString);
        
        if ([module respondsToSelector:action]) {
            
            id object = [self safePerformAction:action module:module params:params];
            
            if (shouldCacheModule) {
                
                self.cachedControllers[moduleClassString] = object;
            }
            
            return object;
        } else {
            
            //这里是处理无响应请求的地方，如果无响应，则尝试调用对应module的notFound方法统一处理
            SEL action = NSSelectorFromString(YYComponentCenter_Notfount);
            if ([module respondsToSelector:action]) {
                
                id object = [self safePerformAction:action module:module params:params];
                
                if (shouldCacheModule) {
                    
                    self.cachedControllers[moduleClassString] = object;
                }
                
                return object;
            } else {
                
                //这里也是处理无响应请求的地方，在notFound都没有的时候，可以用前面提到的固定的module顶上的。
                [self.cachedModules removeObjectForKey:moduleClassString];
                
                return nil;
            }
        }
    }
}

- (void)releaseCachedModuleWithModuleName:(NSString *)moduleName {
    
    NSString *moduleClassString = [NSString stringWithFormat:@"%@%@", YYComponentCenter_Module, moduleName];
    [self.cachedModules removeObjectForKey:moduleClassString];
    [self.cachedControllers removeObjectForKey:moduleClassString];
}

#pragma mark - private methods

- (id)safePerformAction:(SEL)action module:(NSObject *)module params:(NSDictionary *)params {
    
    NSMethodSignature* methodSig = [module methodSignatureForSelector:action];
    if(methodSig == nil) {
        
        return nil;
    }
    
    const char* retType = [methodSig methodReturnType];
    
    if (strcmp(retType, @encode(void)) == 0) {
        
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setArgument:&params atIndex:2];
        [invocation setSelector:action];
        [invocation setTarget:module];
        [invocation invoke];
        
        return nil;
    }
    
    if (strcmp(retType, @encode(NSInteger)) == 0) {
        
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setArgument:&params atIndex:2];
        [invocation setSelector:action];
        [invocation setTarget:module];
        [invocation invoke];
        NSInteger result = 0;
        [invocation getReturnValue:&result];
        
        return @(result);
    }
    
    if (strcmp(retType, @encode(BOOL)) == 0) {
        
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setArgument:&params atIndex:2];
        [invocation setSelector:action];
        [invocation setTarget:module];
        [invocation invoke];
        BOOL result = 0;
        [invocation getReturnValue:&result];
        
        return @(result);
    }
    
    if (strcmp(retType, @encode(CGFloat)) == 0) {
        
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setArgument:&params atIndex:2];
        [invocation setSelector:action];
        [invocation setTarget:module];
        [invocation invoke];
        CGFloat result = 0;
        [invocation getReturnValue:&result];
        
        return @(result);
    }
    
    if (strcmp(retType, @encode(NSUInteger)) == 0) {
        
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setArgument:&params atIndex:2];
        [invocation setSelector:action];
        [invocation setTarget:module];
        [invocation invoke];
        NSUInteger result = 0;
        [invocation getReturnValue:&result];
        
        return @(result);
    }
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    return [module performSelector:action withObject:params];
#pragma clang diagnostic pop
}

#pragma mark - getters and setters

- (NSMutableDictionary *)cachedModules {
    
    if (_cachedModules == nil) {
        
        _cachedModules = [[NSMutableDictionary alloc] init];
    }
    
    return _cachedModules;
}

- (NSMutableDictionary *)cachedControllers {
    
    if (_cachedControllers == nil) {
        
        _cachedControllers = [[NSMutableDictionary alloc] init];
    }
    
    return _cachedControllers;
}

@end
