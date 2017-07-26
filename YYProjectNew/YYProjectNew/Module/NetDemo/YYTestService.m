//
//  YYTestService.m
//  YYProjectNew
//
//  Created by yangyh on 2017/1/25.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import "YYTestService.h"

@implementation YYTestService

- (NSString *)offlineRequestBaseUrl {
    
    return @"http://www.cfcl5.com/";
}

- (NSString *)onlineRequestBaseUrl {
    
    return @"http://www.cfcl5.com/";
}

- (NSString *)offlineRequestVersion {
    
    return @"";
}

- (NSString *)onlineRequestVersion {
    
    return @"";
}

- (NSString *)fullUrlByMethodName:(NSString *)methodName {
    
    NSString *urlString = nil;
    
    if (self.requestVersion.length != 0) {
        
        urlString = [NSString stringWithFormat:@"%@/%@/%@", self.requestBaseUrl, self.requestVersion, methodName];
        
    } else {
        
        urlString = [NSString stringWithFormat:@"%@/%@", self.requestBaseUrl, methodName];
    }
    
    return urlString;
}

@end
