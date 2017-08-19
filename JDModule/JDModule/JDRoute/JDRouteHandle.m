//
//  JDRouteHandle.m
//  JDRoute
//
//  Created by Jared on 2017/8/16.
//  Copyright © 2017年 Jared. All rights reserved.
//

#import "JDRouteHandle.h"

@implementation JDRouteHandle

- (BOOL)shouldHandleWithRequest:(JDRouteRequest *)request{
    return YES;
}

- (UIViewController *)targetViewControllerWithRequest:(JDRouteRequest *)request{
    return [[NSClassFromString(@"") alloc] init];
}

- (UIViewController *)sourceViewControllerForTransitionWithRequest:(JDRouteRequest *)requset{
    return [UIApplication sharedApplication].windows[0].rootViewController;
}

- (BOOL)handleRequest:(JDRouteRequest *)request error:(NSError *__autoreleasing *)error{
    UIViewController *sourceViewController = [self sourceViewControllerForTransitionWithRequest:request];
    UIViewController *targetViewCOntroller = [self targetViewControllerWithRequest:request];
    if ((![sourceViewController isKindOfClass:[UIViewController class]]) || (![targetViewCOntroller isKindOfClass:[UIViewController class]])) {
        *error = [NSError JDTransitionError];
        return NO;
    }
    if (targetViewCOntroller != nil) {
        targetViewCOntroller.jd_request = request;
    }
    BOOL isPreferModal = [self preferModalPresentationWithRequest:request];
    return [self transitionWithRequest:request sourceViewCOntroller:sourceViewController targetViewController:targetViewCOntroller isPreferModal:isPreferModal error:error];
}

- (BOOL)transitionWithRequest:(JDRouteRequest *)request sourceViewCOntroller:(UIViewController *)sourceViewController targetViewController:(UIViewController *)targetViewController isPreferModal:(BOOL)isPreferModal error:(NSError *__autoreleasing *)error{
    if (isPreferModal || ![sourceViewController isKindOfClass:[UINavigationController class]]) {
        [sourceViewController presentViewController:targetViewController animated:YES completion:nil];
    }
    else if ([sourceViewController isKindOfClass:[UINavigationController class]]){
        UINavigationController *nav = (UINavigationController *)sourceViewController;
        [nav pushViewController:targetViewController animated:YES];
    }
    return YES;
}

- (BOOL)preferModalPresentationWithRequest:(JDRouteRequest *)request{
    return NO;
}

@end
