//
//  YYDataConfigBusiness.m
//  YYProjectNew
//
//  Created by yangyh on 2017/1/18.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import "YYDataConfigBusiness.h"
#import "YYReuseCodeViewController.h"

@implementation YYDataConfigBusiness

+ (instancetype)sharedInstance {
    
    static YYDataConfigBusiness *sharedInstance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (void)dataConfigWithContainer:(id)container data:(id)data {
    
    if ([container isKindOfClass:[YYAnotherTableViewCell class]]) {
        
        YYAnotherTableViewCell *cell = container;
        
        cell.nameLabel.text = data[@"name"];
        
        cell.sexLabel.text = [data[@"sex"] integerValue] ? @"男":@"女";

        [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:data[@"headUrl"]]];
    }
}

@end
