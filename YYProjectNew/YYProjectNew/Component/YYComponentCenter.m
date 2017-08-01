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
NSString *const YYComponentCenter_Target = @"Target_";
NSString *const YYComponentCenter_Action = @"Action_";
NSString *const YYComponentCenter_Notfount = @"notFound:";

@interface YYComponentCenter ()

@property (nonatomic, strong) NSMutableDictionary *cachedTargets;

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
    
    //取对应的target名字和method名字
    id result = [self openLocalWithTarget:url.host action:actionName params:params shouldCacheTarget:NO];
    
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

- (id)openLocalWithTarget:(NSString *)targetName
                   action:(NSString *)actionName
                   params:(NSDictionary *)params
        shouldCacheTarget:(BOOL)shouldCacheTarget {
    
    NSString *targetClassString = [NSString stringWithFormat:@"%@%@", YYComponentCenter_Target, targetName];
    NSString *actionString = [NSString stringWithFormat:@"%@%@:", YYComponentCenter_Action, actionName];
    Class targetClass;
    
    NSObject *target = self.cachedTargets[targetClassString];
    if (target == nil) {
        
        targetClass = NSClassFromString(targetClassString);
        target = [[targetClass alloc] init];
    }
    
    //给一个固定的target专门用于在这个时候顶上，然后处理这种请求
    if (target == nil) {
        
        return nil;
    }
    
    if (shouldCacheTarget) {
        
        self.cachedTargets[targetClassString] = target;
    }
    
    SEL action = NSSelectorFromString(actionString);
    
    if ([target respondsToSelector:action]) {
        
        return [self safePerformAction:action target:target params:params];
    } else {
        
        //有可能target是Swift对象
        actionString = [NSString stringWithFormat:@"%@%@WithParams:", YYComponentCenter_Action, actionName];
        action = NSSelectorFromString(actionString);
        
        if ([target respondsToSelector:action]) {
            
            return [self safePerformAction:action target:target params:params];
        } else {
            
            //这里是处理无响应请求的地方，如果无响应，则尝试调用对应target的notFound方法统一处理
            SEL action = NSSelectorFromString(YYComponentCenter_Notfount);
            if ([target respondsToSelector:action]) {
                
                return [self safePerformAction:action target:target params:params];
            } else {
                
                //这里也是处理无响应请求的地方，在notFound都没有的时候，可以用前面提到的固定的target顶上的。
                [self.cachedTargets removeObjectForKey:targetClassString];
                
                return nil;
            }
        }
    }
}

- (void)releaseCachedTargetWithTargetName:(NSString *)targetName {
    
    NSString *targetClassString = [NSString stringWithFormat:@"%@%@", YYComponentCenter_Target, targetName];
    [self.cachedTargets removeObjectForKey:targetClassString];
}

#pragma mark - private methods

- (id)safePerformAction:(SEL)action target:(NSObject *)target params:(NSDictionary *)params {
    
    NSMethodSignature* methodSig = [target methodSignatureForSelector:action];
    if(methodSig == nil) {
        
        return nil;
    }
    
    const char* retType = [methodSig methodReturnType];
    
    if (strcmp(retType, @encode(void)) == 0) {
        
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setArgument:&params atIndex:2];
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];
        
        return nil;
    }
    
    if (strcmp(retType, @encode(NSInteger)) == 0) {
        
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setArgument:&params atIndex:2];
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];
        NSInteger result = 0;
        [invocation getReturnValue:&result];
        
        return @(result);
    }
    
    if (strcmp(retType, @encode(BOOL)) == 0) {
        
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setArgument:&params atIndex:2];
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];
        BOOL result = 0;
        [invocation getReturnValue:&result];
        
        return @(result);
    }
    
    if (strcmp(retType, @encode(CGFloat)) == 0) {
        
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setArgument:&params atIndex:2];
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];
        CGFloat result = 0;
        [invocation getReturnValue:&result];
        
        return @(result);
    }
    
    if (strcmp(retType, @encode(NSUInteger)) == 0) {
        
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setArgument:&params atIndex:2];
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];
        NSUInteger result = 0;
        [invocation getReturnValue:&result];
        
        return @(result);
    }
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    return [target performSelector:action withObject:params];
#pragma clang diagnostic pop
}

#pragma mark - getters and setters

- (NSMutableDictionary *)cachedTargets {
    
    if (_cachedTargets == nil) {
        
        _cachedTargets = [[NSMutableDictionary alloc] init];
    }
    
    return _cachedTargets;
}

@end
