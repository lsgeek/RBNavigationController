//
//  UIViewController+RBNavigation.m
//  RBNavigationControllerDemo
//
//  Created by liushuai on 16/3/23.
//  Copyright © 2016年 Liuonion. All rights reserved.
//

#import "UIViewController+RBNavigation.h"
#import <objc/runtime.h>

@implementation UIViewController (RBNavigation)

-(BOOL)rb_fullScreenPopGestureEnable
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];

}

- (void)setRb_fullScreenPopGestureEnable:(BOOL)rb_fullScreenPopGestureEnable
{
    objc_setAssociatedObject(self, @selector(rb_fullScreenPopGestureEnable), @(rb_fullScreenPopGestureEnable), OBJC_ASSOCIATION_RETAIN);
}

-(RBNavigationController *)rb_navigationController
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setRb_navigationController:(RBNavigationController *)rb_navigationController
{
    objc_setAssociatedObject(self, @selector(rb_navigationController), rb_navigationController, OBJC_ASSOCIATION_RETAIN);
}

@end
