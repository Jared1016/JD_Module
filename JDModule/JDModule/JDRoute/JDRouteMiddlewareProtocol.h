//
//  JDRouteMiddlewareProtocol.h
//  JDRoute
//
//  Created by Jared on 2017/8/17.
//  Copyright © 2017年 Jared. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JDRouteRequest.h"
@protocol JDRouteMiddlewareProtocol <NSObject>

/**
 中间件处理一个请求,如果中间件可以处理这个请求,应该返回一个响应对象,中间件可以修改primitiveRequest,路由器将检查和捕获错误并返回词典,如果返回nil,路由器将该请求转移目前的中间件
 */
-(NSDictionary *)middlewareHandleRequestWith:(JDRouteRequest *__autoreleasing *)primitiveRequest error:(NSError *__autoreleasing *)error;

@end


