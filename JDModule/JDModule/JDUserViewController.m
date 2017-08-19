//
//  JDUserViewController.m
//  JDRoute
//
//  Created by Jared on 2017/8/17.
//  Copyright © 2017年 Jared. All rights reserved.
//

#import "JDUserViewController.h"
#import "JDRouter.h"

@interface JDUserViewController ()
@property (weak, nonatomic) IBOutlet UILabel *userLabel;

@end

@implementation JDUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.userLabel.text = self.jd_request[@"user"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
