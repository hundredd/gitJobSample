//
//  ZDBaseNavController.m
//  特种车调度
//
//  Created by 陈宇 on 15/8/18.
//
//

#import "ZDBaseNavController.h"

@interface ZDBaseNavController ()

@end

@implementation ZDBaseNavController

+ (void)initialize
{
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.barTintColor = kGlobalColor;
    navBar.tintColor = [UIColor whiteColor];
//    [navBar setBackgroundImage:[UIImage resizeImage:@"navigationbar_backgroundimg"] forBarMetrics:UIBarMetricsDefault];
//    navBar.shadowImage = [[UIImage alloc] init];
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName:kTitleFont}];
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    if (self = [super initWithRootViewController:rootViewController]) {
        
    }
    return self;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    viewController.navigationItem.leftBarButtonItem = [self createBackItem];
    [super pushViewController:viewController animated:YES];
}

- (UIBarButtonItem *)createBackItem
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    return item;
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

@end
