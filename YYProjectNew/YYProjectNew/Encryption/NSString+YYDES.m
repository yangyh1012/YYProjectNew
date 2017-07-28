//
//  NSString+YYDES.m
//  YYProjectNew
//
//  Created by yangyh on 2017/1/24.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import "NSString+YYDES.h"
#import <CommonCrypto/CommonCryptor.h>
#import "GTMBase64.h"

//static Byte iv[] = {1,2,3,4,5,6,7,8};

static NSDictionary *s_tokenAddition = nil;

@implementation NSString (YYDES)

- (NSString *)encryptWithKey:(NSString *)key {
    
    NSString *ciphertext = nil;
    
    const char *bytes = [self UTF8String];
    NSUInteger length = [self length];
    
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    
    size_t numBytesEncrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,//算法类型：加密
                                          kCCAlgorithmDES,//算法名称
                                          kCCOptionPKCS7Padding,//补码方式
                                          [key UTF8String],//密钥
                                          kCCKeySizeDES,
                                          NULL,//密钥偏移量，可为NULL，也可为上面定义的变量iv
                                          bytes,
                                          length,
                                          buffer,
                                          1024,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        ciphertext = [GTMBase64 stringByEncodingData:data];
    }
    
    return ciphertext;
}

- (NSString *)decryptWithKey:(NSString *)key {
    
    if ([self isEqualToString:@""]) {
        
        return @"";
    }
    
    NSData *cipherData = [GTMBase64 decodeData:[self dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSInteger length = self.length;
    if (length < 1024) {
        length = 1024;
    }
    unsigned char buffer[length];
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [key UTF8String],
                                          kCCKeySizeDES,
                                          NULL,
                                          [cipherData bytes],
                                          [cipherData length],
                                          buffer,
                                          length,
                                          &numBytesDecrypted);
    NSString *plainText = nil;
    if (cryptStatus == kCCSuccess) {
        
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plainText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    } else {
        
        free(buffer);
    }
    
    return plainText;
}

@end
