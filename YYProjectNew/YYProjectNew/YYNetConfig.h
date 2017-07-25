//
//  YYNetConfig.h
//  YYProjectNew
//
//  Created by yangyh on 2017/1/21.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 网络配置类
 */
@interface YYNetConfig : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, assign, readonly) BOOL isReachable;//判断网络是否可达

@property (nonatomic, assign) BOOL serviceIsOnline;//调用线上的服务，默认为NO，调用线下服务
@property (nonatomic, assign) BOOL shouldSetParamsInHTTPBodyExceptGET;//HTTP请求除了GET请求，其他的请求都会将参数放到HTTPBody中，默认值为NO
@property (nonatomic, assign) NSTimeInterval apiNetworkingTimeoutSeconds;//请求超时时间，默认20s

@property (nonatomic, assign) BOOL shouldCache;//是否缓存，默认NO
@property (nonatomic, assign) NSInteger cacheCountLimit;//发起请求的域名、方法、参数组合的缓存个数限制，默认1000
@property (nonatomic, assign) NSTimeInterval cacheOutdateTimeSeconds;//发起请求的域名、方法、参数组合的缓存时间限制，默认5分钟

@end
