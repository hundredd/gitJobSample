//
//  EXProductionDataRightTableViewCell.m
//  Charts
//
//  Created by Eleven on 16/9/1.
//  Copyright © 2016年 Eleven. All rights reserved.
//

#import "EXProductionDataRightTableViewCell.h"

@interface EXProductionDataRightTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *unitLabel;
@property (weak, nonatomic) IBOutlet UILabel *partsLabel;
@property (weak, nonatomic) IBOutlet UILabel *wayLabel;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderLabel;
@property (weak, nonatomic) IBOutlet UILabel *volumeLabel;
@property (weak, nonatomic) IBOutlet UILabel *ConManLabel;
@property (weak, nonatomic) IBOutlet UILabel *ConTelLabel;

@end

@implementation EXProductionDataRightTableViewCell

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setProduction:(EXProduction *)production{
    _production = production;
    _nameLabel.text = production.ProjectName;
    _unitLabel.text = production.UnitName;
    _partsLabel.text = production.ParticularPart;
    _wayLabel.text = production.PlyPlan;
    _levelLabel.text = production.ProductGrade;
    _orderLabel.text = production.vehicleno;
    _volumeLabel.text = production.Number;
    _ConManLabel.text = production.ConMan;
    _ConTelLabel.text = production.ConTel;
}

@end
