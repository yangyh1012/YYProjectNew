//
//  NSArray+YYNetwork.m
//  YYProjectNew
//
//  Created by yangyh on 2017/1/21.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import "NSArray+YYNetwork.h"

@implementation NSArray (YYNetwork)

- (NSString *)network_paramsString {
    
    NSMutableString *paramString = [[NSMutableString alloc] init];
    
    NSArray *sortedParams = [self sortedArrayUsingSelector:@selector(compare:)];
    
    [sortedParams enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        if ([paramString length] == 0) {
            
            [paramString appendFormat:@"%@", obj];
        } else {
            
            [paramString appendFormat:@"&%@", obj];
        }
    }];
    
    return paramString;
}

- (NSString *)network_jsonString {
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:NULL];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
