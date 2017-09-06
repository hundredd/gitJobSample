//
//  BMEmptyView.m
//  特种车调度
//
//  Created by 陈宇 on 15/8/20.
//
//

#import "BMEmptyView.h"

@interface BMEmptyView ()

@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UILabel *titleLabel;

@end

@implementation BMEmptyView

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
    self.backgroundColor = BMColor(245, 245, 247, 1);
    UIImageView *imageView = [[UIImageView alloc] init];
    [self addSubview:imageView];
    self.imageView = imageView;
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:13.f];
    label.textColor = [UIColor lightGrayColor];
    [self addSubview:label];
    self.titleLabel = label;
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self).multipliedBy(0.8);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.imageView.mas_bottom).offset(20);
    }];
}

- (void)setMessage:(NSString *)message
{
    _message = [message copy];
    self.titleLabel.text = message;
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    self.imageView.image = _image;
}

@end
