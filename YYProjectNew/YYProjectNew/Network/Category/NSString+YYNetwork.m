//
//  NSString+YYNetwork.m
//  YYProjectNew
//
//  Created by yangyh on 2017/1/21.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import "NSString+YYNetwork.h"

@implementation NSString (YYNetwork)

+ (NSString *)messageForHttpRequestType:(YYNetworkRequestType)requestType {
    
    if (requestType == YYNetworkRequestTypeGet) {
        
        return @"GET";
    } else if (requestType == YYNetworkRequestTypePost) {
        
        return @"POST";
    } else if (requestType == YYNetworkRequestTypePut) {
        
        return @"PUT";
    } else if (requestType == YYNetworkRequestTypeDelete) {
        
        return @"DELETE";
    }
    
    NSAssert(NO,@"YYNetworkRequestType值非法");
    
    return @"";
}

+ (NSString *)messageForResponseStatus:(YYResponseStatus)responseStatus {
    
    if (responseStatus == YYResponseStatusSuccess) {
        
        return @"请求成功";
    } else if (responseStatus == YYResponseStatusErrorTimeout) {
        
        return @"请求超时";
    } else if (responseStatus == YYResponseStatusErrorNoNetwork) {
        
        return @"请检查网络";
    }
    
    NSAssert(NO,@"YYResponseStatus值非法");
    
    return @"";
}

+ (NSString *)messageForManagerErrorType:(YYBaseRequestManagerErrorType)managerErrorType {
    
    if (managerErrorType == YYBaseRequestManagerErrorTypeDefault) {
        
        return @"未发起请求";
    } else if (managerErrorType == YYBaseRequestManagerErrorTypeSuccess) {
        
        return @"请求成功，返回数据格式正常";
    } else if (managerErrorType == YYBaseRequestManagerErrorTypeParamsFormat) {
        
        return @"未发起请求，请求参数格式不正确";
    } else if (managerErrorType == YYBaseRequestManagerErrorTypeResponseFormat) {
        
        return @"请求成功，返回数据格式不正确";
    } else if (managerErrorType == YYBaseRequestManagerErrorTypeTimeout) {
        
        return @"请求超时";
    } else if (managerErrorType == YYBaseRequestManagerErrorTypeNoNetWork) {
        
        return @"未发起请求，请检查网络";
    } else if (managerErrorType == YYBaseRequestManagerErrorTypeServiceFailed) {
        
        return @"请求成功，服务出错";
    }
    
    NSAssert(NO,@"YYBaseRequestManagerErrorType值非法");
    
    return @"";
}

@end
