//
//  NSString+YYAES128.h
//  YYProjectNew
//
//  Created by yangyh on 2017/1/24.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 AES128加密
 */
@interface NSString (YYAES128)

- (NSString *)AES128EncryptWithKey:(NSString *)key;

- (NSString *)AES128DecryptWithKey:(NSString *)key;

@end
