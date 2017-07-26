//
//  YYRequestCache.m
//  YYProjectNew
//
//  Created by yangyh on 2017/1/21.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import "YYRequestCache.h"
#import "YYNetConfig.h"
#import "YYRequestCacheObject.h"
#import "NSDictionary+YYNetwork.h"

@interface YYRequestCache ()

@property (nonatomic, strong) NSCache *cache;//缓存

@end

@implementation YYRequestCache

#pragma mark - life cycle

+ (instancetype)sharedInstance {
    
    static YYRequestCache *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

#pragma mark - public method

- (NSData *)fetchCachedDataWithServiceIdentifier:(NSString *)serviceIdentifier
                                      methodName:(NSString *)methodName
                                   requestParams:(NSDictionary *)requestParams {
    
    return [self fetchCachedDataWithKey:[self keyWithServiceIdentifier:serviceIdentifier methodName:methodName requestParams:requestParams]];
}

- (void)saveCacheWithData:(NSData *)cachedData
        serviceIdentifier:(NSString *)serviceIdentifier
               methodName:(NSString *)methodName requestParams:(NSDictionary *)requestParams {
    
    [self saveCacheWithData:cachedData key:[self keyWithServiceIdentifier:serviceIdentifier methodName:methodName requestParams:requestParams]];
}

#pragma mark - private method

- (void)deleteCacheWithServiceIdentifier:(NSString *)serviceIdentifier
                              methodName:(NSString *)methodName
                           requestParams:(NSDictionary *)requestParams {
    
    [self deleteCacheWithKey:[self keyWithServiceIdentifier:serviceIdentifier methodName:methodName requestParams:requestParams]];
}

- (NSData *)fetchCachedDataWithKey:(NSString *)key {
    
    YYRequestCacheObject *cachedObject = [self.cache objectForKey:key];
    if (cachedObject.isOutdated || cachedObject.isEmpty) {
        
        return nil;
    } else {
        
        return cachedObject.content;
    }
}

- (void)saveCacheWithData:(NSData *)cachedData key:(NSString *)key {
    
    YYRequestCacheObject *cachedObject = [self.cache objectForKey:key];
    
    if (cachedObject == nil) {
        
        cachedObject = [[YYRequestCacheObject alloc] init];
    }
    
    [cachedObject updateContent:cachedData];
    [self.cache setObject:cachedObject forKey:key];
}

- (void)deleteCacheWithKey:(NSString *)key {
    
    [self.cache removeObjectForKey:key];
}

- (void)clean {
    
    [self.cache removeAllObjects];
}

- (NSString *)keyWithServiceIdentifier:(NSString *)serviceIdentifier methodName:(NSString *)methodName requestParams:(NSDictionary *)requestParams {
    
    return [NSString stringWithFormat:@"%@%@%@", serviceIdentifier, methodName, [requestParams network_urlParamsStringShouldSignature:NO]];
}

#pragma mark - getters and setters

- (NSCache *)cache {
    
    if (_cache == nil) {
        
        _cache = [[NSCache alloc] init];
        _cache.countLimit = [YYNetConfig sharedInstance].cacheCountLimit;
    }
    
    return _cache;
}

@end
