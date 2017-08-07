//
//  YYSecondViewController.h
//  YYProjectNew
//
//  Created by yangyh on 2017/1/21.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYDataConfigProtocol.h"

@protocol YYReuseCodeViewControllerTestDelegate <NSObject>

@required

- (void)testDelegateHandle:(id)object;

@optional

@end

typedef NS_ENUM(NSInteger, YYReuseCodeViewControllerTestType) {
    
    YYReuseCodeViewControllerTestTypeFirst = 0,
    YYReuseCodeViewControllerTestTypeSecond,
};

@interface YYReuseCodeViewController : UIViewController

@property (nonatomic, weak) id <YYReuseCodeViewControllerTestDelegate> testDelegate;

@property (nonatomic, assign) YYReuseCodeViewControllerTestType baseViewControllerTestType;

@end

//控制器模块分类原则
#pragma mark - life cycle 生命周期
#pragma mark - event response 事件响应包括手势和按钮等
#pragma mark - delegate 具体到某个delegate，比如UITableViewDelegate
#pragma mark - request 请求处理
#pragma mark - database 数据库处理
#pragma mark - public method 公共方法
#pragma mark - private method 业务无关的尽量弄成category，方便别人调用
#pragma mark - view layout 子视图的布局
#pragma mark - getters and setters 构造器

//其他类模块分类原则
#pragma mark - life cycle
#pragma mark - public method
#pragma mark - private method
#pragma mark - delegate
#pragma mark - getters and setters

@interface YYAnotherTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *sexLabel;

@property (nonatomic, strong) UIImageView *headImageView;

@end
