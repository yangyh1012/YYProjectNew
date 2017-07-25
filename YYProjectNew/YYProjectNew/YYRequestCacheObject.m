//
//  YYRequestCacheObject.m
//  YYProjectNew
//
//  Created by yangyh on 2017/1/21.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import "YYRequestCacheObject.h"
#import "YYNetConfig.h"

@interface YYRequestCacheObject()

@property (nonatomic, copy) NSData *content;
@property (nonatomic, copy) NSDate *lastUpdateTime;//最近更新时间

@end

@implementation YYRequestCacheObject

#pragma mark - public method

- (void)updateContent:(NSData *)content {
    
    self.content = content;
}

#pragma mark - getters and setters

- (BOOL)isEmpty {
    
    return self.content == nil;
}

- (BOOL)isOutdated {
    
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:self.lastUpdateTime];
    return timeInterval > [YYNetConfig sharedInstance].cacheOutdateTimeSeconds;
}

- (void)setContent:(NSData *)content {
    
    _content = [content copy];
    self.lastUpdateTime = [NSDate dateWithTimeIntervalSinceNow:0];
}

@end
