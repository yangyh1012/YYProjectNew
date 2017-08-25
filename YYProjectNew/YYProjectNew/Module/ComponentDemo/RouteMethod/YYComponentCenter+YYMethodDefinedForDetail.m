//
//  YYComponentCenter+YYMethodDefinedForDetail.m
//  YYProjectNew
//
//  Created by yangyh on 2017/8/1.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import "YYComponentCenter+YYMethodDefinedForDetail.h"

NSString * const TargetDetail = @"Detail";

NSString * const DetailViewControllerNativFetch = @"DetailViewControllerNativeFetch";

@implementation YYComponentCenter (YYMethodDefinedForDetail)

- (UIViewController *)YYComponentCenter_viewControllerForDetail {
    
    UIViewController *viewController = [self openLocalWithModule:TargetDetail
                                                          action:DetailViewControllerNativFetch
                                                          params:@{@"key":@"value"}
                                               shouldCacheModule:NO];
    
    if ([viewController isKindOfClass:[UIViewController class]]) {
        
        // view controller 交付出去之后，可以由外界选择是push还是present
        return viewController;
    } else {
        
        // 这里处理异常场景，具体如何处理取决于产品
        return [[UIViewController alloc] init];
    }
}

@end
