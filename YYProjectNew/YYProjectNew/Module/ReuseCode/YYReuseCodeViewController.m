//
//  YYSecondViewController.m
//  YYProjectNew
//
//  Created by yangyh on 2017/1/21.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import "YYReuseCodeViewController.h"
#import "NSObject+YYSharedInstance.h"

@interface YYReuseCodeViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
///<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation YYReuseCodeViewController

#pragma mark - life cycle 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /*
     
     界面编写原则
     
     对于复杂的、动态生成的界面，建议使用手工编写界面，使用Masonry。
     对于需要统一风格的按钮或UI控件，为了方便之后的修改和复用，使用Masonry。
     对于需要有继承或组合关系的 UIView 类或 UIViewController 类，可以用单个Storyboard
     对于那些简单的、静态的、非核心功能界面，可以用公共的Storyboard
     对于Storyboard里面的事件响应，统一使用ReactiveCocoa,彩色颜色的设值不要放在Storyboard
     
     */
    
    BOOL flag = NO;
    
    if (flag) {
        
        [self.view addSubview:self.tableView];
        [self.view addSubview:self.collectionView];
        
        [self layoutOtherSubviews];
        [self eventResponsHandle];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    BOOL flag = NO;
    if (flag) {
        
        //响应式编程
        
        //注册键盘出现通知
        [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(NSNotification * _Nullable notification) {
            
            NSDictionary *info = [notification userInfo];
            
            /*说明：UIKeyboardFrameEndUserInfoKey获得键盘的尺寸，键盘高度
             
             */
            NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
            CGSize keyboardSize = [value CGRectValue].size;
            
            DLog(@"%.f",keyboardSize.height);
        }];
        
        //注册键盘隐藏通知
        [[[NSNotificationCenter defaultCenter]  rac_addObserverForName:UIKeyboardWillHideNotification object:nil] subscribeNext:^(NSNotification * _Nullable notification) {
            
            NSDictionary *info = [notification userInfo];
            
            /*说明：UIKeyboardFrameEndUserInfoKey获得键盘的尺寸，键盘高度
             
             */
            NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
            CGSize keyboardSize = [value CGRectValue].size;
            
            DLog(@"%.f",keyboardSize.height);
        }];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - event response 事件响应包括手势和按钮等

- (void)eventResponsHandle {
 
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    static NSString *CellIdentifier = @"CellIdentifier";
    YYAnotherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //设置单元格不可点击
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //设置单元格线条占满宽度
    //    [cell setLayoutMargins:UIEdgeInsetsZero];
    //    [cell setSeparatorInset:UIEdgeInsetsZero];
    
    DLog(@"row:%@",@(row));
    DLog(@"section:%@",@(section));
    
    id<YYDataConfigProtocol> service = [NSClassFromString(DataConfigBusiness) sharedInstance];
    [service dataConfigWithContainer:cell data:@{@"name":@"Smith",
                                                 @"sex":@"0",
                                                 @"headUrl":@"http://img.sootuu.com/vector/200801/070/0151.jpg"}];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    DLog(@"row:%@",@(row));
    DLog(@"section:%@",@(section));
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//
//    return 5;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//
//    return 5;
//}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger item = indexPath.item;
    NSInteger section = indexPath.section;
    
    static NSString *CellIdentifier = @"CellIdentifier";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    DLog(@"item:%@",@(item));
    DLog(@"section:%@",@(section));
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger item = indexPath.item;
    NSInteger section = indexPath.section;
    
    DLog(@"item:%@",@(item));
    DLog(@"section:%@",@(section));
}

#pragma mark - view layout 子视图的布局

- (void)layoutOtherSubviews {
    
    UICollectionViewFlowLayout *collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    collectionViewFlowLayout.itemSize = CGSizeMake((self.view.frame.size.width - 65.0f) / 3.0f, 85.0f);
    collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    collectionViewFlowLayout.minimumLineSpacing = 10;
    collectionViewFlowLayout.minimumInteritemSpacing = 0;
    collectionViewFlowLayout.sectionInset = UIEdgeInsetsZero;
    
    self.collectionView.collectionViewLayout = collectionViewFlowLayout;
}

#pragma mark - getters and setters 构造器

- (UITableView *)tableView {
    
    if (_tableView == nil) {
        
        //若连接storyboard时，无需初始化
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        //不要分割线
        //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        //去掉多余的分割线
        _tableView.tableFooterView = [[UIView alloc] init];
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
    }
    
    return _tableView;
}

- (UICollectionView *)collectionView {
    
    if (_collectionView == nil) {
        
        //若连接storyboard时，无需初始化
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    
    return _collectionView;
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

@interface YYAnotherTableViewCell ()


@end

@implementation YYAnotherTableViewCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
