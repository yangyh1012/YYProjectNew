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
#import "YYNetwork.h"
#import "NSString+YYMD5.h"
#import "NSString+MD5_Base64.h"
#import "NSString+YYRandomString.h"

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
    [[YYRSA sharedInstance] loadPublicKeyFromFile:[[NSBundle mainBundle] pathForResource:@"public_key" ofType:@"der"]];
    [[YYRSA sharedInstance] loadPrivateKeyFromFile:[[NSBundle mainBundle] pathForResource:@"private_key" ofType:@"p12"] password:@"123456"];
    NSString *rsaEncrypttion = [[YYRSA sharedInstance] rsaEncryptString:clearText];
    DLog(@"rsa加密: %@",rsaEncrypttion);
    DLog(@"rsa解密: %@",[[YYRSA sharedInstance] rsaDecryptString:rsaEncrypttion]);
    
    [self paramEncryptionTest1];
    [self paramEncryptionTest2];
    [self paramEncryptionTest3];
}

- (void)paramEncryptionTest1 {
    
    //demo1
    NSMutableString *token = [[NSMutableString alloc] init];
    
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    long long timeNumber = ([[NSNumber numberWithDouble:time] longLongValue]) * 1000;
    [token appendFormat:@"%lld", timeNumber];
    
    int randomNumber = arc4random() % 100000;
    [token appendFormat:@"_%d", randomNumber];
    
    NSString *desEncrypttion = [token encryptWithKey:@"YYProjectNew"];
    
    DLog(@"token:%@",desEncrypttion);
}

- (void)paramEncryptionTest2 {
    
    //demo2
    NSString *requestVersion = @"V3";
    NSString *methodName = @"detailInfo";
    NSDictionary *allParams = @{@"name":@"kk3",@"detail":@"没有数据",@"sex":@"男"};
    NSString *privateKey = @"YYProjectNew";
    
    NSString *part1 = [NSString stringWithFormat:@"%@/%@", requestVersion, methodName];
    NSString *part2 = [allParams network_urlParamsStringShouldSignature:YES];
    NSString *part3 = privateKey;
    
    NSString *beforeSign = [NSString stringWithFormat:@"%@%@%@", part1, part2, part3];
    
    DLog(@"md5后：%@",[beforeSign codeMD5]);
}

- (void)paramEncryptionTest3 {

    //demo3
    NSString *words = [NSString returnRandomStringWithBitInt:16];
    NSString *rsaKey = [[YYRSA sharedInstance] rsaEncryptString:words];
    
    NSDictionary *allParams = @{@"name":@"kk3",@"detail":@"没有数据",@"sex":@"男"};
    
    {
        NSMutableArray *result = [[NSMutableArray alloc] init];
        [allParams enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            
            [result addObject:key];
        }];
        NSArray *sortedResult = [result sortedArrayUsingSelector:@selector(compare:)];
        
        NSString *md5Str = @"";
        for (NSString *data in sortedResult) {
            
            md5Str = [NSString stringWithFormat:@"%@%@",md5Str,data];
        }
        NSString *signData = [md5Str md5_base64];
        
        NSMutableDictionary *allParamsMutable = [allParams mutableCopy];
        [allParamsMutable setObject:signData forKey:@"signData"];
        
        allParams = [allParamsMutable copy];
    }
    
    NSString *allParamsStr = [allParams network_jsonString];
    NSString *allParamsAESStr = [allParamsStr AES128EncryptWithKey:words];
    
    NSDictionary *lastParams = @{@"key":rsaKey,@"value":allParamsAESStr};
    
    DLog(@"value：%@",lastParams);
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
