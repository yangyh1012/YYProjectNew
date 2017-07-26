//
//  NSDictionary+YYNetwork.m
//  YYProjectNew
//
//  Created by yangyh on 2017/1/21.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import "NSDictionary+YYNetwork.h"
#import "NSArray+YYNetwork.h"

@implementation NSDictionary (YYNetwork)

- (NSString *)network_urlParamsStringShouldSignature:(BOOL)shouldSignature {
    
    NSArray *sortedArray = [self network_urlParamsArrayShouldSignature:shouldSignature];
    
    return [sortedArray network_jsonString];
}

- (NSArray *)network_urlParamsArrayShouldSignature:(BOOL)shouldSignature {
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        if (![obj isKindOfClass:[NSString class]]) {
            
            obj = [NSString stringWithFormat:@"%@", obj];
        }
        
        if (!shouldSignature) {
            
            obj = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,  (CFStringRef)obj,  NULL,  (CFStringRef)@"!*'();:@&;=+$,/?%#[]",  kCFStringEncodingUTF8));
        }
        
        if ([obj length] > 0) {
            
            [result addObject:[NSString stringWithFormat:@"%@=%@", key, obj]];
        }
    }];
    
    NSArray *sortedResult = [result sortedArrayUsingSelector:@selector(compare:)];
    
    return sortedResult;
}

- (NSString *)network_jsonString {
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:NULL];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
