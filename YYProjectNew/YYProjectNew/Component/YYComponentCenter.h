//
//  YYComponentCenter.h
//  YYProjectNew
//
//  Created by yangyh on 2017/8/1.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYComponentCenter : NSObject

+ (instancetype)sharedInstance;


/**
 远程调用组件，例子：aaa://targetA/actionB?id=1234
 写在AppDelegate中
 
 @param url scheme://[target]/[action]?[params]
 @param completion 完成时处理
 @return 结果
 */
- (id)openRemoteUrl:(NSURL *)url completion:(void(^)(NSDictionary *info))completion;

/**
 本地调用组件

 @param targetName 目标
 @param actionName 动作
 @param params 参数
 @param shouldCacheTarget 是否缓存
 @return 结果
 */
- (id)openLocalWithTarget:(NSString *)targetName
                   action:(NSString *)actionName
                   params:(NSDictionary *)params
        shouldCacheTarget:(BOOL)shouldCacheTarget;

/**
 组件缓存

 @param targetName 目标名
 */
- (void)releaseCachedTargetWithTargetName:(NSString *)targetName;

@end
