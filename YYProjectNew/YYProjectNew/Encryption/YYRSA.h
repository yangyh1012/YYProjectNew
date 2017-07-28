//
//  YYRSA.h
//  YYProjectNew
//
//  Created by yangyh on 2017/1/24.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 RSA加密
 */
@interface YYRSA : NSObject

+ (instancetype)sharedInstance;

- (void)loadPublicKeyFromFile:(NSString *)derFilePath;
- (void)loadPublicKeyFromData:(NSData *)derData;

- (void)loadPrivateKeyFromFile:(NSString *)p12FilePath password:(NSString *)p12Password;
- (void)loadPrivateKeyFromData:(NSData *)p12Data password:(NSString *)p12Password;


- (NSString *)rsaEncryptString:(NSString *)string;
- (NSData *)rsaEncryptData:(NSData *)data;

- (NSString *)rsaDecryptString:(NSString *)string;
- (NSData *)rsaDecryptData:(NSData *)data;

@end
