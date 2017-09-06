//
//  BMNewFeatureController.m
//  ZPM
//
//  Created by 陈宇 on 15/3/20.
//  Copyright (c) 2015年 陈宇. All rights reserved.
//

#import "BMNewFeatureController.h"
#import "BMMainTool.h"

const CGFloat kMaxFeatureCount = 4;

@interface BMNewFeatureController () <UIScrollViewDelegate>
{
    UIPageControl *_pageControl;
}
@end

@implementation BMNewFeatureController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //添加scrollview
    [self setupScrollView];
    
    //添加pageControl
    //[self setupPageControl];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark - 私有方法
- (void)setupScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = YES;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    // 添加新特性图片
    for (int i = 0; i < kMaxFeatureCount; i++) {
        NSString *imgName = [NSString stringWithFormat:@"feature%d", i + 1];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imgName]];
        imageView.origin = CGPointMake(kScreenWidth * i, 0);
        imageView.size = CGSizeMake(kScreenWidth, kScreenHeight);
        imageView.backgroundColor = BMRandomColor;
        [scrollView addSubview:imageView];
        if (i == kMaxFeatureCount - 1) {
            imageView.userInteractionEnabled = YES;
            [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goHomeAction)]];
        }
    }
    scrollView.contentSize = CGSizeMake(kScreenWidth * kMaxFeatureCount, 0);
    [self.view addSubview:scrollView];
}

- (void)setupPageControl
{
    UIPageControl *control = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30.f)];
    control.center = CGPointMake(kScreenWidth * 0.5, kScreenHeight * 0.9);
    control.numberOfPages = kMaxFeatureCount;
    control.pageIndicatorTintColor = [UIColor grayColor];
    control.currentPageIndicatorTintColor = kGlobalColor;
    [self.view addSubview:control];
    _pageControl = control;
}

- (void)goHomeAction
{
    [BMUtils updateFeatureVersion];
    kWindow.rootViewController = [BMMainTool chooseRootViewController];
}

#pragma mark - scrollview代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSUInteger page = (scrollView.contentOffset.x / kScreenWidth) + 0.5;
    _pageControl.currentPage = page;
}

@end
