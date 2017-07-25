//
//  YYServiceFactory.m
//  YYProjectNew
//
//  Created by yangyh on 2017/1/22.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import "YYServiceFactory.h"

@interface YYServiceFactory ()

@property (nonatomic, strong) NSMutableDictionary *serviceStorage;//服务表

@end

@implementation YYServiceFactory

#pragma mark - life cycle

+ (instancetype)sharedInstance {
    
    static dispatch_once_t onceToken;
    
    static YYServiceFactory *sharedInstance;
    dispatch_once(&onceToken, ^{
        
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

#pragma mark - public methods

- (YYService<YYServiceProtocol> *)serviceWithIdentifier:(NSString *)identifier {
    
    NSAssert(self.dataSource, @"必须有dataSource绑定并实现serviceInfos方法，否则无法正常使用service模块");
    
    if (self.serviceStorage[identifier] == nil) {
        
        self.serviceStorage[identifier] = [self newServiceWithIdentifier:identifier];
    }
    
    return self.serviceStorage[identifier];
}

#pragma mark - private methods

- (YYService<YYServiceProtocol> *)newServiceWithIdentifier:(NSString *)identifier {
    
    NSAssert([self.dataSource respondsToSelector:@selector(serviceInfos)], @"请实现YYServiceFactoryDataSource的serviceInfos方法");
    
    if ([[self.dataSource serviceInfos] valueForKey:identifier]) {
        
        NSString *classStr = [[self.dataSource serviceInfos] valueForKey:identifier];
        id service = [[NSClassFromString(classStr) alloc] init];
        
        NSAssert(service, [NSString stringWithFormat:@"无法创建service，请检查serviceInfos提供的数据是否正确"],service);
        NSAssert([service conformsToProtocol:@protocol(YYServiceProtocol)], @"你提供的Service没有遵循YYServiceProtocol");
        
        return service;
        
    } else {
        
        NSAssert(NO, @"serviceInfos无法匹配identifier");
    }
    
    return nil;
}

#pragma mark - getters and setters

- (NSMutableDictionary *)serviceStorage {
    
    if (_serviceStorage == nil) {
        
        _serviceStorage = [[NSMutableDictionary alloc] init];
    }
    
    return _serviceStorage;
}

@end
