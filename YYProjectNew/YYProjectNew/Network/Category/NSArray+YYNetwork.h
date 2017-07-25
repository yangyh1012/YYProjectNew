//
//  NSArray+YYNetwork.h
//  YYProjectNew
//
//  Created by yangyh on 2017/1/21.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (YYNetwork)


/**
 将数组中的每个字符串进行拼接

 @return 拼接后的字符串
 */
- (NSString *)network_paramsString;


/**
 数组转json

 @return json字符串
 */
- (NSString *)network_jsonString;

@end
