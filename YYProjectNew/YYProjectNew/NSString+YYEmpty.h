//
//  NSString+YYEmpty.h
//  YYProjectNew
//
//  Created by yangyh on 2017/1/21.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YYEmpty)

/**
 *  去除头尾空格
 *
 *  @param string  需要处理的字符串
 *
 *  @return 处理后的字符串
 */
+ (NSString *)stringByTrim:(NSString *)string;

/**
 *  检测字符串是否为空
 *
 *  @param string 需要检测的字符串
 *
 *  @return Yes为空，NO为非空
 */
+ (BOOL)isStringEmpty:(NSString *)string;

@end
