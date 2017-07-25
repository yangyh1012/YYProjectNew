//
//  NSString+YYMD5.m
//  YYProjectNew
//
//  Created by yangyh on 2017/1/24.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import "NSString+YYMD5.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (YYMD5)

- (NSString *)codeMD5 {
    
    NSData *inputData = [self dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char outputData[CC_MD5_DIGEST_LENGTH];
    CC_MD5([inputData bytes], (unsigned int)[inputData length], outputData);
    
    NSMutableString *hashStr = [NSMutableString string];
    
    int i = 0;
    for (i = 0; i < CC_MD5_DIGEST_LENGTH; ++i)
        [hashStr appendFormat:@"%02x", outputData[i]];
    
    return hashStr;
}

@end
