//
//  YYLifeCycleProtocol.h
//  YYProjectNew
//
//  Created by yangyh on 2017/1/21.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import <Foundation/Foundation.h>

//IOP，面向接口编程
@protocol YYLifeCycleProtocol <NSObject>

@optional

/**
 视图即将出现时调用此方法
 
 @param viewController 控制器
 */
- (void)viewWillAppearHandleWithViewController:(UIViewController *)viewController;


/**
 视图即将消失时调用此方法
 
 @param viewController 控制器
 */
- (void)viewWillDisappearHandleWithViewController:(UIViewController *)viewController;

/**
 控制器即将释放时调用此方法
 
 @param viewController 控制器
 */
- (void)viewDeallocHandleWithViewController:(UIViewController *)viewController;

/**
 视图加载完成后调用此方法
 
 @param viewController 控制器
 */
- (void)viewDidLoadHandleWithViewController:(UIViewController *)viewController;

@end
