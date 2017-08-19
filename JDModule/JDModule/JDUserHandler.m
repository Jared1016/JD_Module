//
//  JDUserHandler.m
//  JDRoute
//
//  Created by Jared on 2017/8/17.
//  Copyright © 2017年 Jared. All rights reserved.
//

#import "JDUserHandler.h"
@implementation JDUserHandler

- (UIViewController *)targetViewControllerWithRequest:(JDRouteRequest *)request{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Mian" bundle:nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"JDUserViewController"];
    return vc;
}

@end
