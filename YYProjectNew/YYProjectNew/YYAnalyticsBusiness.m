//
//  YYAnalyticsBusiness.m
//  YYProjectNew
//
//  Created by yangyh on 2017/1/18.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import "YYAnalyticsBusiness.h"

@interface YYAnalyticsBusiness() 

@end

@implementation YYAnalyticsBusiness

- (void)viewWillAppearHandleWithViewController:(UIViewController *)viewController {
    
    NSString *className = NSStringFromClass([viewController class]);
    DLog(@"进入 %@ 控制器",className);
}

- (void)viewWillDisappearHandleWithViewController:(UIViewController *)viewController {
    
    NSString *className = NSStringFromClass([viewController class]);
    DLog(@"离开 %@ 控制器",className);
}

- (void)viewDeallocHandleWithViewController:(UIViewController *)viewController {
    
    NSString *className = NSStringFromClass([viewController class]);
    DLog(@"%@ 控制器被释放了",className);
}

@end
