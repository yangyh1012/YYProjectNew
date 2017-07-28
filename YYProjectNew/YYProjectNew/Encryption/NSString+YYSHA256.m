//
//  NSString+YYSHA256.m
//  YYProjectNew
//
//  Created by yangyh on 2017/1/28.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import "NSString+YYSHA256.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (YYSHA256)

- (NSString *)codeSHA256 {
    
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    
    CC_SHA256(data.bytes, (unsigned int)data.length, digest);
    
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        
        [result appendFormat:@"%02x", digest[i]];
    }
    
    return result;
}

@end
