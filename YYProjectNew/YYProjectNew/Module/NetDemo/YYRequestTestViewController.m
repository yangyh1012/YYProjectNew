//
//  YYRequestTestViewController.m
//  YYProjectNew
//
//  Created by yangyh on 2017/7/26.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import "YYRequestTestViewController.h"
#import "YYTestManager.h"

@interface YYRequestTestViewController ()<YYBaseRequestManagerCallBackDelegate,YYBaseRequestManagerParamSource>
///<YYBaseRequestManagerInterceptor>

@property (nonatomic, strong) UIButton *requestButton;

@property (nonatomic, strong) UILabel *tipLabel;

@property (nonatomic, strong) YYTestManager *testManager;

@end

@implementation YYRequestTestViewController

#pragma mark - life cycle 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.requestButton];
    [self.view addSubview:self.tipLabel];
    
    [self layoutOtherSubviews1];
    [self eventResponsHandle1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - event response 事件响应包括手势和按钮等

- (void)eventResponsHandle1 {
    
    @weakify(self);
    [[self.requestButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        @strongify(self);
        
        [self.testManager loadData];
    }];
}

#pragma mark - YYBaseRequestManagerParamSource

- (NSDictionary *)paramsForRequestWithManager:(YYBaseRequestManager *)manager {
    
    if (manager == self.testManager) {
        
        return @{};
    }
    
    return @{};
}

#pragma mark - YYBaseRequestManagerCallBackDelegate

- (void)requestDidSuccessWithManager:(YYBaseRequestManager *)manager {
    
    if (manager == self.testManager) {
        
        DLog(@"%@", [manager fetchDataWithReformer:nil]);
    }
}

- (void)requestDidFailedWithManager:(YYBaseRequestManager *)manager {
    
    if (manager == self.testManager) {
        
        DLog(@"%@", [manager fetchDataWithReformer:nil]);
    }
}

//#pragma mark - YYBaseRequestManagerInterceptor
//
//- (BOOL)manager:(YYBaseRequestManager *)manager beforeRequestWithParams:(NSDictionary *)params {
//    
//    self.tipLabel.text = @"开始请求";
//    
//    return YES;
//}
//
//- (BOOL)manager:(YYBaseRequestManager *)manager beforePerformSuccessWithResponse:(YYResponse *)response {
//    
//    self.tipLabel.text = @"请求成功";
//    
//    return YES;
//}
//
//- (BOOL)manager:(YYBaseRequestManager *)manager beforePerformFailWithResponse:(YYResponse *)response {
//    
//    self.tipLabel.text = @"请求失败";
//    
//    return YES;
//}

#pragma mark - view layout 子视图的布局

- (void)layoutOtherSubviews1 {
    
    @weakify(self);
    [self.requestButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        @strongify(self);
        
        //链式编程
        make.centerY.equalTo(self.view);
        make.centerX.equalTo(self.view);
        make.width.equalTo(@100);
        make.height.equalTo(@100);
    }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        @strongify(self);
        
        //链式编程
        make.centerY.equalTo(self.requestButton).offset(20);
        make.centerX.equalTo(self.requestButton);
    }];
}

#pragma mark - getters and setters 构造器

- (UIButton *)requestButton {
    
    if (_requestButton == nil) {
        
        _requestButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_requestButton setBackgroundImage:[UIImage imageNamed:@"btn_common"] forState:UIControlStateNormal];
    }
    
    return _requestButton;
}

- (UILabel *)tipLabel {
    
    if (_tipLabel == nil) {
        
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.font = [UIFont systemFontOfSize:13.0f];
        [_tipLabel setText:@"还没开始请求"];
    }
    
    return _tipLabel;
}

- (YYTestManager *)testManager {
    
    if (_testManager == nil) {
        
        _testManager = [[YYTestManager alloc] init];
        _testManager.delegate = self;
        _testManager.paramSource = self;
//        _testManager.interceptor = self;
    }
    
    return _testManager;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
