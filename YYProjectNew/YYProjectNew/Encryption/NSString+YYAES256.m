//
//  NSString+YYAES256.m
//  YYProjectNew
//
//  Created by yangyh on 2017/1/28.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import "NSString+YYAES256.h"
#import <CommonCrypto/CommonCrypto.h>
#import "GTMBase64.h"

@implementation NSString (YYAES256)

- (NSString *)AES256EncryptWithKey:(NSString *)key {
    
    // 'key' should be 32 bytes for AES256, will be null-padded otherwise
    char keyPtr[kCCKeySizeAES256+1]; // room for terminator (unused)
    bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)

    // fetch key data
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSData *plain = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [plain length];
    
    //See the doc: For block ciphers, the output size will always be less than or
    //equal to the input size plus the size of one block.
    //That's why we need to add the size of one block here
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                          keyPtr, kCCKeySizeAES256,
                                          NULL /* initialization vector (optional) */,
                                          [plain bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        
        //the returned NSData takes ownership of the buffer and will free it on deallocation
        NSData *cipher = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        
        return [GTMBase64 stringByEncodingData:cipher];
    }
    
    free(buffer); //free the buffer;
    
    return nil;
}

- (NSString *)AES256DecryptWithKey:(NSString *)key {
    
    // 'key' should be 32 bytes for AES256, will be null-padded otherwise
    char keyPtr[kCCKeySizeAES256+1]; // room for terminator (unused)
    bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
    
    // fetch key data
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSData *cipher = [GTMBase64 decodeData:[self dataUsingEncoding:NSUTF8StringEncoding]];
    NSUInteger dataLength = [cipher length];
    
    //See the doc: For block ciphers, the output size will always be less than or
    //equal to the input size plus the size of one block.
    //That's why we need to add the size of one block here
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                          keyPtr, kCCKeySizeAES256,
                                          NULL /* initialization vector (optional) */,
                                          [cipher bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        
        //the returned NSData takes ownership of the buffer and will free it on deallocation
        NSData *plain = [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
        
        return [[NSString alloc] initWithData:plain encoding:NSUTF8StringEncoding];
    }
    
    free(buffer); //free the buffer;
    
    return nil;
}

@end
