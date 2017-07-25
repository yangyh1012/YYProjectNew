//
//  YYServiceFactory.h
//  YYProjectNew
//
//  Created by yangyh on 2017/1/22.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYService.h"


/**
 用于创建service映射
 */
@protocol YYServiceFactoryDataSource <NSObject>

@required

/**
 key为service的Identifier，value为service的Classy映射的字符串

 @return 服务信息
 */
- (NSDictionary<NSString *,NSString *> *)serviceInfos;

@end

@interface YYServiceFactory : NSObject

@property (nonatomic, weak) id<YYServiceFactoryDataSource> dataSource;//数据源

+ (instancetype)sharedInstance;


/**
 根据serviceId生成Service实例

 @param identifier serviceId
 @return Service实例
 */
- (YYService<YYServiceProtocol> *)serviceWithIdentifier:(NSString *)identifier;

@end
