//
//  AppDelegate+YYLoadSomething.m
//  YYProjectNew
//
//  Created by yangyh on 2017/1/21.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import "AppDelegate+YYLoadSomething.h"
#import "Aspects.h"
#import "YYLifeCycleProtocol.h"
#import <objc/runtime.h>

@implementation AppDelegate (YYLoadSomething)

/**
 load代码注入
 */
+ (void)load {
    
    id<YYLifeCycleProtocol> service = [[NSClassFromString(AnalyticsBusiness) alloc] init];
    
    //AOP，面向切面编程
    [UIViewController aspect_hookSelector:@selector(viewWillAppear:)
                              withOptions:AspectPositionAfter
                               usingBlock:^(id<AspectInfo> aspectInfo) {
                                   
                                   if (![[aspectInfo instance] isKindOfClass:[UINavigationController class]]) {
                                       
                                       if([service respondsToSelector:@selector(viewWillAppearHandleWithViewController:)]) {
                                           
                                           [service viewWillAppearHandleWithViewController:[aspectInfo instance]];
                                       }
                                   }
                                   
                               } error:NULL];
    
    [UIViewController aspect_hookSelector:@selector(viewWillDisappear:)
                              withOptions:AspectPositionAfter
                               usingBlock:^(id<AspectInfo> aspectInfo) {
                                   
                                   if (![[aspectInfo instance] isKindOfClass:[UINavigationController class]]) {
                                       
                                       if([service respondsToSelector:@selector(viewWillDisappearHandleWithViewController:)]) {
                                           
                                           [service viewWillDisappearHandleWithViewController:[aspectInfo instance]];
                                       }
                                   }
                                   
                               } error:NULL];
    
    [UIViewController aspect_hookSelector:NSSelectorFromString(@"dealloc")
                              withOptions:AspectPositionBefore
                               usingBlock:^(id<AspectInfo> aspectInfo) {
                                   
                                   if([service respondsToSelector:@selector(viewDeallocHandleWithViewController:)]) {
                                       
                                       [service viewDeallocHandleWithViewController:[aspectInfo instance]];
                                   }
                                   
                               } error:NULL];
    
    
    
    id<YYLifeCycleProtocol> service2 = [[NSClassFromString(ViewDidLoadBusiness) alloc] init];
    
    [UIViewController aspect_hookSelector:@selector(viewDidLoad)
                              withOptions:AspectPositionAfter
                               usingBlock:^(id<AspectInfo> aspectInfo) {
                                   
                                   if (![[aspectInfo instance] isKindOfClass:[UINavigationController class]]) {
                                       
                                       if([service2 respondsToSelector:@selector(viewDidLoadHandleWithViewController:)]) {
                                           
                                           [service2 viewDidLoadHandleWithViewController:[aspectInfo instance]];
                                       }
                                   }
                                   
                               } error:NULL];
    
    
}

@end
