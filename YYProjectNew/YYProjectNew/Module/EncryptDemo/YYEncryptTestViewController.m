//
//  YYEncryptTestViewController.m
//  YYProjectNew
//
//  Created by yangyh on 2017/7/28.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import "YYEncryptTestViewController.h"
#import "NSString+YYBase64.h"
#import "NSString+YYDES.h"
#import "NSString+YYAES128.h"
#import "NSString+YYAES256.h"
#import "YYRSA.h"

@interface YYEncryptTestViewController ()

@end

@implementation YYEncryptTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *clearText = @"YYProjectNew";
    NSString *key = @"qwerty";
    
    //demo 1
    NSString *base64code = [clearText encodeBase64];
    DLog(@"base64编码: %@",base64code);
    DLog(@"base64解码: %@",[base64code decodeBase64]);
    
    //demo 2
    NSString *desEncrypttion = [clearText encryptWithKey:key];
    DLog(@"des加密: %@",desEncrypttion);
    DLog(@"des解密: %@",[desEncrypttion decryptWithKey:key]);
    
    //demo 3
    NSString *aes128Encrypttion = [clearText AES128EncryptWithKey:key];
    DLog(@"aes128加密: %@",aes128Encrypttion);
    DLog(@"aes128解密: %@",[aes128Encrypttion AES128DecryptWithKey:key]);
    
    //demo 4
    NSString *aes256Encrypttion = [clearText AES256EncryptWithKey:key];
    DLog(@"aes256加密: %@",aes256Encrypttion);
    DLog(@"aes256解密: %@",[aes256Encrypttion AES256DecryptWithKey:key]);
    
    //demo 5
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
