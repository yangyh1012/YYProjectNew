//
//  YYAPIBaseManager.m
//  YYProjectNew
//
//  Created by yangyh on 2017/1/21.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import "YYBaseRequestManager.h"
#import "YYRequestCache.h"
#import "YYNetConfig.h"
#import "NSString+YYNetwork.h"
#import "YYRequestProxy.h"
#import "YYServiceFactory.h"
#import "YYRequestLogger.h"

@interface YYBaseRequestManager ()

@property (nonatomic, readwrite) YYBaseRequestManagerErrorType errorType;
@property (nonatomic, assign) BOOL isLoading;

@property (nonatomic, strong) NSMutableArray *requestIdList;
@property (nonatomic, strong) YYRequestCache *cache;

@property (nonatomic, strong) id fetchedRawData;
@property (nonatomic, strong) YYResponse *response;

@end

@implementation YYBaseRequestManager

#pragma mark - life cycle

- (instancetype)init {
    
    if (self = [super init]) {
        
        _delegate = nil;
        _validator = nil;
        _interceptor = nil;
        _paramSource = nil;
        
        _fetchedRawData = nil;
        
        _errorType = YYBaseRequestManagerErrorTypeDefault;
        
        if ([self conformsToProtocol:@protocol(YYBaseRequestManagerProtocol)]) {
            
            self.child = (id<YYBaseRequestManagerProtocol>)self;
            
        } else {
            
            self.child = (id<YYBaseRequestManagerProtocol>)self;
            
            NSException *exception = [[NSException alloc] initWithName:@"提示" reason:[NSString stringWithFormat:@"%@没有遵循YYRequestProtocol协议",self.child] userInfo:nil];
            
            @throw exception;
        }
    }
    
    return self;
}

- (void)dealloc {
    
    [self cancelAllRequests];
}

#pragma mark - public methods

- (NSInteger)loadData {
    
    NSDictionary *params = [self.paramSource paramsForRequestWithManager:self];
    NSInteger requestId = [self loadDataWithParams:params];
    
    return requestId;
}

//适配器模式：将一个类的接口转换成客户希望的另外一个接口。Adapter模式使得原本由于接口不兼容而不能一起工作的那些类可以在一起工作。
- (id)fetchDataWithReformer:(id<YYBaseRequestManagerDataReformer>)reformer {
    
    id resultData = nil;
    if ([reformer respondsToSelector:@selector(manager:reformData:)]) {
        
        resultData = [reformer manager:self reformData:self.fetchedRawData];
    } else {
        
        resultData = [self.fetchedRawData mutableCopy];
    }
    
    return resultData;
}

- (void)cancelAllRequests {
    
    [[YYRequestProxy sharedInstance] cancelAllRequestWithRequestList:self.requestIdList];
    [self.requestIdList removeAllObjects];
}

- (void)cancelRequestWithRequestId:(NSInteger)requestId {
    
    [self removeRequestId:requestId];
    [[YYRequestProxy sharedInstance] cancelRequestWithRequestId:@(requestId)];
}

- (void)cleanDataByParent {
    
    [self.cache clean];
    self.fetchedRawData = nil;
    self.errorType = YYBaseRequestManagerErrorTypeDefault;
    
    if ([self.child respondsToSelector:@selector(cleanDataByParentAndChild)]) {
        
        [self.child cleanDataByParentAndChild];
    }
}

#pragma mark - private methods

- (NSInteger)loadDataWithParams:(NSDictionary *)params {
    
    NSInteger requestId = 0;
    
    NSDictionary *requestParams = nil;
    //发起请求之前子类是否需要添加额外参数，比如pageNumber或者pageSize
    if ([self.child respondsToSelector:@selector(addExtraParams:)]) {
        
        requestParams = [self.child addExtraParams:params];
    }
    
    if (requestParams == nil) {
        
        requestParams = params;
    }
    
    //是否在请求前处理参数，比如加载动画
    if ([self beforeRequestWithParams:requestParams]) {
        
        //是否验证参数，验证参数的格式
        if ([self validatorBeforeRequestWithParams:requestParams]) {
            
            //是否加载本地，适用于详情页、App皮肤
            if ([self.child respondsToSelector:@selector(shouldLoadFromNative)] &&
                [self.child shouldLoadFromNative] &&
                [self loadDataFromNative]) {
                
                return 0;
            }
            
            //检查一下是否有缓存
            if ([self shouldCacheByParent] && [self hasCacheWithParams:requestParams]) {
                
                return 0;
            }
            
            // 实际的网络请求
            if ([self isReachable]) {
                
                self.isLoading = YES;
                
                __weak typeof(self) weakSelf = self;
                requestId = [[YYRequestProxy sharedInstance]
                             requestWithRequestType:self.child.requestType
                             params:requestParams
                             serviceIdentifier:self.child.serviceIdentifier
                             methodName:self.child.methodName
                             success:^(YYResponse *response) {
                                 
                                 __strong typeof(weakSelf) strongSelf = weakSelf;
                                 
                                 [strongSelf requestSuccessedWithResponse:response];
                                 
                             } fail:^(YYResponse *response) {
                                 
                                 __strong typeof(weakSelf) strongSelf = weakSelf;
                                 
                                 strongSelf.errorType = YYBaseRequestManagerErrorTypeDefault;
                                 [strongSelf requestFailedWithResponse:response];
                             }];
                
                NSMutableDictionary *params = [requestParams mutableCopy];
                params[YYBaseRequestManagerRequestId] = @(requestId);
                
                [self afterRequestWithParams:params];
                
                return requestId;
                
            } else {
                
                self.errorType = YYBaseRequestManagerErrorTypeNoNetWork;
                [self requestFailedWithResponse:nil];
                
                return requestId;
            }
            
        } else {
            
            self.errorType = YYBaseRequestManagerErrorTypeParamsFormat;
            [self requestFailedWithResponse:nil];
            
            return requestId;
        }
    }
    
    return requestId;
}

