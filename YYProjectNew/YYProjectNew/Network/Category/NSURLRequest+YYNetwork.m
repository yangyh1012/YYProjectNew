//
//  NSURLRequest+YYNetwork.m
//  YYProjectNew
//
//  Created by yangyh on 2017/1/21.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import "NSURLRequest+YYNetwork.h"
#import <objc/runtime.h>

static void *requestParamsForYYStatic;

@implementation NSURLRequest (YYNetwork)

- (void)setRequestParamsForYY:(NSDictionary *)requestParamsForYY {
    
    objc_setAssociatedObject(self, &requestParamsForYYStatic, requestParamsForYY, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDictionary *)requestParamsForYY {
    
    return objc_getAssociatedObject(self, &requestParamsForYYStatic);
}

@end
