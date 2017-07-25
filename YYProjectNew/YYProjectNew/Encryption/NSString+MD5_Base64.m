//
//  NSString+MD5_Base64.m
//  YYProjectNew
//
//  Created by yangyh on 2017/1/24.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import "NSString+MD5_Base64.h"
#import <CommonCrypto/CommonDigest.h>
#import "GTMBase64.h"

@implementation NSString (MD5_Base64)

- (NSString *)md5_base64 {
    
    const char *cStr = [self UTF8String];
    unsigned char digest[16];
    CC_MD5(cStr, (int)strlen(cStr), digest );
    
    NSData *base64 = [[NSData alloc]initWithBytes:digest length:16];
    base64 = [GTMBase64 encodeData:base64];
    NSString *output = [[NSString alloc] initWithData:base64 encoding:NSUTF8StringEncoding];
    
    return output;
}

@end
