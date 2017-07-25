//
//  YYRequestLogger.h
//  YYProjectNew
//
//  Created by yangyh on 2017/1/23.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYService.h"
#import "YYResponse.h"

@interface YYRequestLogger : NSObject

+ (instancetype)sharedInstance;

/**
 发起请求的日志

 @param request 请求
 @param requestName 请求域名
 @param service service类
 @param requestParams 请求参数
 @param methodName 请求方法
 */
+ (void)logDebugInfoWithRequest:(NSURLRequest *)request
                    requestName:(NSString *)requestName
              serviceIdentifier:(YYService *)service
                  requestParams:(id)requestParams
                     methodName:(NSString *)methodName;

/**
 请求响应的日志

 @param response 响应体
 @param responseString 返回的数据
 @param request 请求
 @param error 错误信息
 */
+ (void)logDebugInfoWithResponse:(NSHTTPURLResponse *)response
                  responseString:(NSString *)responseString
                         request:(NSURLRequest *)request
                           error:(NSError *)error;

/**
 通过缓存响应的日志

 @param response 响应体
 @param methodName 方法名
 @param service service类
 */
+ (void)logDebugInfoWithCachedResponse:(YYResponse *)response
                            methodName:(NSString *)methodName
                     serviceIdentifier:(YYService *)service;

@end
