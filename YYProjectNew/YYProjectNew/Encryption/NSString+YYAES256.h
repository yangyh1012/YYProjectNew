//
//  NSString+YYAES256.h
//  YYProjectNew
//
//  Created by yangyh on 2017/1/28.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YYAES256)

- (NSString *)AES256EncryptWithKey:(NSString *)key;

- (NSString *)AES256DecryptWithKey:(NSString *)key;

@end
