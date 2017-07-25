//
//  NSString+YYBase64.m
//  YYProjectNew
//
//  Created by yangyh on 2017/1/24.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import "NSString+YYBase64.h"

static char base64EncodingTable[64] = {
    
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
    'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f',
    'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
    'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '/'
};

static const short _base64DecodingTable[256] = {
    
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -1, -1, -2, -1, -1, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -1, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, 62, -2, -2, -2, 63,
    52, 53, 54, 55, 56, 57, 58, 59, 60, 61, -2, -2, -2, -2, -2, -2,
    -2,  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14,
    15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -2, -2, -2, -2, -2,
    -2, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
    41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2
};

@implementation NSString (YYBase64)

- (NSString *)encodeBase64 {
    
    NSData *dataString = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [NSString base64StringFromData:dataString];
    
    return base64String;
}

+ (NSString *)base64StringFromData:(NSData *)data {
    
    NSUInteger lentext = [data length];
    if (lentext < 1)
        return @"";
    
    char *outbuf = malloc(lentext*4/3+4); // add 4 to be sure
    if (!outbuf)
        return nil;
    
    const unsigned char *raw = [data bytes];
    
    int inp = 0;
    int outp = 0;
    NSUInteger do_now = lentext - (lentext%3);
    
    for (outp = 0, inp = 0; inp < do_now; inp += 3) {
        
        outbuf[outp++] = base64EncodingTable[(raw[inp] & 0xFC) >> 2];
        outbuf[outp++] = base64EncodingTable[((raw[inp] & 0x03) << 4) | ((raw[inp+1] & 0xF0) >> 4)];
        outbuf[outp++] = base64EncodingTable[((raw[inp+1] & 0x0F) << 2) | ((raw[inp+2] & 0xC0) >> 6)];
        outbuf[outp++] = base64EncodingTable[raw[inp+2] & 0x3F];
    }
    
    if (do_now < lentext) {
        
        char tmpbuf[2] = {0, 0};
        int left = lentext%3;
        for (int i=0; i < left; i++) {
            
            tmpbuf[i] = raw[do_now+i];
        }
        
        inp = 0;
        outbuf[outp++] = base64EncodingTable[(tmpbuf[inp] & 0xFC) >> 2];
        outbuf[outp++] = base64EncodingTable[((tmpbuf[inp] & 0x03) << 4) | ((tmpbuf[inp+1] & 0xF0) >> 4)];
        
        if (left == 2) {
            
            outbuf[outp++] = base64EncodingTable[((tmpbuf[inp+1] & 0x0F) << 2)];
        }
        else
            outbuf[outp++] = '=';
        
        outbuf[outp++] = '=';
    }
    
    NSString *ret = [[NSString alloc] initWithBytes:outbuf length:outp encoding:NSASCIIStringEncoding];
    free(outbuf);
    
    return ret;
}

- (NSString *)decodeBase64 {
    
    if ([self isEqualToString:@""]) {
        
        return @"";
    } else {
        
        NSData *data = [NSString dataWithBase64EncodedString:self];
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
}

+ (NSData *)dataWithBase64EncodedString:(NSString *)strBase64 {
    
    const char * objPointer = [strBase64 cStringUsingEncoding:NSASCIIStringEncoding];
    int intLength = (int)strlen(objPointer);
    int intCurrent;
    int i = 0, j = 0, k;
    
    unsigned char * objResult;
    objResult = calloc(intLength, sizeof(char));
    
    // Run through the whole string, converting as we go
    while ( ((intCurrent = *objPointer++) != '\0') && (intLength-- > 0) ) {
        
        if (intCurrent == '=') {
            
            if (*objPointer != '=' && ((i % 4) == 1)) {// || (intLength > 0)) {
                // the padding character is invalid at this point -- so this entire string is invalid
                free(objResult);
                return nil;
            }
            
            continue;
        }
        
        intCurrent = _base64DecodingTable[intCurrent];
        if (intCurrent == -1) {
            // we're at a whitespace -- simply skip over
            continue;
        } else if (intCurrent == -2) {
            // we're at an invalid character
            free(objResult);
            return nil;
        }
        
        switch (i % 4) {
            case 0:
                objResult[j] = intCurrent << 2;
                break;
                
            case 1:
                objResult[j++] |= intCurrent >> 4;
                objResult[j] = (intCurrent & 0x0f) << 4;
                break;
                
            case 2:
                objResult[j++] |= intCurrent >>2;
                objResult[j] = (intCurrent & 0x03) << 6;
                break;
                
            case 3:
                objResult[j++] |= intCurrent;
                break;
        }
        i++;
    }
    
    // mop things up if we ended on a boundary
    k = j;
    if (intCurrent == '=') {
        switch (i % 4) {
            case 1:
                // Invalid state
                free(objResult);
                return nil;
                
            case 2:
                k++;
                // flow through
            case 3:
                objResult[k] = 0;
        }
    }
    
    // Cleanup and setup the return NSData
    NSData *objData = [[NSData alloc] initWithBytes:objResult length:j];
    free(objResult);
    
    return objData;
}

@end
