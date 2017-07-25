//
//  NSString+YYDES.h
//  YYProjectNew
//
//  Created by yangyh on 2017/1/24.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 DES加密
 */
@interface NSString (YYDES)

- (NSString *)encryptWithKey:(NSString *)key;

- (NSString *)decryptWithKey:(NSString *)key;

@end
