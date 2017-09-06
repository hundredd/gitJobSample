//
//  RYCornerButton.m
//  特种车调度
//
//  Created by 韩学鹏 on 16/3/4.
//
//

#import "RYCornerButton.h"

@implementation RYCornerButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
    }
    
    return self;
}


//最先被调用
- (void)awakeFromNib{
    NSLayoutConstraint *cons = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:50];
    [self addConstraint:cons];
}

@end
