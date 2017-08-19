//
//  ViewController.m
//  JDRoute
//
//  Created by Jared on 2017/8/16.
//  Copyright © 2017年 Jared. All rights reserved.
//

#import "ViewController.h"

#import "AppDelegate.h"

@interface ViewController ()<JDRouteMiddlewareProtocol>

@property (nonatomic, strong) JDRouter *router;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.router = ((AppDelegate *)[UIApplication sharedApplication].delegate).router;
    [self.router addMiddeware:self];
    
}

-(NSDictionary *)middlewareHandleRequestWith:(JDRouteRequest *__autoreleasing *)primitiveRequest error:(NSError *__autoreleasing *)error{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.router removeMiddeware:self];
    });
    return nil;
    //test:
    //    *error = [NSError WLRMiddlewareRaiseErrorWithMsg:[NSString stringWithFormat:@"%@ raise error",NSStringFromClass([self class])]];
    //    return @{@"result":@"yes"};
}

- (IBAction)signBtnClick:(id)sender {
//    [self.router handleURL:[NSURL URLWithString:@"WLRDemo://com.wlrroute.demo/signin/13812345432"] primitiveParameters:nil targetCallBack:^(NSError *error, id responseObject) {
//        NSLog(@"SiginCallBack");
//    } withCompletionBlock:^(BOOL handled, NSError *error) {
//        NSLog(@"SiginHandleCompletion");
//    }];
    
    [self.router handleURL:[NSURL URLWithString:@"JDDemo://com.jdroute.demo/signin/13812345432"] primitiveParameters:nil targetCallBack:^(id responseObject, NSError *error) {
        NSLog(@"SiginCallBack");
    } WithCompletionBlock:^(BOOL handled, NSError *error) {
        NSLog(@"SiginHandleCompletion");
    }];
}

- (IBAction)userBtnClick:(id)sender {
//    [self.router handleURL:[NSURL URLWithString:@"WLRDemo://com.wlrroute.demo/user"] primitiveParameters:@{@"user":@"Neo~🙃🙃"} targetCallBack:^(NSError *error, id responseObject) {
//        NSLog(@"UserCallBack");
//    } withCompletionBlock:^(BOOL handled, NSError *error) {
//        NSLog(@"UserHandleCompletion");
//    }];
}



@end
