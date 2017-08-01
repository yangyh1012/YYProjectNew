//
//  YYTimeHandle.m
//  YYProjectNew
//
//  Created by yangyh on 2017/1/18.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import "YYTimeHandle.h"

@implementation YYTimeHandle

//单例设计
+ (instancetype)sharedManager {
    
    static YYTimeHandle *sharedManager = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        //函数式编程
        sharedManager = [[self alloc] init];
    });
    
    return sharedManager;
}

- (NSString *)gapStringWithTimesTamp:(CGFloat)timestamp {
    
    NSString *suffix = @"前";
    
    NSDate *referenceDate = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
    float different = [referenceDate timeIntervalSinceDate:[NSDate date]];
    
    if (different < 0) {
        
        different = - different;
        suffix = @"前";
    }
    
    // days = different / (24 * 60 * 60), take the floor value
    float dayDifferent = floor(different / 86400);
    
    int days   = (int)dayDifferent;
    int weeks  = (int)ceil(dayDifferent / 7);
    int months = (int)ceil(dayDifferent / 30);
    int years  = (int)ceil(dayDifferent / 365);
    
    // It belongs to today
    if (dayDifferent <= 0) {
        
        // lower than 60 seconds
        if (different < 60) {
            
            return @"刚刚";
        }
        
        // lower than 120 seconds => one minute and lower than 60 seconds
        if (different < 60 * 60) {
            
            return [NSString stringWithFormat:@"1分钟%@", suffix];
        }
        
//        // lower than 60 minutes
//        if (different < 120 * 60) {
//        
//            return [NSString stringWithFormat:@"%d分钟%@", (int)floor(different / 60), suffix];
//        }
        
        // lower than 60 * 2 minutes => one hour and lower than 60 minutes
        if (different < 7200) {
            
            return [NSString stringWithFormat:@"1小时%@", suffix];
        }
        
        // lower than one day
        if (different < 86400) {
            
            return [NSString stringWithFormat:@"%d小时%@", (int)floor(different / 3600), suffix];
        }
    }
    
    // lower than one week
    else if (days < 7) {
        
        return [NSString stringWithFormat:@"%d天%@", days, suffix];
    }
    
    // lager than one week but lower than a month
    else if (weeks < 4) {
        
        return [NSString stringWithFormat:@"%d周%@", weeks, suffix];
    }
    
    // lager than a month and lower than a year
    else if (months < 12) {
        
        return [NSString stringWithFormat:@"%d月%@", months, suffix];
    }
    
    // lager than a year
    else {
        
        return [NSString stringWithFormat:@"%d年%@", years, suffix];
    }
    
    return self.description;
}

@end
