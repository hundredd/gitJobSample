//
//  AppDelegate.m
//  HGDQQRCode
//
//  Created by zhuming on 16/3/9.
//  Copyright © 2016年 zhuming. All rights reserved.
//

#import "AppDelegate.h"
#import "QRCodeViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    QRCodeViewController *vc = [QRCodeViewController new];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
