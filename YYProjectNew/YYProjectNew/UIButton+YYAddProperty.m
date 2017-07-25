//
//  UIButton+YYAddProperty.m
//  YYProjectNew
//
//  Created by yangyh on 2017/1/21.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import "UIButton+YYAddProperty.h"
#import <objc/runtime.h>

static void *buttonNameForYYStatic;

@implementation UIButton (YYAddProperty)

- (void)setButtonNameForYY:(NSString *)buttonNameForYY {
    
    //Method Swizzling
    objc_setAssociatedObject(self, &buttonNameForYYStatic, buttonNameForYY, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)buttonNameForYY {
    
    return objc_getAssociatedObject(self, &buttonNameForYYStatic);
}

@end
