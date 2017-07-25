//
//  YYDataConfigBusiness.h
//  YYProjectNew
//
//  Created by yangyh on 2017/1/18.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYDataConfigProtocol.h"

@interface YYDataConfigBusiness : NSObject<YYDataConfigProtocol>

+ (instancetype)sharedInstance;

@end
