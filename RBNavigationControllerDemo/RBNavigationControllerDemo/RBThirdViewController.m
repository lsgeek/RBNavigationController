//
//  RBThirdViewController.m
//  RBNavigationControllerDemo
//
//  Created by liushuai on 16/3/23.
//  Copyright © 2016年 Liuonion. All rights reserved.
//

#import "RBThirdViewController.h"
#import "RBFourViewController.h"
#import "UIViewController+RBNavigation.h"

@implementation RBThirdViewController
- (void)viewDidLoad
{
    self.title = @"ThirdTitle";
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.view.backgroundColor = [UIColor blueColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(didTapNextButton)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"left" style:UIBarButtonItemStylePlain target:self action:@selector(didTapleftButton)];
}

- (void)didTapNextButton {
    RBFourViewController *viewController = [[RBFourViewController alloc] init];
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}
- (void)didTapleftButton {
    ;
    [self.navigationController popToViewController:self.rb_navigationController.rb_viewControllers[self.rb_navigationController.rb_viewControllers.count - 2] animated:NO];
}
@end
