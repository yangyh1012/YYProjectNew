//
//  YYControllerConvert.m
//  YYProjectNew
//
//  Created by yangyh on 2017/7/31.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import "YYControllerConvert.h"

@implementation YYControllerConvert

- (UIViewController *)controllerConvertWithType:(YYControllerConvertType)type {
    
    UIViewController *controllerConvert = nil;
    
    NSString *typeString = nil;
    if (type == YYReuseCodeViewController) {
        
        typeString = @"YYReuseCodeViewController";
    } else if (type == YYRequestTestViewController) {
        
        typeString = @"YYRequestTestViewController";
    } else if (type == YYEncryptTestViewController) {
        
        typeString = @"YYEncryptTestViewController";
    } else if (type == YYRuntimeTestViewController) {
        
        typeString = @"YYRuntimeTestViewController";
    } else if (type == YYProjectNew_FirstViewController) {
        
        typeString = @"YYProjectNew.FirstViewController";
    }
    
    controllerConvert = [[NSClassFromString(typeString) alloc] init];
    
    return controllerConvert;
}

@end