- (BOOL)loadDataFromNative {
    
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:[[NSUserDefaults standardUserDefaults] dataForKey:self.child.methodName] options:0 error:NULL];
    
    if (result == nil) {
        
        return NO;
    }
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        YYResponse *response = [[YYResponse alloc] initContainCacheWithData:[NSJSONSerialization dataWithJSONObject:result options:0 error:NULL]];
        
        [strongSelf requestSuccessedWithResponse:response];
    });
    
    return YES;
}

- (BOOL)shouldCacheByParent {
    
    if ([self.child respondsToSelector:@selector(shouldCacheByChild)] &&
        [self.child shouldCacheByChild]) {
        
        return [self.child shouldCacheByChild];
    } else {
        
        return [YYNetConfig sharedInstance].shouldCache;
    }
}

- (BOOL)hasCacheWithParams:(NSDictionary *)params {
    
    NSString *serviceIdentifier = self.child.serviceIdentifier;
    NSString *methodName = self.child.methodName;
    
    NSData *result = [self.cache fetchCachedDataWithServiceIdentifier:serviceIdentifier methodName:methodName requestParams:params];
    
    if (result == nil) {
        
        return NO;
    }
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        
        __strong typeof (weakSelf) strongSelf = weakSelf;
        
        YYResponse *response = [[YYResponse alloc] initContainCacheWithData:result];
        response.requestParams = params;
        
        [YYRequestLogger logDebugInfoWithCachedResponse:response
                                             methodName:methodName
                                      serviceIdentifier:[[YYServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier]];
        
        [strongSelf requestSuccessedWithResponse:response];
    });
    
    return YES;
}

- (void)removeRequestId:(NSInteger)requestId {
    
    NSNumber *requestIdToRemove = nil;
    for (NSNumber *storedRequestId in self.requestIdList) {
        
        if ([storedRequestId integerValue] == requestId) {
            
            requestIdToRemove = storedRequestId;
        }
    }
    
    if (requestIdToRemove) {
        
        [self.requestIdList removeObject:requestIdToRemove];
    }
}

#pragma mark - YYBaseRequestManagerCallBackDelegate

- (void)requestSuccessedWithResponse:(YYResponse *)response {
    
    self.isLoading = NO;
    self.response = response;
    
    self.errorType = YYBaseRequestManagerErrorTypeSuccess;
    
    if ([self.child respondsToSelector:@selector(shouldLoadFromNative)] &&
        [self.child shouldLoadFromNative] &&
        !response.isCache) {
        
        [[NSUserDefaults standardUserDefaults] setObject:response.responseData forKey:[self.child methodName]];
    }
    
    if (response.content) {
        
        self.fetchedRawData = [response.content copy];
    } else {
        
        self.fetchedRawData = [response.responseData copy];
    }
    
    [self removeRequestId:response.requestId];
    if ([self validatorAfterRequestWithData:response.content]) {
        
        if ([self shouldCacheByParent] && !response.isCache) {
            
            [self.cache saveCacheWithData:response.responseData serviceIdentifier:self.child.serviceIdentifier methodName:self.child.methodName requestParams:response.requestParams];
        }
        
        if ([self beforePerformSuccessWithResponse:response]) {
            
            if ([self.delegate respondsToSelector:@selector(requestDidSuccessWithManager:)]) {
                
                [self.delegate requestDidSuccessWithManager:self];
            } else {
                
                NSAssert(NO, @"请实现requestDidSuccessWithManager代理方法");
            }
        }
        
        [self afterPerformSuccessWithResponse:response];
    } else {
        
        self.errorType = YYBaseRequestManagerErrorTypeResponseFormat;
        [self requestFailedWithResponse:response];
    }
}

