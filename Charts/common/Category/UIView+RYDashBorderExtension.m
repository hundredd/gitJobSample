//
//  UIView+RYDashBorderExtension.m
//  特种车调度
//
//  Created by 韩学鹏 on 16/3/30.
//
//

#import "UIView+RYDashBorderExtension.h"

@implementation UIView (RYDashBorderExtension)

- (void)setDashLineBorder:(UIColor *)color
{
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.frame = CGRectMake(self.bounds.origin.x,self.bounds.origin.y, self.bounds.size.width, self.bounds.size.height);
    borderLayer.path = [UIBezierPath bezierPathWithRoundedRect:borderLayer.frame cornerRadius:0].CGPath;
    borderLayer.lineDashPattern = @[@3,@3];
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    borderLayer.strokeColor = color.CGColor;
    [self.layer addSublayer:borderLayer];
}


@end
