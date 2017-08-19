//
//  JDRouteMatcher.m
//  JDRoute
//
//  Created by Jared on 2017/8/16.
//  Copyright © 2017年 Jared. All rights reserved.
//

#import "JDRouteMatcher.h"
#import "JDRegularExpression.h"

@interface JDRouteMatcher ()

@property (nonatomic, copy) NSString *scheme;

@property (nonatomic, strong) JDRegularExpression *regexMatcher;

@end

@implementation JDRouteMatcher

+ (instancetype)matcherWithRouteExpression:(NSString *)expression{
    return [[self alloc] initWithRouteExpression:expression];
}

- (instancetype)initWithRouteExpression:(NSString *)routeExpression{
    if (![routeExpression length]) {
        return nil;
    }
    if (self = [super init]) {
        NSArray *paths = [routeExpression componentsSeparatedByString:@"://"];
        _scheme = paths.count > 1? [paths firstObject]:nil;
        _routeExpressionPattern = [paths lastObject];
        _regexMatcher = [JDRegularExpression expressionWithPattern:_routeExpressionPattern];
        _originalRouteExpression = routeExpression;
    }
    return self;
}

- (JDRouteRequest *)createRequestWithURL:(NSURL *)URL primitiveParameters:(NSDictionary *)primitiveParameters targetCallBack:(void (^)(id, NSError *))targetCallBack{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", URL.host, URL.path];
    if (self.scheme.length && ![self.scheme isEqualToString:URL.scheme]) {
        return nil;
    }
    JDMatchResult *result = [self.regexMatcher matchResultForString:urlString];
    if (!result.match) {
        return nil;
    }
    JDRouteRequest *request = [[JDRouteRequest alloc] initWithURL:URL routeExpression:self.routeExpressionPattern routeParameters:result.paramProperties primitiveParams:primitiveParameters targetCallBack:targetCallBack];
    return request;
}



@end
