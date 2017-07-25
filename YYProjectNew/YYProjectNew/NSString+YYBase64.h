//
//  NSString+YYBase64.h
//  YYProjectNew
//
//  Created by yangyh on 2017/1/24.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Base64编码
 */
@interface NSString (YYBase64)

- (NSString *)encodeBase64;

- (NSString *)decodeBase64;

@end
