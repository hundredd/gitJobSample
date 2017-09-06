//
//  BMWebController.h
//  电商框架
//
//  Created by 陈宇 on 15/8/5.
//  Copyright (c) 2015年 陈宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMWebController : UIViewController

@property (nonatomic, copy) NSURL *path;

/**
 *  1:使用指南
 *  2:关于平台
 *  3:注册协议
 *  4:钱包使用说明
 */
@property (nonatomic, assign) NSUInteger type;

@end
