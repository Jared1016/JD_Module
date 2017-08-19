//
//  JDRouteRequest.m
//  JDRoute
//
//  Created by Jared on 2017/8/16.
//  Copyright © 2017年 Jared. All rights reserved.
//

#import "JDRouteRequest.h"
#import "NSString+JDQuery.h"

@interface JDRouteRequest ()

@end

@implementation JDRouteRequest

- (void)setTargetCallBack:(void (^)(id, NSError *))targetCallBack{
    __weak JDRouteRequest *weakResuest = self;
    if (targetCallBack == nil) {
        return;
    }
    self.isConsumed = NO;
    /* 用self.targetCallBack为什么会报错？  循环引用？
    self.targetCallBack = ^(id responseObject, NSError *error){
        weakResuest.isConsumed = YES;
        targetCallBack(responseObject, error);
    };
     */
    _targetCallBack = ^(id responseObject, NSError *error){
        weakResuest.isConsumed = YES;
        targetCallBack(responseObject, error);
    };
}

- (void)defaultFinishTargetCallBack{
    if (self.targetCallBack && self.isConsumed == NO) {
        self.targetCallBack(@"正常回调", nil);
    }
}

- (instancetype)initWithURL:(NSURL *)URL{
    if (!URL) {
        return nil;
    }
    if (self = [super init]) {
        _URL = URL;
        _queryParameters = [[_URL query] JDParametersFromQueryString];
    }
    return self;
}

- (instancetype)initWithURL:(NSURL *)URL routeExpression:(NSString *)routeExpression routeParameters:(NSDictionary *)routeParameters primitiveParams:(NSDictionary *)primitiveParams targetCallBack:(void (^)(id, NSError *))targetCallBack{
    if (!URL) {
        return nil;
    }
    if (self = [super init]) {
        _URL = URL;
        _queryParameters = [[_URL query] JDParametersFromQueryString];
        _routeExpression = routeExpression;
        _primitiveParams = primitiveParams;
        _routeParameters = routeParameters;
        self.targetCallBack = targetCallBack;
    }
    return self;
}

- (void)setRouteParameters:(NSDictionary *)routeParameters{
    _routeParameters = routeParameters;
}

- (void)setPrimitiveParams:(NSDictionary *)primitiveParams{
    _primitiveParams = primitiveParams;
}

- (NSString *)description{
    return [NSString stringWithFormat:
            @"\n<%@ %p\n"
            @"\t URL: \"%@\"\n"
            @"\t queryParameters: \"%@\"\n"
            @"\t routeParameters: \"%@\"\n"
            @"\t PrimitiveParam: \"%@\"\n"
            @">",
            NSStringFromClass([self class]),
            self,
            [self.URL description],
            self.queryParameters,
            self.routeParameters,
            self.primitiveParams];
}

- (id)objectForKeyedSubscript:(NSString *)key{
    id value = self.routeParameters[key];
    if (!value) {
        value = self.queryParameters[key];
    }
    if (!value) {
        value = self.primitiveParams[key];
    }
    return value;
}

- (NSURL *)callbackURL{
    if (!_callbackURL) {
        for (NSString * key in self.routeParameters.allKeys) {
            if ([[key lowercaseString] rangeOfString:@"callback"].location != NSNotFound) {
                NSString * urlstring = self.routeParameters[key];
                NSURL * url = [NSURL URLWithString:urlstring];
                if (url) {
                    _callbackURL = url;
                    return _callbackURL;
                }
            }
        }
        for (NSString * key in self.queryParameters.allKeys) {
            if ([[key lowercaseString] rangeOfString:@"callback"].location != NSNotFound) {
                NSString * urlstring = self.queryParameters[key];
                NSURL * url = [NSURL URLWithString:urlstring];
                if (url) {
                    _callbackURL = url;
                    return _callbackURL;
                }
            }
        }
        for (NSString * key in self.primitiveParams.allKeys) {
            if ([[key lowercaseString] rangeOfString:@"callback"].location != NSNotFound) {
                NSString * urlstring = self.primitiveParams[key];
                NSURL * url = [NSURL URLWithString:urlstring];
                if (url) {
                    _callbackURL = url;
                    return _callbackURL;
                }
            }
        }
    }
    return _callbackURL;
}

- (id)copyWithZone:(NSZone *)zone{
    JDRouteRequest *copRequest = [[JDRouteRequest alloc] initWithURL:self.URL];
    copRequest.routeParameters = self.routeParameters;
    copRequest.routeExpression = self.routeExpression;
    copRequest.primitiveParams = self.primitiveParams;
    copRequest.targetCallBack = self.targetCallBack;
    copRequest.isConsumed = self.isConsumed;
    self.isConsumed = YES;
    
    return copRequest;
}

@end
