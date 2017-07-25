//
//  YYRequest.h
//  YYProjectNew
//
//  Created by yangyh on 2017/1/21.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+YYNetwork.h"

/**
 创建request
 */
@interface YYRequest : NSObject

+ (instancetype)sharedInstance;


/**
 获取request

 @param requestTypeInt 请求方式
 @param params 请求参数
 @param serviceIdentifier 请求服务Id
 @param methodName 请求方法名
 @return request
 */
- (NSURLRequest *)requestWithRequestType:(YYNetworkRequestType)requestTypeInt
                                  params:(NSDictionary *)params
                       serviceIdentifier:(NSString *)serviceIdentifier
                              methodName:(NSString *)methodName;

@end
