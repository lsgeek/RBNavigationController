//
//  RBNavigationController.m
//  RBNavigationControllerDemo
//
//  Created by liushuai on 16/3/23.
//  Copyright © 2016年 Liuonion. All rights reserved.
//

#import "RBNavigationController.h"
#import "UIViewController+RBNavigation.h"




#pragma mark -  interface Class JTWrapViewController

@interface RBWrapViewController : UIViewController

@property (nonatomic, strong, readonly) UIViewController *contentViewController;

+ (RBWrapViewController *)wrapViewControllerWithViewController:(UIViewController *)viewController;

@end

#pragma mark - JTWrapNavigationController

@interface RBWrapNavigationController : UINavigationController
@end

@implementation RBWrapNavigationController

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    return [self.navigationController popViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated {
    return [self.navigationController popToRootViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    RBNavigationController *rb_navigationController = viewController.rb_navigationController;
    NSInteger index = [rb_navigationController.rb_viewControllers indexOfObject:viewController];
    return [self.navigationController popToViewController:rb_navigationController.viewControllers[index] animated:animated];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    viewController.rb_navigationController = (RBNavigationController *)self.navigationController;
    viewController.rb_fullScreenPopGestureEnable = viewController.rb_navigationController.fullScreenPopGestureEnabled;
    
//    UIImage *backButtonImage = viewController.jt_navigationController.backButtonImage;
//    
//    if (!backButtonImage) {
//        backButtonImage = [UIImage imageNamed:kDefaultBackImageName];
//    }
    
//    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(didTapBackButton)];
    
    [self.navigationController pushViewController:[RBWrapViewController wrapViewControllerWithViewController:viewController] animated:animated];
}

//- (void)didTapBackButton {
//    [self.navigationController popViewControllerAnimated:YES];
//}

- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion{
    [self.navigationController dismissViewControllerAnimated:flag completion:completion];
    self.viewControllers.firstObject.rb_navigationController = nil;
}

@end

#pragma mark -  Class JTWrapViewController

static NSValue *rb_tabBarRectValue;

@implementation RBWrapViewController

+ (RBWrapViewController *)wrapViewControllerWithViewController:(UIViewController *)viewController
{
    RBWrapNavigationController *wrapNavigationController = [[RBWrapNavigationController alloc] init];
    wrapNavigationController.viewControllers = @[viewController];
    RBWrapViewController *wrapViewController = [[RBWrapViewController alloc] init];
    [wrapViewController.view addSubview:wrapNavigationController.view];
    [wrapViewController addChildViewController:wrapNavigationController];
    return  wrapViewController;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    if (self.tabBarController && !rb_tabBarRectValue) {
        rb_tabBarRectValue = [NSValue valueWithCGRect:self.tabBarController.tabBar.frame];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.translucent = YES;
    if (self.tabBarController && !self.tabBarController.tabBar.hidden && rb_tabBarRectValue) {
        self.tabBarController.tabBar.frame = rb_tabBarRectValue.CGRectValue;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.tabBarController && [self contentViewController].hidesBottomBarWhenPushed) {
        self.tabBarController.tabBar.frame = CGRectZero;
    }
}

- (BOOL)rb_fullScreenPopGestureEnable
{
    return  [self contentViewController].rb_fullScreenPopGestureEnable;
}

- (BOOL)hidesBottomBarWhenPushed
{
    return [self contentViewController].hidesBottomBarWhenPushed;
}

- (UITabBarItem *)tabBarItem
{
    return [self contentViewController].tabBarItem;
}

- (NSString *)title
{
    return [self contentViewController].title;
}

- (UIViewController *)childViewControllerForStatusBarStyle
{
    return [self contentViewController];
}

- (UIViewController *)childViewControllerForStatusBarHidden
{
    return [self contentViewController];
}

- (UIViewController *)contentViewController
{
    RBWrapNavigationController *wrapNavController = self.childViewControllers.firstObject;
    return wrapNavController.viewControllers.firstObject;
}

@end

#pragma mark -  Class RBNavigationController

@interface RBNavigationController ()<UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIPanGestureRecognizer *popPanGesture;

@property (nonatomic, strong) id popGestureDelegate;

@end

@implementation RBNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super init]) {
        rootViewController.rb_navigationController = self;
        self.viewControllers = @[[RBWrapViewController wrapViewControllerWithViewController:rootViewController]];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.viewControllers.firstObject.rb_navigationController = self;
        self.viewControllers = @[[RBWrapViewController wrapViewControllerWithViewController:self.viewControllers.firstObject]];
    }
    return self;
}

- (void)viewDidLoad
{
    [self setNavigationBarHidden:YES];
    self.delegate = self;
    
    self.popGestureDelegate = self.interactivePopGestureRecognizer.delegate;
    SEL action = NSSelectorFromString(@"handleNavigationTransition:");
    self.popPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self.popGestureDelegate action:action];
    self.popPanGesture.maximumNumberOfTouches = 1;
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    BOOL isRootVC = viewController == navigationController.viewControllers.firstObject;
    
    if (viewController.rb_fullScreenPopGestureEnable) {
        if (isRootVC) {
            [self.view removeGestureRecognizer:self.popPanGesture];
        } else {
            [self.view addGestureRecognizer:self.popPanGesture];
        }
        self.interactivePopGestureRecognizer.delegate = self.popGestureDelegate;
        self.interactivePopGestureRecognizer.enabled = NO;
    } else {
        [self.view removeGestureRecognizer:self.popPanGesture];
        self.interactivePopGestureRecognizer.delegate = self;
        self.interactivePopGestureRecognizer.enabled = !isRootVC;
    }
    
}

#pragma mark - UIGestureRecognizerDelegate

//修复有水平方向滚动的ScrollView时边缘返回手势失效的问题
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
}

#pragma mark - Getter

- (NSArray *)rb_viewControllers {
    NSMutableArray *viewControllers = [NSMutableArray array];
    for (RBWrapViewController *wrapViewController in self.viewControllers) {
        [viewControllers addObject:wrapViewController.contentViewController];
    }
    return viewControllers.copy;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
