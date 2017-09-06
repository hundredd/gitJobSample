//
//  BMMainTool.h
//  ZPM
//
//  Created by 陈宇 on 15/3/20.
//  Copyright (c) 2015年 陈宇. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface BMMainTool : NSObject


/**选择程序启动时候的根控制器 */
+ (UIViewController *)chooseRootViewController;

/*
 *把一个格式化的时间字符串转化为NSDated对象
 */
+ (NSDate *)convertWithString:(NSString *)dateString;


/**
 *  检查是否有新版本需要更新
 */
+ (void)checkAppVersionUpdate:(void (^)(BMUpateModel *model))complete;



@end
