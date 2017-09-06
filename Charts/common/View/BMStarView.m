//
//  BMStarView.m
//  特种车调度
//
//  Created by 陈宇 on 15/8/31.
//
//

#import "BMStarView.h"

@implementation BMStarView

- (void)setLevel:(NSUInteger)level
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    if (level > 10) {
        level = 10;
    }
    NSUInteger count = level / 2;
    BOOL half = level % 2;
    
    for (int i = 0; i < count; i++) {
        UIImageView *leftImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"star_yellow_small_left"]];
        [self addSubview:leftImage];
        UIImageView *rightImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"star_yellow_small_right"]];
        [self addSubview:rightImage];
    }
    if (half) {
        UIImageView *leftImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"star_yellow_small_left"]];
        [self addSubview:leftImage];
        UIImageView *rightImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"star_gray_small_right"]];
        [self addSubview:rightImage];
    }
    NSUInteger empty = 5 - count -(half ? 1 : 0);
    for (int i = 0; i < empty; i++) {
        UIImageView *leftImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"star_gray_small_left"]];
        [self addSubview:leftImage];
        UIImageView *rightImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"star_gray_small_right"]];
        [self addSubview:rightImage];
    }
    
    [self setNeedsLayout];
}

- (void)setFrame:(CGRect)frame
{
    frame.size = CGSizeMake(90.f, 17.f);
    [super setFrame:frame];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat centerY = self.height / 2;
    
    NSArray *subViews = self.subviews;
    for (int i = 0; i < subViews.count; i++) {
        UIView *subView = subViews[i];
        subView.x = 4.5 * i;
        subView.centerY = centerY;
    }
}

@end
