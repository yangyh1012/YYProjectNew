//
//  YYTestManager.m
//  YYProjectNew
//
//  Created by yangyh on 2017/1/25.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import "YYTestManager.h"
#import "YYRequestConst.h"

@implementation YYTestManager

- (NSString *)serviceIdentifier {
    
    return YYTestServiceV1;
}

- (NSString *)methodName {
    
    return @"/app/login/home";
}

- (YYNetworkRequestType)requestType {
    
    return YYNetworkRequestTypeGet;
}

@end
