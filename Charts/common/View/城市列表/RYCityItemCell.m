//
//  RYCityItemCell.m
//  特种车调度
//
//  Created by 韩学鹏 on 16/3/23.
//
//

#import "RYCityItemCell.h"

@interface RYCityItemCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *customBgView;
@property (weak, nonatomic) IBOutlet UIImageView *nextAreaImageView;

@property (strong, nonatomic) UIColor *originColor;

@end

@implementation RYCityItemCell

- (void)awakeFromNib {
    // Initialization code
    self.originColor = self.customBgView.backgroundColor;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
    switch (_type) {
        case 0:{
            self.customBgView.backgroundColor = selected ? [UIColor whiteColor] : self.originColor;
        }break;
        case 1:
        case 2:{
            //self.customBgView.backgroundColor = selected ? self.originColor : [UIColor whiteColor];
            self.titleLabel.textColor = selected ? kGlobalColor : [UIColor blackColor];
        }break;
        default:
            break;
    }
    
}

- (void)setCity:(BMCity *)city
{
    _city = city;
    self.titleLabel.text = _city.name;
    self.nextAreaImageView.hidden = city.nextArea.count<=0;
}

- (void)setType:(NSInteger)type
{
    _type = type;
    
    if (_type!=0) {
        self.customBgView.backgroundColor = [UIColor whiteColor];
    }
}

@end
