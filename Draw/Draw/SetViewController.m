//
//  SetViewController.m
//  Draw
//
//  Created by 沈喆 on 16/3/8.
//  Copyright © 2016年 SEN_ZE. All rights reserved.
//

#import "SetViewController.h"

@interface SetViewController ()


@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButton:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}
@end
