//
//  RBFourViewController.m
//  RBNavigationControllerDemo
//
//  Created by liushuai on 16/3/23.
//  Copyright © 2016年 Liuonion. All rights reserved.
//

#import "RBFourViewController.h"

@implementation RBFourViewController
- (void)viewDidLoad
{
    self.title = @"FourTitle";
    self.navigationController.navigationBar.barTintColor = [UIColor greenColor];
    self.view.backgroundColor = [UIColor brownColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"PopRoot" style:UIBarButtonItemStylePlain target:self action:@selector(didTapNextButton)];
}

- (void)didTapNextButton {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
