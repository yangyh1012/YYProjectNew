//
//  ViewController.m
//  YYProjectNew
//
//  Created by yangyh on 2017/1/17.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import "YYViewController.h"
#import "YYControllerConvert.h"
#import "YYProjectNew-Swift.h"

@interface YYViewController ()

@property (nonatomic, strong) UIButton *testButton;

@end

@implementation YYViewController

#pragma mark - life cycle 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /*
     
     代码复用查看：YYReuseCodeViewController
     网络例子查看：YYRequestTestViewController
     
     */
    
    
    
    [self.view addSubview:self.testButton];
    [self layoutOtherSubviews];
    [self eventResponsHandle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - event response 事件响应包括手势和按钮等

- (void)eventResponsHandle {
    
    //响应式编程
    @weakify(self);
    [[self.testButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
       
        @strongify(self);
        YYControllerConvert *controller = [[YYControllerConvert alloc] init];
        id requestController = [controller controllerConvertWithType:YYProjectNew_FirstViewController];
        [self.navigationController pushViewController:requestController animated:YES];
    }];
}

#pragma mark - view layout 子视图的布局

- (void)layoutOtherSubviews {
    
    @weakify(self);
    [self.testButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        @strongify(self);
        
        //链式编程
        make.centerY.equalTo(self.view);
        make.centerX.equalTo(self.view);
        make.width.equalTo(@100);
        make.height.equalTo(@100);
    }];
}

#pragma mark - getters and setters 构造器

- (UIButton *)testButton {
    
    if (_testButton == nil) {
        
        _testButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_testButton setBackgroundImage:[UIImage imageNamed:@"btn_common"] forState:UIControlStateNormal];
    }
    
    return _testButton;
}

@end


