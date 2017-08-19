//
//  JDRouter.h
//  JDRoute
//
//  Created by Jared on 2017/8/16.
//  Copyright © 2017年 Jared. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UIViewController+JDRoute.h"
#import "NSError+JDError.h"
#import "NSString+JDQuery.h"
#import "JDMatchResult.h"
#import "JDRegularExpression.h"
#import "JDRouteHandle.h"
#import "JDRouteMatcher.h"
#import "JDRouteMiddlewareProtocol.h"
#import "JDRouteRequest.h"

/**
 路由对象实体，提供注册route表达式和对应handler、block功能，提供中间件注册，提供下标访问的快捷方法
 */
@interface JDRouter : NSObject

/**
 注册一个route表达式并与一个block处理相关联
 
 @param routeHandlerBlock block用以处理匹配route表达式的url的请求
 @param route url的路由表达式，支持正则表达式的分组，例如app://login/:phone({0,9+})是一个表达式，:phone代表该路径值对应的key,可以在WLRRouteRequest对象中的routeParameters中获取
 */
- (void)registerBlock:(JDRouteRequest *(^)(JDRouteRequest *request))routeHandlerBlock forRoute:(NSString *)route;

/**
 注册一个route表达式并与一个block处理相关联
 
 @param handler handler对象用以处理匹配route表达式的url的请求
 @param route url的路由表达式，支持正则表达式的分组，例如app://login/:phone({0,9+})是一个表达式，:phone代表该路径值对应的key,可以在WLRRouteRequest对象中的routeParameters中获取
 */

- (void)registerHandler:(JDRouteHandle *)handler forRoute:(NSString *)route;

/**
 检测url是否能够被处理，不包含中间件的检查
 
 @param URL 请求的url
 @return 是否可以handle
 */
- (BOOL)canHandlerWithURL:(NSURL *)URL;

- (void)setObject:(id)obj forKeyedSubscript:(NSString *)key;

- (id)objectForKeyedSubscript:(NSString *)key;

/**
 处理url请求
 
 @param URL 调用的url
 @param primitiveParameters 携带的原生对象
 @param targetCallBack 传给目标对象的回调block
 @param completionBlock 完成路由中转的block
 @return 是否能够handle
 */
- (BOOL)handleURL:(NSURL *)URL primitiveParameters:(NSDictionary *)primitiveParameters targetCallBack:(void(^)(id responseObject, NSError *error))targetCallBack WithCompletionBlock:(void(^)(BOOL handled, NSError *error))completionBlock;

- (void)addMiddeware:(id<JDRouteMiddlewareProtocol>)middleware;
- (void)removeMiddeware:(id<JDRouteMiddlewareProtocol>)middleware;

@end
