//
//  UIView+RYCorner.m
//  特种车调度
//
//  Created by 韩学鹏 on 16/3/29.
//
//

#import "UIView+RYCorner.h"

@implementation UIView (RYCorner)

- (void)showCorner
{
    self.layer.cornerRadius = 5.0f;
    self.layer.masksToBounds = YES;
}

@end
