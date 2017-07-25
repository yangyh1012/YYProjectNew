//
//  YYService.m
//  YYProjectNew
//
//  Created by yangyh on 2017/1/22.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import "YYService.h"
#import "YYNetConfig.h"

@interface YYService()

@property (nonatomic, weak) id<YYServiceProtocol> child;

@end

@implementation YYService

#pragma mark - life cycle

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        if ([self conformsToProtocol:@protocol(YYServiceProtocol)]) {
            
            self.child = (id <YYServiceProtocol>)self;
            
        } else {
            
            self.child = (id <YYServiceProtocol>)self;
            NSException *exception = [[NSException alloc] initWithName:@"提示" reason:[NSString stringWithFormat:@"%@没有遵循YYServiceProtocol协议",self.child] userInfo:nil];
            
            @throw exception;
        }
    }
    
    return self;
}

- (BOOL)isOnlineByParent {
    
    if ([self.child respondsToSelector:@selector(isOnlineByChild)] &&
        [self.child isOnlineByChild]) {
        
        return [self.child isOnlineByChild];
    } else {
        
        return [YYNetConfig sharedInstance].serviceIsOnline;
    }
}

#pragma mark - getters and setters

- (NSString *)privateKey {
    
    return [self isOnlineByParent] ? self.child.onlinePrivateKey : self.child.offlinePrivateKey;
}

- (NSString *)publicKey {
    
    return [self isOnlineByParent] ? self.child.onlinePublicKey : self.child.offlinePublicKey;
}

- (NSString *)requestBaseUrl {
    
    return [self isOnlineByParent] ? self.child.onlineRequestBaseUrl : self.child.offlineRequestBaseUrl;
}

- (NSString *)requestVersion {
    
    return [self isOnlineByParent] ? self.child.onlineRequestVersion : self.child.offlineRequestVersion;
}

@end
