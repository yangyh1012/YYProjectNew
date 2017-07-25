//
//  YYRequestProxy.h
//  YYProjectNew
//
//  Created by yangyh on 2017/1/21.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYResponse.h"
#import "NSString+YYNetwork.h"

typedef void(^YYNetCallback)(YYResponse *response);

/**
 发起请求的代理类
 */
@interface YYRequestProxy : NSObject

+ (instancetype)sharedInstance;


/**
 获取requestId

 @param requestTypeInt 请求方式
 @param params 请求参数
 @param serviceIdentifier 请求服务Id
 @param methodName 请求方法名
 @param success 成功block
 @param fail 失败block
 @return requestId
 */
- (NSInteger)requestWithRequestType:(YYNetworkRequestType)requestTypeInt
                             params:(NSDictionary *)params
                  serviceIdentifier:(NSString *)serviceIdentifier
                         methodName:(NSString *)methodName
                            success:(YYNetCallback)success
                               fail:(YYNetCallback)fail;


/**
 获取requestId

 @param request 请求对象
 @param success 成功block
 @param fail 失败block
 @return requestId
 */
- (NSInteger)request:(NSURLRequest *)request success:(YYNetCallback)success fail:(YYNetCallback)fail;


/**
 取消单个请求

 @param requestId 请求Id
 */
- (void)cancelRequestWithRequestId:(NSNumber *)requestId;


/**
 取消所有请求

 @param requestIdList 请求列表
 */
- (void)cancelAllRequestWithRequestList:(NSArray *)requestIdList;

@end
