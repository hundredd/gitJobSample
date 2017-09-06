//
//  BMSpinner.h
//  特种车调度
//
//  Created by 陈宇 on 15/8/29.
//
//

#import <UIKit/UIKit.h>

@interface BMSpinner : UIView

@property (nonatomic, strong) NSArray *datas;

@property (nonatomic, assign) CGPoint origin;

@property (nonatomic, assign, readonly, getter=isShow) BOOL show;

@property (nonatomic, copy) void(^selected)(NSIndexPath *indexPath);

- (void)show;

- (void)hide;

@end
