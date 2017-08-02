//
//  NSObject+YYTimeCount.h
//  YYProjectNew
//
//  Created by yangyh on 2017/8/2.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (YYTimeCount)

/**
 代码运行时间计算

 @param block 代码
 */
- (void)logTimeTakenToRunBlock:(void (^)(void))block;

@end
