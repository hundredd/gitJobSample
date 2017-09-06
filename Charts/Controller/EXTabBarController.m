//
//  EXTabBarController.m
//  Charts
//
//  Created by Eleven on 16/7/26.
//  Copyright © 2016年 Eleven. All rights reserved.
//

#import "EXTabBarController.h"

@interface EXTabBarController ()

@end

@implementation EXTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customConfigTabBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//自定义标签栏样式
- (void)customConfigTabBar{
    //题目向上移动2像素
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -2)];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:13 / 255.0 green:15 / 255.0 blue:81 / 255.0 alpha:1]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:245 / 255.0 green:101 / 255.0 blue:5 / 255.0 alpha:1]} forState:UIControlStateSelected];
    [[UITabBar appearance] setTintColor:[UIColor orangeColor]];
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
