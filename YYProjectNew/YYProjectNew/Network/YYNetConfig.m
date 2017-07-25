//
//  YYNetConfig.m
//  YYProjectNew
//
//  Created by yangyh on 2017/1/21.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import "YYNetConfig.h"
#import <AFNetworking/AFNetworking.h>

@implementation YYNetConfig

+ (instancetype)sharedInstance {
    
    static YYNetConfig *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sharedInstance = [[YYNetConfig alloc] init];
        sharedInstance.cacheCountLimit = 1000;
        sharedInstance.cacheOutdateTimeSeconds = 300;
        sharedInstance.apiNetworkingTimeoutSeconds = 20.0f;
        sharedInstance.shouldSetParamsInHTTPBodyExceptGET = NO;
        sharedInstance.shouldCache = NO;
        sharedInstance.serviceIsOnline = NO;
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStateChange:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
        
    });
    
    return sharedInstance;
}

- (BOOL)isReachable {
    
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusUnknown) {
        
        return YES;
    } else {
        
        return [[AFNetworkReachabilityManager sharedManager] isReachable];
    }
}

@end
