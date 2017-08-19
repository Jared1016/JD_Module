//
//  JDRouteMatcher.h
//  JDRoute
//
//  Created by Jared on 2017/8/16.
//  Copyright © 2017年 Jared. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JDRouteRequest.h"
/**
 该对象会根据url匹配表达式生成一个WLRRouteRequest路由请求对象，如果为nil则说明不匹配，如果不为nil则说明该url可以匹配.
 */
@interface JDRouteMatcher : NSObject

/**
 一个url字符串匹配正则表达式模式。
 */
@property (nonatomic, copy) NSString *routeExpressionPattern;

/**
 原始url字符串匹配模式
 */
@property (nonatomic, copy) NSString *originalRouteExpression;

+ (instancetype)matcherWithRouteExpression:(NSString *)expression;

/**
 如果与routeExpressionPattern NSURL对象匹配,返回一个JDRouteRequest对象,否则返回nil。
 */
- (JDRouteRequest *)createRequestWithURL:(NSURL *)URL primitiveParameters:(NSDictionary *)primitiveParameters targetCallBack:(void(^)(id responseObject, NSError *error))targetCallBack;

@end
