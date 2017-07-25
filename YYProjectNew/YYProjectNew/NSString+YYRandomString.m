//
//  NSString+YYRandomString.m
//  YYProjectNew
//
//  Created by yangyh on 2017/1/24.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import "NSString+YYRandomString.h"

@implementation NSString (YYRandomString)

+ (NSString *)returnRandomStringWithBitInt:(NSInteger)bitInt {
    
    //定义一个包含数字，大小写字母的字符串
    NSString *strAll = @"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    
    //定义一个结果
    NSString *result = [[NSMutableString alloc] initWithCapacity:bitInt];
    
    for (int i = 0; i < bitInt; i++) {
        
        //获取随机数
        NSInteger index = arc4random() % (strAll.length - 1);
        char tempStr = [strAll characterAtIndex:index];
        result = (NSMutableString *)[result stringByAppendingString:[NSString stringWithFormat:@"%c",tempStr]];
    }
    
    return result;
}

@end
