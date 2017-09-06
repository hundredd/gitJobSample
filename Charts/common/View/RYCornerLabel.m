//
//  RYCornerLabel.m
//  特种车调度
//
//  Created by 韩学鹏 on 16/3/10.
//
//

#import "RYCornerLabel.h"

@implementation RYCornerLabel

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        self.layer.cornerRadius = 5.0f;
        self.layer.masksToBounds = YES;
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
