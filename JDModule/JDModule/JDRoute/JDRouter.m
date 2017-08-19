//
//  JDRouter.m
//  JDRoute
//
//  Created by Jared on 2017/8/16.
//  Copyright © 2017年 Jared. All rights reserved.
//

#import "JDRouter.h"

@interface JDRouter ()
@property (nonatomic, strong) NSMutableDictionary *routeMatchers;
@property (nonatomic, strong) NSMutableDictionary *routeHandles;
@property (nonatomic, strong) NSMutableDictionary *routeBlocks;
@property (nonatomic, strong) NSHashTable *middlewares;
@end

@implementation JDRouter

- (NSHashTable *)middleware{
    if (!_middlewares) {
        _middlewares = [NSHashTable hashTableWithOptions:(NSPointerFunctionsWeakMemory)];
    }
    return _middlewares;
}

- (void)addMiddeware:(id<JDRouteMiddlewareProtocol>)middleware{
    if (middleware) {
        [self.middlewares addObject:middleware];
    }
}

- (void)removeMiddeware:(id<JDRouteMiddlewareProtocol>)middleware{
    if ([self.middlewares containsObject:middleware]) {
        [self.middlewares removeObject:middleware];
    }
}

- (instancetype)init{
    if (self = [super init]) {
        _routeBlocks = [NSMutableDictionary dictionary];
        _routeHandles = [NSMutableDictionary dictionary];
        _routeMatchers = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)registerBlock:(JDRouteRequest *(^)(JDRouteRequest *))routeHandlerBlock forRoute:(NSString *)route{
    if (routeHandlerBlock && [route length]) {
        [self.routeMatchers setObject:[JDRouteMatcher matcherWithRouteExpression:route] forKey:route];
        [self.routeHandles removeObjectForKey:route];
        self.routeBlocks[route] = routeHandlerBlock;
    }
}

- (void)registerHandler:(JDRouteHandle *)handler forRoute:(NSString *)route{
    if (handler && [route length]) {
        [self.routeMatchers setObject:[JDRouteMatcher matcherWithRouteExpression:route] forKey:route];
        [self.routeBlocks removeObjectForKey:route];
        self.routeHandles[route] = handler;
    }
}

- (id)objectForKeyedSubscript:(NSString *)key{
    NSString *route = (NSString *)key;
    id obj = nil;
    if ([route isKindOfClass:[NSString class]] && [route length]) {
        obj = self.routeHandles[route];
        if (obj == nil) {
            obj = self.routeBlocks[route];
        }
    }
    return obj;
}

- (void)setObject:(id)obj forKeyedSubscript:(NSString *)key{
    NSString *route = (NSString *)key;
    if (![route isKindOfClass:[NSString class]] && [route length]) {
        return;
    }
    if (!obj) {
        [self.routeBlocks removeObjectForKey:route];
        [self.routeHandles removeObjectForKey:route];
        [self.routeMatchers removeObjectForKey:route];
    }
    else if ([obj isKindOfClass:NSClassFromString(@"NSBlock")]){
        [self registerBlock:obj forRoute:route];
    }
    else if ([obj isKindOfClass:[JDRouteHandle class]]){
        [self registerHandler:obj forRoute:route];
    }
}

- (BOOL)canHandlerWithURL:(NSURL *)URL{
    for (NSString *route in self.routeMatchers.allKeys) {
        JDRouteMatcher *matcher = [self.routeMatchers objectForKey:route];
        JDRouteRequest *request = [matcher createRequestWithURL:URL primitiveParameters:nil targetCallBack:nil];
        if (request) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)handleURL:(NSURL *)URL primitiveParameters:(NSDictionary *)primitiveParameters targetCallBack:(void (^)(id, NSError *))targetCallBack WithCompletionBlock:(void (^)(BOOL, NSError *))completionBlock{
    if (!URL) {
        return NO;
    }
    NSError * error;
    JDRouteRequest * request;
    __block BOOL isHandled = NO;
    for (NSString * route in self.routeMatchers.allKeys) {
        JDRouteMatcher * matcher = [self.routeMatchers objectForKey:route];
        request = [matcher createRequestWithURL:URL primitiveParameters:primitiveParameters targetCallBack:targetCallBack];
        if (request) {
            NSDictionary * responseObject;
            for (id<JDRouteMiddlewareProtocol>middleware in self.middlewares){
                if (middleware != NULL &&[middleware respondsToSelector:@selector(middlewareHandleRequestWith:error:)]) {
                    responseObject = [middleware middlewareHandleRequestWith:&request error:&error];
                    if ((responseObject != nil )||(error != nil)) {
                        isHandled = YES;
                        if (request.targetCallBack) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                request.targetCallBack(responseObject,error);
                            });
                        }
                        break;
                    }
                }
            }
            if (isHandled == NO) {
                isHandled = [self handleRouteExpression:route withRequest:request error:&error];
            }
            break;
        }
    }
    if (!request) {
        error = [NSError JDNotFoundError];
    }
    [self completeRouteWithSuccess:isHandled error:error completionHandler:completionBlock];
    return isHandled;
}





- (BOOL)handleRouteExpression:(NSString *)routeExpression withRequest:(JDRouteRequest *)request error:(NSError * __autoreleasing *)error{
    id handler = self[routeExpression];
    if ([handler isKindOfClass:NSClassFromString(@"NSBlock")]) {
        JDRouteRequest *(^block)(JDRouteRequest *) = handler;
        JDRouteRequest *backRequest = block(request);
        if (backRequest.isConsumed == NO) {
            if (backRequest) {
                backRequest.isConsumed = YES;
                if (backRequest.targetCallBack) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        backRequest.targetCallBack(nil, nil);
                    });
                }
            }
            else {
                request.isConsumed = YES;
                if (request.targetCallBack) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        backRequest.targetCallBack(nil, [NSError JDHandleBlockNoReturnRequest]);
                    });
                }
            }
        }
        return YES;
    }
    else if ([handler isKindOfClass:[JDRouteHandle class]]){
        JDRouteHandle *rhandler = (JDRouteHandle *)handler;
        if (![rhandler shouldHandleWithRequest:request]) {
            return NO;
        }
        return [rhandler handleRequest:request error:error];
    }
    return YES;
}

- (void)completeRouteWithSuccess:(BOOL)handled error:(NSError *)error completionHandler:(void(^)(BOOL handled, NSError *error))completionHandler {
    if (completionHandler) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(handled, error);
        });
    }
}



@end
