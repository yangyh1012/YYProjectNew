//
//  NSString+YYDevice.m
//  YYProjectNew
//
//  Created by yangyh on 2017/1/21.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import "NSString+YYDevice.h"
#import "sys/utsname.h"

@implementation NSString (YYDevice)

+ (NSString *)platform {
    
    NSString *model = [NSString iPhoneModel];
    if ([model hasPrefix:@"Apple Watch"]) {
        
        return @"Apple Watch";
    } else if ([model hasPrefix:@"iPad"]) {
        
        return @"iPad";
    } else if ([model hasPrefix:@"iPhone"]) {
        
        return @"iPhone";
    } else if ([model hasPrefix:@"iPod"]) {
        
        return @"iPod touch";
    }
    
    return @"unrecognized";
}

+ (NSString *)iPhoneModel {
    
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    //Apple Watch
    if ([deviceString hasPrefix:@"Watch1"]) {
        
        return @"Apple Watch";
    } else if ([deviceString isEqualToString:@"Watch2,6"] ||
               [deviceString isEqualToString:@"Watch2,7"]) {
        
        return @"Apple Watch Series 1";
    } else if ([deviceString isEqualToString:@"Watch2,3"] ||
               [deviceString isEqualToString:@"Watch2,4"]) {
        
        return @"Apple Watch Series 2";
    } else if ([deviceString hasPrefix:@"Watch3"]) {
        
        return @"Apple Watch Series 3";
    }
    
    //iPad
    if ([deviceString isEqualToString:@"iPad1,1"]) {
        
        return @"iPad";
    } else if ([deviceString isEqualToString:@"iPad2,1"] ||
               [deviceString isEqualToString:@"iPad2,2"] ||
               [deviceString isEqualToString:@"iPad2,3"]) {
        
        return @"iPad 2";
    } else if ([deviceString isEqualToString:@"iPad3,1"] ||
               [deviceString isEqualToString:@"iPad3,2"] ||
               [deviceString isEqualToString:@"iPad3,3"]) {
        
        return @"iPad 3";
    } else if ([deviceString isEqualToString:@"iPad3,4"] ||
               [deviceString isEqualToString:@"iPad3,5"] ||
               [deviceString isEqualToString:@"iPad3,6"]) {
        
        return @"iPad 4";
    } else if ([deviceString hasPrefix:@"iPad4,1"] ||
               [deviceString hasPrefix:@"iPad4,2"] ||
               [deviceString hasPrefix:@"iPad4,3"]) {
        
        return @"iPad Air";
    } else if ([deviceString hasPrefix:@"iPad5,3"] ||
               [deviceString hasPrefix:@"iPad5,4"]) {
        
        return @"iPad Air 2";
    } else if ([deviceString isEqualToString:@"iPad6,7"] ||
               [deviceString isEqualToString:@"iPad6,8"]) {
        
        return @"iPad Pro (12.9 inch)";
    } else if ([deviceString isEqualToString:@"iPad6,3"] ||
               [deviceString isEqualToString:@"iPad6,4"]) {
        
        return @"iPad Pro (9.7 inch)";
    } else if ([deviceString isEqualToString:@"iPad6,11"] ||
               [deviceString isEqualToString:@"iPad6,12"]) {
        
        return @"iPad 5";
    } else if ([deviceString isEqualToString:@"iPad7,1"] ||
               [deviceString isEqualToString:@"iPad7,2"]) {
        
        return @"iPad Pro (12.9-inch, 2nd generation)";
    } else if ([deviceString isEqualToString:@"iPad7,3"] ||
               [deviceString isEqualToString:@"iPad7,4"]) {
        
        return @"iPad Pro (10.5-inch)";
    }
    
    //iPad mini
    if ([deviceString isEqualToString:@"iPad2,5"] ||
        [deviceString isEqualToString:@"iPad2,6"] ||
        [deviceString isEqualToString:@"iPad2,7"]) {
        
        return @"iPad mini";
    } else if ([deviceString isEqualToString:@"iPad4,4"] ||
               [deviceString isEqualToString:@"iPad4,5"] ||
               [deviceString isEqualToString:@"iPad4,6"]) {
        
        return @"iPad mini 2";
    } else if ([deviceString isEqualToString:@"iPad4,7"] ||
               [deviceString isEqualToString:@"iPad4,8"] ||
               [deviceString isEqualToString:@"iPad4,9"]) {
        
        return @"iPad mini 3";
    } else if ([deviceString isEqualToString:@"iPad5,1"] ||
               [deviceString isEqualToString:@"iPad5,2"]) {
        
        return @"iPad mini 4";
    }
    
    //iPhone
    if ([deviceString isEqualToString:@"iPhone1,1"]) {
        
        return @"iPhone";
    } else if ([deviceString isEqualToString:@"iPhone1,2"]) {
        
        return @"iPhone 3G";
    } else if ([deviceString isEqualToString:@"iPhone2,1"]) {
        
        return @"iPhone 3GS";
    } else if ([deviceString hasPrefix:@"iPhone3"]) {
        
        return @"iPhone 4";
    } else if ([deviceString isEqualToString:@"iPhone4,1"]) {
        
        return @"iPhone 4S";
    } else if ([deviceString isEqualToString:@"iPhone5,1"] ||
               [deviceString isEqualToString:@"iPhone5,2"]) {
        
        return @"iPhone 5";
    } else if ([deviceString isEqualToString:@"iPhone5,3"] ||
               [deviceString isEqualToString:@"iPhone5,4"]) {
        
        return @"iPhone 5c";
    } else if ([deviceString hasPrefix:@"iPhone6"]) {
        
        return @"iPhone 5s";
    } else if ([deviceString isEqualToString:@"iPhone7,2"]) {
        
        return @"iPhone 6";
    } else if ([deviceString isEqualToString:@"iPhone7,1"]) {
        
        return @"iPhone 6 Plus";
    } else if ([deviceString isEqualToString:@"iPhone8,1"]) {
        
        return @"iPhone 6s";
    } else if ([deviceString isEqualToString:@"iPhone8,2"]) {
        
        return @"iPhone 6s Plus";
    } else if ([deviceString isEqualToString:@"iPhone8,4"]) {
        
        return @"iPhone SE";
    } else if ([deviceString isEqualToString:@"iPhone9,1"] ||
               [deviceString isEqualToString:@"iPhone9,3"]) {
        
        return @"iPhone 7";
    } else if ([deviceString isEqualToString:@"iPhone9,2"] ||
               [deviceString isEqualToString:@"iPhone9,4"]) {
        
        return @"iPhone 7 Plus";
    } else if ([deviceString isEqualToString:@"iPhone10,1"] ||
               [deviceString isEqualToString:@"iPhone10,4"]) {
        
        return @"iPhone 8";
    } else if ([deviceString isEqualToString:@"iPhone10,2"] ||
               [deviceString isEqualToString:@"iPhone10,5"]) {
        
        return @"iPhone 8 Plus";
    } else if ([deviceString isEqualToString:@"iPhone10,3"] ||
               [deviceString isEqualToString:@"iPhone10,6"]) {
        
        return @"iPhone X";
    }
    
    //iPod touch
    if ([deviceString isEqualToString:@"iPod1,1"]) {
        
        return @"iPod touch";
    } else if ([deviceString isEqualToString:@"iPod2,1"]) {
        
        return @"iPod touch 2G";
    } else if ([deviceString isEqualToString:@"iPod3,1"]) {
        
        return @"iPod touch 3G";
    } else if ([deviceString isEqualToString:@"iPod4,1"]) {
        
        return @"iPod touch 4G";
    } else if ([deviceString isEqualToString:@"iPod5,1"]) {
        
        return @"iPod touch 5G";
    } else if ([deviceString isEqualToString:@"iPod7,1"]) {
        
        return @"iPod touch 6G";
    }
    
    //iPhone Simulator
    if ([deviceString isEqualToString:@"i386"] ||
        [deviceString isEqualToString:@"x86_64"] ||
        [deviceString isEqualToString:@"iPhone Simulator"]) {
        
        return @"iPhone Simulator";
    }
    
    return @"unrecognized";
}

@end
