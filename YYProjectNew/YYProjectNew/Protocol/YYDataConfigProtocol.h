//
//  YYDataConfigProtocol.h
//  YYProjectNew
//
//  Created by yangyh on 2017/1/18.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YYDataConfigProtocol <NSObject>

@required

/**
 数据处理方法

 @param container 可以是控制器，也可以是视图
 @param data 可以是网络数据，也可以是本地数据；可以是字符串类型，也可以是数组或者字典类型
 */
- (void)dataConfigWithContainer:(id)container data:(id)data;

@end
