//
//  EXHeaderView.m
//  Charts
//
//  Created by Eleven on 16/9/29.
//  Copyright © 2016年 Eleven. All rights reserved.
//

#import "EXHeaderView.h"

@interface EXHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation EXHeaderView

- (void)setHeaderTitle:(NSString *)headerTitle{
    _headerTitle = headerTitle;
    _titleLabel.text = headerTitle;
}
@end
