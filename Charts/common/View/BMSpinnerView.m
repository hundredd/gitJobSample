//
//  BMSpinnerView.m
//  项目结构
//
//  Created by 陈宇 on 15/10/30.
//  Copyright © 2015年 陈宇. All rights reserved.
//

#import "BMSpinnerView.h"

static UIWindow *_window;
static UIButton *_cover;

@interface StatusBarLightController : UIViewController

@end

@implementation StatusBarLightController

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return [UIApplication sharedApplication].keyWindow.rootViewController.preferredStatusBarStyle;
}

@end

@implementation BMSpinnerView

#pragma mark - 生命周期方法
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self initialize];
    }
    return self;
}

#pragma mark - 私有方法
- (void)initialize
{
    _touchOutsideHide = YES;
    self.layer.cornerRadius = 2.f;
}

#pragma mark - 公开开发
- (void)showBelowWith:(UIView *)target
{
    [self reloadData];
    
    _window = [[UIWindow alloc] init];
    _window.hidden = NO;
    _window.windowLevel = UIWindowLevelAlert;
    _window.frame = [UIScreen mainScreen].bounds;
    _window.backgroundColor = [UIColor clearColor];
    _window.rootViewController = [StatusBarLightController new];
    
    _cover = [UIButton new];
    _cover.frame = _window.frame;
    _cover.backgroundColor = [UIColor clearColor];
    [_cover addTarget:self action:@selector(hideWithAnimate:) forControlEvents:UIControlEventTouchUpInside];
    _cover.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [_window addSubview:_cover];
    
    CGRect frame = [target.superview convertRect:target.frame toView:target.window];
    //计算targetview之下还有多少高度
    CGFloat useHeight = _window.height - CGRectGetMaxY(frame) - 5.f;
    self.height = 0.f;
    self.width = frame.size.width;
    self.origin = CGPointMake(frame.origin.x, CGRectGetMaxY(frame));
    [_window addSubview:self];
    
    [UIView animateWithDuration:kDefaultAnimDuration delay:0.f usingSpringWithDamping:1.0 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        _cover.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.15];
        if (useHeight >= self.contentSize.height) {
            self.height = self.contentSize.height;
        } else {
            self.height = useHeight;
        }
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hideWithAnimate:(BOOL)animate
{
    [UIView animateWithDuration:kDefaultAnimDuration delay:0.f usingSpringWithDamping:0.9 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        _cover.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.0f];
        self.height = 0.f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [_cover removeFromSuperview];
        _cover = nil;
        _window = nil;
    }];
}

@end
