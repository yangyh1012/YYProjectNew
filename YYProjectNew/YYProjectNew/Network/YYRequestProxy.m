//
//  YYRequestProxy.m
//  YYProjectNew
//
//  Created by yangyh on 2017/1/21.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import "YYRequestProxy.h"
#import <AFNetworking/AFNetworking.h>
#import "YYRequest.h"
#import "YYRequestLogger.h"

@interface YYRequestProxy ()

@property (nonatomic, strong) NSMutableDictionary *dispatchTable;//网络请求任务表
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;//http session

@end

@implementation YYRequestProxy

#pragma mark - life cycle

+ (instancetype)sharedInstance {
    
    static YYRequestProxy *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

#pragma mark - public methods

- (NSInteger)requestWithRequestType:(YYNetworkRequestType)requestTypeInt
                             params:(NSDictionary *)params
                  serviceIdentifier:(NSString *)serviceIdentifier
                         methodName:(NSString *)methodName
                            success:(YYNetCallback)success
                               fail:(YYNetCallback)fail {
    
    NSURLRequest *request = [[YYRequest sharedInstance] requestWithRequestType:requestTypeInt
                                                                        params:params
                                                             serviceIdentifier:serviceIdentifier
                                                                    methodName:methodName];
    
    return [self request:request success:success fail:fail];
}

- (NSInteger)request:(NSURLRequest *)request success:(YYNetCallback)success fail:(YYNetCallback)fail {
    
    DLog(@"\n==================================\n\nRequest Start: \n\n %@\n\n==================================", request.URL);
    
    // 跑到这里的block的时候，就已经是主线程了。
    NSURLSessionDataTask *dataTask = nil;
    
    __weak typeof(self) weakSelf = self;
    dataTask = [self.sessionManager
                dataTaskWithRequest:request
                completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                    
                    __strong typeof(weakSelf) strongSelf = weakSelf;
                    
                    NSNumber *requestId = @([dataTask taskIdentifier]);
                    [strongSelf.dispatchTable removeObjectForKey:requestId];
                    
                    NSData *responseData = responseObject;
                    YYResponse *urlResponse = [[YYResponse alloc] initNoCacheWithRequest:request requestId:requestId responseData:responseData error:error];
                    
                    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
                    
                    [YYRequestLogger logDebugInfoWithResponse:httpResponse
                                               responseString:responseString
                                                      request:request
                                                        error:error];
                    
                    if (error) {
                        
                        fail?fail(urlResponse):nil;
                        
                    } else {
                        
                        success?success(urlResponse):nil;
                    }
                }];
    
    NSNumber *requestId = @([dataTask taskIdentifier]);
    
    self.dispatchTable[requestId] = dataTask;
    [dataTask resume];
    
    return [requestId integerValue];
}


- (void)cancelRequestWithRequestId:(NSNumber *)requestId {
    
    NSURLSessionDataTask *requestOperation = self.dispatchTable[requestId];
    [requestOperation cancel];
    [self.dispatchTable removeObjectForKey:requestId];
}

- (void)cancelAllRequestWithRequestList:(NSArray *)requestIdList {
    
    for (NSNumber *requestId in requestIdList) {
        
        [self cancelRequestWithRequestId:requestId];
    }
}

#pragma mark - getters and setters

- (NSMutableDictionary *)dispatchTable {
    
    if (_dispatchTable == nil) {
        
        _dispatchTable = [[NSMutableDictionary alloc] init];
    }
    
    return _dispatchTable;
}

- (AFHTTPSessionManager *)sessionManager {
    
    if (_sessionManager == nil) {
        
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];//定义返回普通格式的数据
        _sessionManager.securityPolicy.allowInvalidCertificates = YES;//允许非法证书
        _sessionManager.securityPolicy.validatesDomainName = NO;//不验证主机名
    }
    
    return _sessionManager;
}

@end
