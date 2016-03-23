//
//  UIViewController+RBNavigation.h
//  RBNavigationControllerDemo
//
//  Created by liushuai on 16/3/23.
//  Copyright © 2016年 Liuonion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RBNavigationController.h"

@interface UIViewController (RBNavigation)
@property (nonatomic, assign) BOOL rb_fullScreenPopGestureEnable;
@property (nonatomic, strong) RBNavigationController *rb_navigationController;
@end
