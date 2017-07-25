//
//  YYRequest.m
//  YYProjectNew
//
//  Created by yangyh on 2017/1/21.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import "YYRequest.h"
#import "YYService.h"
#import "YYServiceFactory.h"
#import <AFNetworking/AFNetworking.h>
#import "YYNetConfig.h"
#import "NSString+YYNetwork.h"
#import "NSURLRequest+YYNetwork.h"

@interface YYRequest ()

@property (nonatomic, strong) AFHTTPRequestSerializer *httpRequestSerializer;//request处理类

@end

@implementation YYRequest

#pragma mark - life cycle

+ (instancetype)sharedInstance {
    
    static YYRequest *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

#pragma mark - public methods

- (NSURLRequest *)requestWithRequestType:(YYNetworkRequestType)requestTypeInt
                                  params:(NSDictionary *)params
                       serviceIdentifier:(NSString *)serviceIdentifier
                              methodName:(NSString *)methodName {
    
    //生成service对象
    YYService *service = [[YYServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];
    
    //拼接字符串
    NSString *urlString = [service.child fullUrlByMethodName:methodName];

    NSAssert(urlString != nil && urlString.length > 0, @"fullUrlByMethodName没有做好拼接任务");
    
    //url拼接额外的参数
    if ([service.child respondsToSelector:@selector(extraParmas)]) {
        
        if ([service.child extraParmas]) {
            
            NSMutableDictionary *totalRequestParams = [NSMutableDictionary dictionaryWithDictionary:params];
            [[service.child extraParmas] enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                
                [totalRequestParams setObject:obj forKey:key];
            }];
            
            params = [totalRequestParams copy];
        }
    }
    
    NSString *requestType = [NSString messageForHttpRequestType:requestTypeInt];
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:requestType URLString:urlString parameters:params error:NULL];
    
    //是否将非Get请求参数放入body中
    if (![requestType isEqualToString:@"GET"] && [YYNetConfig sharedInstance].shouldSetParamsInHTTPBodyExceptGET) {
        
        request.HTTPBody = [NSJSONSerialization dataWithJSONObject:params options:0 error:NULL];
    }

    if ([service.child respondsToSelector:@selector(extraHttpHeadParmas)]) {
        
        NSDictionary *dict = [service.child extraHttpHeadParmas];
        
        if (dict) {
            
            [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                
                [request setValue:obj forHTTPHeaderField:key];
            }];
        }
    }

    //设置参数
    request.requestParamsForYY = params;
    
    return request;
}

#pragma mark - getters and setters

- (AFHTTPRequestSerializer *)httpRequestSerializer {
    
    if (_httpRequestSerializer == nil) {
        
        _httpRequestSerializer = [AFHTTPRequestSerializer serializer];
        _httpRequestSerializer.timeoutInterval = [YYNetConfig sharedInstance].apiNetworkingTimeoutSeconds;
        _httpRequestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    }
    
    return _httpRequestSerializer;
}

@end
