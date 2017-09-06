//
//  BMShadowView.m
//  特种车调度
//
//  Created by 陈宇 on 15/8/23.
//
//

#import "BMShadowView.h"

@implementation BMShadowView

- (instancetype)init
{
    if (self = [super init]) {
        [self configuration];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self configuration];
    }
    return self;
}

- (void)configuration
{   
    UIView *innerView = [[UIView alloc] init];
    innerView.layer.shadowColor = [UIColor grayColor].CGColor;
    innerView.layer.shadowOffset = CGSizeMake(0.f, 1.5f);
    innerView.layer.shadowRadius = 0.f;
    innerView.layer.shadowOpacity = 0.1;
    innerView.backgroundColor = [UIColor whiteColor];
    [self addSubview:innerView];
    [innerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(10.f);
        make.right.mas_equalTo(self).offset(-10.f);
        make.top.bottom.mas_equalTo(self);
    }];
}

@end
