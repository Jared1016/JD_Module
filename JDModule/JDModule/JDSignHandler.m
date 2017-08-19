//
//  JDSignHandler.m
//  JDRoute
//
//  Created by Jared on 2017/8/17.
//  Copyright © 2017年 Jared. All rights reserved.
//

#import "JDSignHandler.h"

@implementation JDSignHandler

- (UIViewController *)targetViewControllerWithRequest:(JDRouteRequest *)request{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"JDSignViewController"];
    return vc;
}


@end
