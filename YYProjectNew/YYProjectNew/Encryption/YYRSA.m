//
//  YYRSA.m
//  YYProjectNew
//
//  Created by yangyh on 2017/1/24.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import "YYRSA.h"
#import "GTMBase64.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation YYRSA {
    
    SecKeyRef publicKey;
    SecKeyRef privateKey;
}

+ (instancetype)sharedInstance {
    
    static YYRSA *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (void)dealloc {
    
    if (nil != publicKey) {
        
        CFRelease(publicKey);
    }
    
    if (nil != privateKey) {
        
        CFRelease(privateKey);
    }
}

- (SecKeyRef)getPublicKey {
    
    return publicKey;
}

- (SecKeyRef)getPrivateKey {
    
    return privateKey;
}

- (void)loadPublicKeyFromFile:(NSString *)derFilePath {
    
    NSData *derData = [[NSData alloc] initWithContentsOfFile:derFilePath];
    [self loadPublicKeyFromData:derData];
}

- (void)loadPublicKeyFromData:(NSData *)derData {
    
    publicKey = [self getPublicKeyRefrenceFromeData:derData];
}

- (void)loadPrivateKeyFromFile:(NSString *)p12FilePath password:(NSString *)p12Password {
    
    NSData *p12Data = [NSData dataWithContentsOfFile:p12FilePath];
    [self loadPrivateKeyFromData:p12Data password:p12Password];
}

- (void)loadPrivateKeyFromData:(NSData *)p12Data password:(NSString *)p12Password {
    
    privateKey = [self getPrivateKeyRefrenceFromData:p12Data password:p12Password];
}

- (SecKeyRef)getPublicKeyRefrenceFromeData:(NSData *)derData {
    
    SecCertificateRef myCertificate = SecCertificateCreateWithData(kCFAllocatorDefault, (__bridge CFDataRef)derData);
    SecPolicyRef myPolicy = SecPolicyCreateBasicX509();
    SecTrustRef myTrust;
    OSStatus status = SecTrustCreateWithCertificates(myCertificate,myPolicy,&myTrust);
    SecTrustResultType trustResult;
    
    if (status == noErr) {
        
        status = SecTrustEvaluate(myTrust, &trustResult);
    }
    
    SecKeyRef securityKey = SecTrustCopyPublicKey(myTrust);
    CFRelease(myCertificate);
    CFRelease(myPolicy);
    CFRelease(myTrust);
    
    return securityKey;
}

- (SecKeyRef)getPrivateKeyRefrenceFromData:(NSData *)p12Data password:(NSString *)password {
    
    SecKeyRef privateKeyRef = NULL;
    NSMutableDictionary * options = [[NSMutableDictionary alloc] init];
    [options setObject: password forKey:(__bridge id)kSecImportExportPassphrase];
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    OSStatus securityError = SecPKCS12Import((__bridge CFDataRef) p12Data, (__bridge CFDictionaryRef)options, &items);
    
    if (securityError == noErr && CFArrayGetCount(items) > 0) {
        
        CFDictionaryRef identityDict = CFArrayGetValueAtIndex(items, 0);
        SecIdentityRef identityApp = (SecIdentityRef)CFDictionaryGetValue(identityDict, kSecImportItemIdentity);
        securityError = SecIdentityCopyPrivateKey(identityApp, &privateKeyRef);
        
        if (securityError != noErr) {
            
            privateKeyRef = NULL;
        }
    }
    
    CFRelease(items);
    
    return privateKeyRef;
}



- (NSString *)rsaEncryptString:(NSString *)string {
    
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encryptedData = [self rsaEncryptData:data];
    
    NSString *base64EncryptedString = [[NSString alloc] initWithData:[GTMBase64 encodeData:encryptedData] encoding:NSUTF8StringEncoding];
    
    return base64EncryptedString;
}

// 加密的大小受限于SecKeyEncrypt函数，SecKeyEncrypt要求明文和密钥的长度一致，如果要加密更长的内容，需要把内容按密钥长度分成多份，然后多次调用SecKeyEncrypt来实现
- (NSData *)rsaEncryptData:(NSData*)data {
    
    SecKeyRef key = [self getPublicKey];
    size_t cipherBufferSize = SecKeyGetBlockSize(key);
    uint8_t *cipherBuffer = malloc(cipherBufferSize * sizeof(uint8_t));
    size_t blockSize = cipherBufferSize - 11;       // 分段加密
    size_t blockCount = (size_t)ceil([data length] / (double)blockSize);
    NSMutableData *encryptedData = [[NSMutableData alloc] init] ;
    
    for (int i=0; i<blockCount; i++) {
        
        int bufferSize = (int)MIN(blockSize,[data length] - i * blockSize);
        NSData *buffer = [data subdataWithRange:NSMakeRange(i * blockSize, bufferSize)];
        OSStatus status = SecKeyEncrypt(key, kSecPaddingPKCS1, (const uint8_t *)[buffer bytes], [buffer length], cipherBuffer, &cipherBufferSize);
        
        if (status == noErr){
            NSData *encryptedBytes = [[NSData alloc] initWithBytes:(const void *)cipherBuffer length:cipherBufferSize];
            [encryptedData appendData:encryptedBytes];
            
        } else {
            
            if (cipherBuffer) {
                
                free(cipherBuffer);
            }
            
            return nil;
        }
    }
    
    if (cipherBuffer) {
        
        free(cipherBuffer);
    }
    
    return encryptedData;
}

- (NSString *)rsaDecryptString:(NSString*)string {
    
    NSData *data = [[NSData alloc] initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSData *decryptData = [self rsaDecryptData:data];
    NSString *result = [[NSString alloc] initWithData:decryptData encoding:NSUTF8StringEncoding];
    
    return result;
}

- (NSData *)rsaDecryptData:(NSData*)data {
    
    SecKeyRef key = [self getPrivateKey];
    size_t cipherLen = [data length];
    void *cipher = malloc(cipherLen);
    [data getBytes:cipher length:cipherLen];
    size_t plainLen = SecKeyGetBlockSize(key) - 12;
    void *plain = malloc(plainLen);
    OSStatus status = SecKeyDecrypt(key, kSecPaddingPKCS1, cipher, cipherLen, plain, &plainLen);
    
    if (status != noErr) {
        
        return nil;
    }
    
    NSData *decryptedData = [[NSData alloc] initWithBytes:(const void *)plain length:plainLen];
    
    return decryptedData;
}

@end
