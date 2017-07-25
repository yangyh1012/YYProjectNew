//
//  NSString+YYNetwork.h
//  YYProjectNew
//
//  Created by yangyh on 2017/1/21.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import <Foundation/Foundation.h>

//请求方式
typedef NS_ENUM (NSUInteger, YYNetworkRequestType) {
    
    YYNetworkRequestTypeGet,
    YYNetworkRequestTypePost,
    YYNetworkRequestTypePut,
    YYNetworkRequestTypeDelete
};

//响应状态
typedef NS_ENUM(NSUInteger, YYResponseStatus) {
    
    YYResponseStatusSuccess, //作为底层，请求是否成功只考虑是否成功收到服务器反馈。至于签名是否正确，返回的数据是否完整，由上层Manager来决定。
    YYResponseStatusErrorTimeout,
    YYResponseStatusErrorNoNetwork // 默认除了超时以外的错误都是无网络错误。
};

//Manager请求错误类型
typedef NS_ENUM (NSUInteger, YYBaseRequestManagerErrorType) {
    
    YYBaseRequestManagerErrorTypeDefault,           //没有产生过API请求，这个是manager的默认状态。
    YYBaseRequestManagerErrorTypeSuccess,           //API请求成功且返回数据正确，此时manager的数据是可以直接拿来使用的。
    YYBaseRequestManagerErrorTypeParamsFormat,      //参数错误，此时manager不会调用API，因为参数验证是在调用API之前做的。
    YYBaseRequestManagerErrorTypeResponseFormat,    //API请求成功但返回数据不正确。如果回调数据验证函数返回值为NO，manager的状态就会是这个。
    YYBaseRequestManagerErrorTypeTimeout,           //请求超时。默认设置的是20秒超时，具体超时时间的设置请自己去看YYNetConfig的相关代码。
    YYBaseRequestManagerErrorTypeNoNetWork,         //网络不通。在调用API之前会判断一下当前网络是否通畅，这个也是在调用API之前验证的，和上面超时的状态是有区别的。
    YYBaseRequestManagerErrorTypeServiceFailed,     //集中处理Service错误问题，调用了service的requestFailedComonHandle
};

@interface NSString (YYNetwork)


/**
 将请求方式由数字转成字符串

 @param requestType 请求方式
 @return 请求方式字符串GET、POST、PUT、DELETE
 */
+ (NSString *)messageForHttpRequestType:(YYNetworkRequestType)requestType;

+ (NSString *)messageForResponseStatus:(YYResponseStatus)responseStatus;

+ (NSString *)messageForManagerErrorType:(YYBaseRequestManagerErrorType)managerErrorType;

@end
