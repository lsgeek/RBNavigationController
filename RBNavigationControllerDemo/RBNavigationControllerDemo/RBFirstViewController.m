//
//  RBFirstViewController.m
//  RBNavigationControllerDemo
//
//  Created by liushuai on 16/3/23.
//  Copyright © 2016年 Liuonion. All rights reserved.
//

#import "RBFirstViewController.h"
#import "RBSecondViewController.h"

@implementation RBFirstViewController
- (void)viewDidLoad
{
    self.title = @"FirstTitle";
    self.navigationController.navigationBar.barTintColor = [UIColor blueColor];
    self.view.backgroundColor = [UIColor redColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(didTapNextButton)];
}

- (void)didTapNextButton {
    RBSecondViewController *viewController = [[RBSecondViewController alloc] init];
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
