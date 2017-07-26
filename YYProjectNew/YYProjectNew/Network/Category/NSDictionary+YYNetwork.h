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

 @param shouldSignature 是否需要签名，不签名的话，会进行转义
 @return 字符串
 */
- (NSString *)network_urlParamsStringShouldSignature:(BOOL)shouldSignature;


/**
 将url参数转数组

 @param shouldSignature 是否需要签名，会进行转义
 @return 数组
 */
- (NSArray *)network_urlParamsArrayShouldSignature:(BOOL)shouldSignature;


/**
 字典转json

 @return json字符串
 */
- (NSString *)network_jsonString;


@end
