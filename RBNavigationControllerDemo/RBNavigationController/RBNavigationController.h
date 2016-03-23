//
//  RBNavigationController.h
//  RBNavigationControllerDemo
//
//  Created by liushuai on 16/3/23.
//  Copyright © 2016年 Liuonion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RBNavigationController : UINavigationController

@property (nonatomic, assign) BOOL fullScreenPopGestureEnabled;

@property (nonatomic, copy, readonly) NSArray *rb_viewControllers;

@end
