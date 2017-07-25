//
//  PrefixHeader.h
//  YYProjectNew
//
//  Created by yangyh on 2017/1/17.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#ifndef PrefixHeader_h
#define PrefixHeader_h

#ifdef __OBJC__

    #import "Masonry.h"
    #import <ReactiveObjC/ReactiveObjC.h>
    #import <SDWebImage/UIImageView+WebCache.h>
    #import <SDWebImage/UIButton+WebCache.h>

    #import "NSString+YYEmpty.h"

    #import "YYBussinessConstants.h"

#endif

#ifdef DEBUG
    #ifndef DLog
        #   define DLog(fmt, ...) {NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}
    #endif
    #ifndef ELog
        #   define ELog(err) {if(err) DLog(@"%@", err)}
    #endif
#else
    #ifndef DLog
        #   define DLog(...)
    #endif
    #ifndef ELog
        #   define ELog(err)
    #endif
#endif


#endif /* PrefixHeader_h */
