//
//  YYViewDidLoadBusiness.m
//  YYProjectNew
//
//  Created by yangyh on 2017/1/19.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import "YYViewDidLoadBusiness.h"
#import "YYViewController.h"

@implementation YYViewDidLoadBusiness

- (void)viewDidLoadHandleWithViewController:(UIViewController *)viewController {
    
//    if ([viewController isKindOfClass:[YYViewController class]]) {
//        
//        return ;
//    }
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [[leftButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
       
        [viewController.navigationController popViewControllerAnimated:YES];
    }];
    
    leftButton.frame = CGRectMake(0, 0, 18, 32);
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    viewController.navigationItem.leftBarButtonItem = backItem;
}

@end
