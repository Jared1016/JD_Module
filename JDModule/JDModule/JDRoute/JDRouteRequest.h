//
//  JDRouteRequest.h
//  JDRoute
//
//  Created by Jared on 2017/8/16.
//  Copyright © 2017年 Jared. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JDRouteRequest : NSObject<NSCopying>

@property (nonatomic, copy, readonly) NSURL *URL;

@property (nonatomic, copy) NSString *routeExpression;

@property (nonatomic, copy, readonly) NSDictionary *queryParameters;

@property (nonatomic, copy, readonly) NSDictionary *routeParameters;

@property (nonatomic, copy, readonly) NSDictionary *primitiveParams;

@property (nonatomic, strong) NSURL *callbackURL;

@property (nonatomic, copy) void(^targetCallBack)(id responseObject, NSError *error);

@property (nonatomic, assign) BOOL isConsumed;

- (id)objectForKeyedSubscript:(NSString *)key;

- (instancetype)initWithURL:(NSURL *)URL
            routeExpression:(NSString *)routeExpression
            routeParameters:(NSDictionary *)routeParameters
            primitiveParams:(NSDictionary *)primitiveParams
             targetCallBack:(void(^)(id responseObject, NSError *error))targetCallBack;
- (instancetype)initWithURL:(NSURL *)URL;

- (void)defaultFinishTargetCallBack;

@end
