//
//  YYRequestCache.h
//  YYProjectNew
//
//  Created by yangyh on 2017/1/21.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 缓存管理类，管理返回数据
 */
@interface YYRequestCache : NSObject

+ (instancetype)sharedInstance;

/**
 获取缓存数据

 @param serviceIdentifier 域名
 @param methodName 方法名
 @param requestParams 请求参数
 @return 缓存数据
 */
- (NSData *)fetchCachedDataWithServiceIdentifier:(NSString *)serviceIdentifier
                                      methodName:(NSString *)methodName
                                   requestParams:(NSDictionary *)requestParams;


/**
 缓存数据

 @param cachedData 需要缓存的数据
 @param serviceIdentifier 域名
 @param methodName 方法名
 @param requestParams 请求参数
 */
- (void)saveCacheWithData:(NSData *)cachedData
        serviceIdentifier:(NSString *)serviceIdentifier
               methodName:(NSString *)methodName
            requestParams:(NSDictionary *)requestParams;


/**
 清理缓存
 */
- (void)clean;

@end
