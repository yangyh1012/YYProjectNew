//
//  Target_Detail.m
//  YYProjectNew
//
//  Created by yangyh on 2017/8/1.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import "Target_Detail.h"
#import "YYDetailViewController.h"

@implementation Target_Detail

- (UIViewController *)Action_DetailViewControllerNativeFetch:(NSDictionary *)params {
    
    YYDetailViewController *viewController = [[YYDetailViewController alloc] init];
    viewController.valueLabel.text = params[@"key"];
    return viewController;
}

@end
