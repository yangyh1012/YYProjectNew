//
//  YYService.h
//  YYProjectNew
//
//  Created by yangyh on 2017/1/22.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYResponse.h"

/**
 负责处理网址拼接，处理线上线下开关，所有YYService的子类都要符合这个protocol
 */
@protocol YYServiceProtocol <NSObject>

@required


/**
 测试url

 @return 测试url
 */
- (NSString *)offlineRequestBaseUrl;

/**
 正式url

 @return 正式url
 */
- (NSString *)onlineRequestBaseUrl;


/**
 测试api版本

 @return 测试api版本
 */
- (NSString *)offlineRequestVersion;

/**
 正式api版本

 @return 正式api版本
 */
- (NSString *)onlineRequestVersion;

/**
 生成完整的url，一般是url+版本号+方法名

 @param methodName 方法名
 @return 完整url
 */
- (NSString *)fullUrlByMethodName:(NSString *)methodName;

@optional

/**
 线上线下开关，父类默认调用YYNetConfig
 
 @return Yes为线上
 */
- (BOOL)isOnlineByChild;//ByChild表示实现此方法，会覆盖父类ByParent方法

/**
 增加共同参数，服务层级别的参数

 @return 额外参数dic
 */
- (NSDictionary *)extraParmas;


/**
 在request head处加入参数，服务层级别的参数

 @return 额外参数dic
 */
- (NSDictionary *)extraHttpHeadParmas;


/**
 集中处理Service错误问题，比如token失效

 @param response 响应体
 @return 是否处理完毕
 */
- (BOOL)requestFailedComonHandle:(YYResponse *)response;

@end


/**
 为子类提供服务的service
 */
@interface YYService : NSObject

@property (nonatomic, strong, readonly) NSString *publicKey;//公钥
@property (nonatomic, strong, readonly) NSString *privateKey;//私钥
@property (nonatomic, strong, readonly) NSString *requestBaseUrl;//url
@property (nonatomic, strong, readonly) NSString *requestVersion;//版本

@property (nonatomic, weak, readonly) id<YYServiceProtocol> child;//子类

@end
