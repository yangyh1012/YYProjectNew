//
//  NSObject+YYSharedInstance.m
//  YYProjectNew
//
//  Created by yangyh on 2017/1/23.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import "NSObject+YYSharedInstance.h"

@implementation NSObject (YYSharedInstance)

+ (instancetype)sharedInstance {
    
//    Class Y = [self class];
//    Class Z = NSClassFromString(@"Z");
//    Z *z = [[self alloc] init];
//    Y *y = [[self alloc] init];
    
    return [[self alloc] init];
}

@end
