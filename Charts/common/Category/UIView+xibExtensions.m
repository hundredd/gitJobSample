//
//  UIView+xibExtensions.m
//  特种车调度
//
//  Created by 韩学鹏 on 16/3/30.
//
//

#import "UIView+xibExtensions.h"

@implementation UIView (xibExtensions)

+ (id)createViewWithNib
{
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
    return nibContents.firstObject;
}

@end
