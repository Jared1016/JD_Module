//
//  JDSignViewController.m
//  JDRoute
//
//  Created by Jared on 2017/8/17.
//  Copyright © 2017年 Jared. All rights reserved.
//

#import "JDSignViewController.h"
#import "JDRouter.h"

@interface JDSignViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phone;

@property (weak, nonatomic) IBOutlet UITextField *password;
@end

@implementation JDSignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.phone.text = self.jd_request[@"phone"];
}

- (IBAction)goBtnClick:(id)sender {
}

@end
