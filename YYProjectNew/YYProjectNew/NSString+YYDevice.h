//
//  NSString+YYDevice.h
//  YYProjectNew
//
//  Created by yangyh on 2017/1/21.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YYDevice)

/**
 判断iPhone型号
 
 @return iPhone型号
 */
+ (NSString *)iPhoneModel;


/**
 判断平台
 
 @return 平台
 */
+ (NSString *)platform;

@end
