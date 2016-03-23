//
//  ViewController.m
//  RBNavigationControllerDemo
//
//  Created by liushuai on 16/3/23.
//  Copyright © 2016年 Liuonion. All rights reserved.
//

#import "RootTabBarViewController.h"
#import "RBFirstViewController.h"
#import "RBNavigationController.h"

@interface RootTabBarViewController ()

@end

@implementation RootTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    RBFirstViewController *firstVC = [[RBFirstViewController alloc] init];
    UITabBarItem *firstItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:1];
    firstVC.title = @"单个";
    firstVC.tabBarItem = firstItem;
    RBNavigationController *firstNav = [[RBNavigationController alloc] initWithRootViewController:firstVC];
//    firstNav.fullScreenPopGestureEnabled = YES;
    
    RBFirstViewController *secondVC = [[RBFirstViewController alloc] init];
    UITabBarItem *secondItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemTopRated tag:2];
    secondVC.title = @"全局";
    secondVC.tabBarItem = secondItem;
    RBNavigationController *secondNav = [[RBNavigationController alloc] initWithRootViewController:secondVC];
    secondNav.fullScreenPopGestureEnabled = YES;
    
    self.viewControllers = @[firstNav, secondNav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
