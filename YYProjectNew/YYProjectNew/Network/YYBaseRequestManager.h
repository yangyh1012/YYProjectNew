//
//  YYAPIBaseManager.h
//  YYProjectNew
//
//  Created by yangyh on 2017/1/21.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYResponse.h"
#import "NSString+YYNetwork.h"

// 在调用成功之后的params字典里面，用这个key可以取出requestID
static NSString * const YYBaseRequestManagerRequestId = @"YYBaseRequestManagerRequestId";

@class YYBaseRequestManager;

/**
 请求数据源
 */
@protocol YYBaseRequestManagerParamSource <NSObject>

@required


/**
 在控制器中实现该方法，获取参数

 @param manager manager
 @return 参数
 */
- (NSDictionary *)paramsForRequestWithManager:(YYBaseRequestManager *)manager;

@end



/**
 请求回调
 */
@protocol YYBaseRequestManagerCallBackDelegate <NSObject>

@required


/**
 请求成功的回调

 @param manager manager
 */
- (void)requestDidSuccessWithManager:(YYBaseRequestManager *)manager;


/**
 请求失败的回调

 @param manager manager
 */
- (void)requestDidFailedWithManager:(YYBaseRequestManager *)manager;

@end



/**
 请求开始或结束的拦截器
 */
@protocol YYBaseRequestManagerInterceptor <NSObject>

@optional


/**
 请求前拦截

 @param manager manager
 @param params 参数
 @return YES 放行
 */
- (BOOL)manager:(YYBaseRequestManager *)manager beforeRequestWithParams:(NSDictionary *)params;

/**
 请求后拦截

 @param manager manager
 @param params 参数
 */
- (void)manager:(YYBaseRequestManager *)manager afterRequestWithParams:(NSDictionary *)params;


/**
 请求成功前拦截

 @param manager manager
 @param response response
 @return YES 放行
 */
- (BOOL)manager:(YYBaseRequestManager *)manager beforePerformSuccessWithResponse:(YYResponse *)response;

/**
 请求成功后拦截

 @param manager manager
 @param response response
 */
- (void)manager:(YYBaseRequestManager *)manager afterPerformSuccessWithResponse:(YYResponse *)response;


/**
 请求失败前拦截

 @param manager manager
 @param response response
 @return YES 放行
 */
- (BOOL)manager:(YYBaseRequestManager *)manager beforePerformFailWithResponse:(YYResponse *)response;

/**
 请求失败后拦截

 @param manager manager
 @param response response
 */
- (void)manager:(YYBaseRequestManager *)manager afterPerformFailWithResponse:(YYResponse *)response;

@end




/**
 请求数据和返回数据的校验
 */
@protocol YYBaseRequestManagerValidator <NSObject>

@required

/**
 判断参数格式是否正确，正确后才开始请求

 @param manager manager
 @param data 参数
 @return YES 放行
 */
- (BOOL)manager:(YYBaseRequestManager *)manager isCorrectWithParamsData:(NSDictionary *)data;

/**
 判断返回数据的格式是否正确，正确后才返回到控制器

 @param manager manager
 @param data 返回数据
 @return YES 放行
 */
- (BOOL)manager:(YYBaseRequestManager *)manager isCorrectWithCallBackData:(NSDictionary *)data;

@end



/**
 返回数据重新格式化
 */
@protocol YYBaseRequestManagerDataReformer <NSObject>

@required

/**
 创建一个类，实现该方法，可对返回的数据进行整理，整理成通用数据格式

 @param manager manager
 @param data 返回数据
 @return 符合格式要求的数据
 */
- (id)manager:(YYBaseRequestManager *)manager reformData:(NSDictionary *)data;

@end




/**
 请求服务相关配置
 */
@protocol YYBaseRequestManagerProtocol <NSObject>

@required

/**
 服务Id，由YYServiceFactoryDataSource获得

 @return 服务Id
 */
- (NSString *)serviceIdentifier;

/**
 方法名称

 @return 方法名称
 */
- (NSString *)methodName;

/**
 请求方式post、get、delete、put

 @return 请求方式
 */
- (YYNetworkRequestType)requestType;

@optional

/**
 是否调用本地数据（通过方法名获取的缓存数据）

 @return YES，开启本地数据调用的开关
 */
- (BOOL)shouldLoadFromNative;//表示父类没有此方法

/**
 是否增加额外参数，比如增加pageNumber和pageSize，或者调整参数，具体业务层方面的参数，该方法在拦截器和校验器之前调用

 @param params 已有参数
 @return 更完整的参数
 */
- (NSDictionary *)addExtraOrRemakeParams:(NSDictionary *)params;//表示父类没有此方法


/**
 是否调用本地缓存（通过服务Id、方法名、参数获取的缓存数据，具有唯一性）

 @return YES，开启
 */
- (BOOL)shouldCacheByChild;//ByChild表示实现此方法，会覆盖父类ByParent方法

/**
 清理本地数据
 */
- (void)cleanDataByParentAndChild;//ByParentAndChild表示实现此方法，会自动调用父类ByParent方法。

@end

/**
 请求管理类
 */
@interface YYBaseRequestManager : NSObject

@property (nonatomic, weak) id<YYBaseRequestManagerParamSource> paramSource;//数据源
@property (nonatomic, weak) id<YYBaseRequestManagerCallBackDelegate> delegate;//请求成功返回和失败返回代理

@property (nonatomic, weak) id<YYBaseRequestManagerValidator> validator;//校验器
@property (nonatomic, weak) id<YYBaseRequestManagerInterceptor> interceptor;//拦截器

@property (nonatomic, weak) id<YYBaseRequestManagerProtocol> child;//子类

@property (nonatomic, strong, readonly) YYResponse *response;//响应体

@property (nonatomic, assign, readonly) YYBaseRequestManagerErrorType errorType;//错误类型

@property (nonatomic, assign, readonly) BOOL isReachable;//网络判断
@property (nonatomic, assign, readonly) BOOL isLoading;//是否正在加载

//父类方法不允许被覆盖、重载


/**
 发起请求

 @return 请求Id
 */
- (NSInteger)loadData;

/**
 返回通用格式的数据

 @param reformer 实现了接口的类
 @return 整过的数据，传nil时，返回源数据
 */
- (id)fetchDataWithReformer:(id<YYBaseRequestManagerDataReformer>)reformer;


/**
 取消所有请求
 */
- (void)cancelAllRequests;

/**
 取消单个请求

 @param requestId 请求Id
 */
- (void)cancelRequestWithRequestId:(NSInteger)requestId;

/**
 清理数据
 */
- (void)cleanDataByParent;

@end















