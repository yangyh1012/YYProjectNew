//
//  NSObject+YYNetwork.h
//  YYProjectNew
//
//  Created by yangyh on 2017/1/21.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (YYNetwork)

/**
 对符合条件的数据返回本身，对不符合条件的数据返回默认值
 
 @param defaultData 默认值
 @return 返回本身或者默认值
 */
- (id)network_defaultValue:(id)defaultData;


/**
 判断是否为空，是否为NSNull、是否是长度为0的字符串，是否是count为0的数组或字典。

 @return YES则为空
 */
- (BOOL)network_isEmptyObject;

@end
