//
//  NSObject+YYTimeCount.m
//  YYProjectNew
//
//  Created by yangyh on 2017/8/2.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import "NSObject+YYTimeCount.h"

@implementation NSObject (YYTimeCount)

- (void)logTimeTakenToRunBlock:(void (^)(void))block {
    
    double a = CFAbsoluteTimeGetCurrent();
    block();
    double b = CFAbsoluteTimeGetCurrent();
    
    double m = ((b-a) * 1000.0f); // convert from seconds to milliseconds
    
    DLog(@"Time taken: %.5f ms", m);
}

@end
