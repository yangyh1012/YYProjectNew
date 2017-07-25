//
//  NSObject+YYNetwork.m
//  YYProjectNew
//
//  Created by yangyh on 2017/1/21.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import "NSObject+YYNetwork.h"

@implementation NSObject (YYNetwork)

- (id)network_defaultValue:(id)defaultData {
    
    if (![defaultData isKindOfClass:[self class]]) {
        
        return defaultData;
    }
    
    if ([self network_isEmptyObject]) {
        
        return defaultData;
    }
    
    return self;
}

- (BOOL)network_isEmptyObject {
    
    if ([self isEqual:[NSNull null]]) {
        
        return YES;
    }
    
    if ([self isKindOfClass:[NSString class]]) {
        
        if ([(NSString *)self length] == 0) {
            
            return YES;
        }
    }
    
    if ([self isKindOfClass:[NSArray class]]) {
        
        if ([(NSArray *)self count] == 0) {
            return YES;
        }
    }
    
    if ([self isKindOfClass:[NSDictionary class]]) {
        
        if ([(NSDictionary *)self count] == 0) {
            
            return YES;
        }
    }
    
    return NO;
}

@end
