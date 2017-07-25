//
//  YYRequestCacheObject.h
//  YYProjectNew
//
//  Created by yangyh on 2017/1/21.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 缓存主体类，服务于YYRequestCache
 */
@interface YYRequestCacheObject : NSObject

@property (nonatomic, assign, readonly) BOOL isOutdated;//缓存是否过期
@property (nonatomic, assign, readonly) BOOL isEmpty;//缓存是否为空

@property (nonatomic, copy, readonly) NSData *content;//缓存数据


/**
 更新缓存数据和更新缓存时间

 @param content 缓存数据
 */
- (void)updateContent:(NSData *)content;

@end
