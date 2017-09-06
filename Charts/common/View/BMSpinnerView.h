//
//  BMSpinnerView.h
//  项目结构
//
//  Created by 陈宇 on 15/10/30.
//  Copyright © 2015年 陈宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BMSpinnerView;

@protocol BMSpinnerViewDelegate <NSObject>

@optional
- (void)spinner:(BMSpinnerView *)spinner didSelectIndex:(NSIndexPath *)indexPath;

@end

@interface BMSpinnerView : UITableView

@property (nonatomic, assign) BOOL touchOutsideHide;

//@property (nonatomic, strong) NSArray *dataSource;

//@property (nonatomic, weak) id<BMSpinnerViewDelegate> delegate;

- (void)showBelowWith:(UIView *)target;

- (void)hideWithAnimate:(BOOL)animate;

@end
