//
//  RBSecondViewController.m
//  RBNavigationControllerDemo
//
//  Created by liushuai on 16/3/23.
//  Copyright © 2016年 Liuonion. All rights reserved.
//

#import "RBSecondViewController.h"
#import "RBThirdViewController.h"

@implementation RBSecondViewController
- (void)viewDidLoad
{
    self.title = @"SeconeTitle";
    self.navigationController.navigationBar.barTintColor = [UIColor yellowColor];
    self.view.backgroundColor = [UIColor orangeColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(didTapNextButton)];
}

- (void)didTapNextButton {
    RBThirdViewController *viewController = [[RBThirdViewController alloc] init];
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}
@end
