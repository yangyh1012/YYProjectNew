//
//  YYControllerConvert.h
//  YYProjectNew
//
//  Created by yangyh on 2017/7/31.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, YYControllerConvertType) {
    
    YYReuseCodeViewController,
    YYRequestTestViewController,
    YYEncryptTestViewController,
    YYRuntimeTestViewController,
    YYProjectNew_FirstViewController,
};

@interface YYControllerConvert : NSObject

- (UIViewController *)controllerConvertWithType:(YYControllerConvertType)type;

@end
