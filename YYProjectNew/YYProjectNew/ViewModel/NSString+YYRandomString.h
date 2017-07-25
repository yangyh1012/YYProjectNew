//
//  NSString+YYRandomString.h
//  YYProjectNew
//
//  Created by yangyh on 2017/1/24.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YYRandomString)

/**
 根据bitInt输入的数字返回指定位数16进字符串。
 
 @param bitInt 指定位数
 @return 指定位数16进字符串
 */
+ (NSString *)returnRandomStringWithBitInt:(NSInteger)bitInt;

@end
