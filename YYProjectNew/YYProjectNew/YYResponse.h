//
//  YYResponse.h
//  YYProjectNew
//
//  Created by yangyh on 2017/1/21.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+YYNetwork.h"

/**
 创建响应体
 */
@interface YYResponse : NSObject

@property (nonatomic, copy, readonly) NSURLRequest *request;//请求
@property (nonatomic, assign, readonly) NSInteger requestId;//请求编号
@property (nonatomic, copy) NSDictionary *requestParams;//请求参数

@property (nonatomic, copy, readonly) NSData *responseData;//返回的数据
@property (nonatomic, copy, readonly) NSString *contentString;//数据字符串格式
@property (nonatomic, copy, readonly) id content;//数据字典格式

@property (nonatomic, assign, readonly) YYResponseStatus status;//响应状态
@property (nonatomic, strong, readonly) NSError *error;//错误信息
@property (nonatomic, assign, readonly) BOOL isCache;//是否缓存


/**
 没有cache的response初始化

 @param request 请求
 @param requestId 请求编号
 @param responseData 返回的数据
 @param error 错误信息
 @return response
 */
- (instancetype)initNoCacheWithRequest:(NSURLRequest *)request
                             requestId:(NSNumber *)requestId
                          responseData:(NSData *)responseData
                                 error:(NSError *)error;


/**
 含有cache的response初始化

 @param data 数据
 @return response
 */
- (instancetype)initContainCacheWithData:(NSData *)data;

@end
