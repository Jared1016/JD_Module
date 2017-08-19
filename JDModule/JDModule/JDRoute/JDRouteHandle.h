//
//  JDRouteHandle.h
//  JDRoute
//
//  Created by Jared on 2017/8/16.
//  Copyright © 2017年 Jared. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JDRouteRequest.h"
#import "NSError+JDError.h"
#import "UIViewController+JDRoute.h"
@interface JDRouteHandle : NSObject

- (BOOL)shouldHandleWithRequest:(JDRouteRequest *)request;

- (UIViewController *)targetViewControllerWithRequest:(JDRouteRequest *)request;

- (UIViewController *)sourceViewControllerForTransitionWithRequest:(JDRouteRequest *)requset;

- (BOOL)handleRequest:(JDRouteRequest *)request
                error:(NSError * __autoreleasing *)error;

- (BOOL)transitionWithRequest:(JDRouteRequest *)request
         sourceViewCOntroller:(UIViewController *)sourceViewController
         targetViewController:(UIViewController *)targetViewController
                isPreferModal:(BOOL)isPreferModal
                        error:(NSError * __autoreleasing *)error;

- (BOOL)preferModalPresentationWithRequest:(JDRouteRequest *)request;
@end
