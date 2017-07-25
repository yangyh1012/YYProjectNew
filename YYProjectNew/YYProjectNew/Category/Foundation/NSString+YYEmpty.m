//
//  NSString+YYEmpty.m
//  YYProjectNew
//
//  Created by yangyh on 2017/1/21.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import "NSString+YYEmpty.h"

@implementation NSString (YYEmpty)

+ (NSString *)stringByTrim:(NSString *)string {
    
    return string == nil ? nil : [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

+ (BOOL)isStringEmpty:(NSString *)string {
    
    return string == nil ? YES : [NSString stringByTrim:string].length < 1 ? YES : NO;
}

@end
