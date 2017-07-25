//
//  YYResponse.m
//  YYProjectNew
//
//  Created by yangyh on 2017/1/21.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import "YYResponse.h"
#import "NSURLRequest+YYNetwork.h"
#import "NSObject+YYNetwork.h"

@interface YYResponse ()

@property (nonatomic, copy) NSURLRequest *request;
@property (nonatomic, assign) NSInteger requestId;


@property (nonatomic, copy) NSData *responseData;
@property (nonatomic, copy) NSString *contentString;
@property (nonatomic, copy) id content;


@property (nonatomic, assign) YYResponseStatus status;
@property (nonatomic, assign) BOOL isCache;
@property (nonatomic, strong) NSError *error;

@end

@implementation YYResponse

#pragma mark - life cycle

- (instancetype)initNoCacheWithRequest:(NSURLRequest *)request
                             requestId:(NSNumber *)requestId
                          responseData:(NSData *)responseData
                                 error:(NSError *)error {
    
    if (self = [super init]) {
        
        self.request = request;
        self.requestId = [requestId integerValue];
        self.requestParams = request.requestParamsForYY;
        
        self.responseData = responseData;
        self.contentString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        self.contentString = [self.contentString network_defaultValue:@""];
        self.content = responseData ? [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:NULL] : nil;
        
        self.status = [self responseStatusWithError:error];
        self.isCache = NO;
        self.error = error;
    }
    
    return self;
}

- (instancetype)initContainCacheWithData:(NSData *)data {
    
    if (self = [super init]) {
        
        self.request = nil;
        self.requestId = 0;
        
        self.responseData = [data copy];
        self.contentString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        self.content = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];
        
        self.status = [self responseStatusWithError:nil];
        self.isCache = YES;
    }
    
    return self;
}

#pragma mark - private methods

- (YYResponseStatus)responseStatusWithError:(NSError *)error {
    
    if (error) {
        
        YYResponseStatus result = YYResponseStatusErrorNoNetwork;
        
        // 除了超时以外，所有错误都当成是无网络
        if (error.code == NSURLErrorTimedOut) {
            
            result = YYResponseStatusErrorTimeout;
        }
        
        return result;
    } else {
        
        return YYResponseStatusSuccess;
    }
}

@end
