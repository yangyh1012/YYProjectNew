//
//  NSDictionary+YYNetwork.h
//  YYProjectNew
//
//  Created by yangyh on 2017/1/21.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (YYNetwork)


/**
 将url参数转字符串

 @param shouldEscape 是否需要转义
 @return 字符串
 */
- (NSString *)network_urlParamsStringEscape:(BOOL)shouldEscape;


/**
 将url参数转数组

 @param shouldEscape 是否需要转义
 @return 数组
 */
- (NSArray *)network_urlParamsArrayEscape:(BOOL)shouldEscape;


/**
 字典转json

 @return json字符串
 */
- (NSString *)network_jsonString;


@end
