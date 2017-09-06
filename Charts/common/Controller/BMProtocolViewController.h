//
//  BMProtocolViewController.h
//  特种车调度
//
//  Created by 王鑫 on 16/3/10.
//
//

#import <UIKit/UIKit.h>

typedef void(^ReturnAgree)(BOOL isAgree);

@interface BMProtocolViewController : UIViewController

@property (nonatomic, copy) ReturnAgree returnAgree;
@property (nonatomic, copy) NSURL *path;

/**
 *  1:使用指南
 *  2:关于平台
 *  3:注册协议
 */

@property (nonatomic, assign) NSUInteger type;

- (void) isAgree:(ReturnAgree) block;
@end
