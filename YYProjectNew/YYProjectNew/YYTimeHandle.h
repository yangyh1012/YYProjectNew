//
//  YYTimeHandle.h
//  YYProjectNew
//
//  Created by yangyh on 2017/1/18.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYTimeHandle : NSObject


/**
 单例方法

 @return 单例对象
 */
+ (instancetype)sharedManager;


/**
 获取处理后的弱业务时间

 @param timestamp 毫秒数
 @return 弱业务时间
 */
- (NSString *)gapStringWithTimesTamp:(CGFloat)timestamp;

@end