- (void)requestFailedWithResponse:(YYResponse *)response {
    
    self.isLoading = NO;
    self.response = response;
    
    NSString *serviceIdentifier = self.child.serviceIdentifier;
    YYService *service = [[YYServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];
    
    BOOL needCallBack = YES;
    if ([service.child respondsToSelector:@selector(requestFailedComonHandle:)]) {
        
        needCallBack = [service.child requestFailedComonHandle:response];
    }
    
    //由service决定是否结束回调
    if (!needCallBack) {
        
        self.errorType = YYBaseRequestManagerErrorTypeServiceFailed;
        
        return ;
    }
    
    [self removeRequestId:response.requestId];
    
    if (response.content) {
        
        self.fetchedRawData = [response.content copy];
    } else {
        
        self.fetchedRawData = [response.responseData copy];
    }
    
    if ([self beforePerformFailWithResponse:response]) {
        
        if ([self.delegate respondsToSelector:@selector(requestDidFailedWithManager:)]) {
            
            [self.delegate requestDidFailedWithManager:self];
        } else {
            
            NSAssert(NO, @"请实现requestDidFailedWithManager代理方法");
        }
    }
    
    [self afterPerformFailWithResponse:response];
}

#pragma mark - YYBaseRequestManagerInterceptor

- (BOOL)beforeRequestWithParams:(NSDictionary *)params {
    
    if ([self.interceptor respondsToSelector:@selector(manager:beforeRequestWithParams:)]) {
        
        return [self.interceptor manager:self beforeRequestWithParams:params];
    } else {
        
        return YES;
    }
}

- (void)afterRequestWithParams:(NSDictionary *)params {
    
    if ([self.interceptor respondsToSelector:@selector(manager:afterRequestWithParams:)]) {
        
        [self.interceptor manager:self afterRequestWithParams:params];
    }
}


- (BOOL)beforePerformSuccessWithResponse:(YYResponse *)response {
    
    if ([self.interceptor respondsToSelector:@selector(manager: beforePerformSuccessWithResponse:)]) {
        
        return [self.interceptor manager:self beforePerformSuccessWithResponse:response];
    } else {
        
        return YES;
    }
}

- (void)afterPerformSuccessWithResponse:(YYResponse *)response {
    
    if ([self.interceptor respondsToSelector:@selector(manager:afterPerformSuccessWithResponse:)]) {
        
        [self.interceptor manager:self afterPerformSuccessWithResponse:response];
    }
}

- (BOOL)beforePerformFailWithResponse:(YYResponse *)response {
    
    if ([self.interceptor respondsToSelector:@selector(manager:beforePerformFailWithResponse:)]) {
        
        return [self.interceptor manager:self beforePerformFailWithResponse:response];
    } else {
        
        return YES;
    }
}

- (void)afterPerformFailWithResponse:(YYResponse *)response {
    
    if ([self.interceptor respondsToSelector:@selector(manager:afterPerformFailWithResponse:)]) {
        
        [self.interceptor manager:self afterPerformFailWithResponse:response];
    }
}

#pragma mark - YYBaseRequestManagerValidator

- (BOOL)validatorBeforeRequestWithParams:(NSDictionary *)params {
 
    if ([self.validator respondsToSelector:@selector(manager:isCorrectWithParamsData:)]) {
        
        return [self.validator manager:self isCorrectWithParamsData:params];
    } else {
        
        return YES;
    }
}

- (BOOL)validatorAfterRequestWithData:(NSDictionary *)data {
    
    if ([self.validator respondsToSelector:@selector(manager:isCorrectWithCallBackData:)]) {
        
        return [self.validator manager:self isCorrectWithCallBackData:data];
    } else {
        
        return YES;
    }
}



#pragma mark - getters and setters

- (YYRequestCache *)cache {
    
    if (_cache == nil) {
        
        _cache = [YYRequestCache sharedInstance];
    }
    
    return _cache;
}

- (NSMutableArray *)requestIdList {
    
    if (_requestIdList == nil) {
        
        _requestIdList = [[NSMutableArray alloc] init];
    }
    
    return _requestIdList;
}

- (BOOL)isReachable {
    
    BOOL isReachability = [YYNetConfig sharedInstance].isReachable;
    
    if (!isReachability) {
        
        self.errorType = YYBaseRequestManagerErrorTypeNoNetWork;
    }
    
    return isReachability;
}

- (BOOL)isLoading {
    
    if (self.requestIdList.count == 0) {
        
        _isLoading = NO;
    }
    
    return _isLoading;
}

@end
