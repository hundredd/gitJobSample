//
//  EXEXLogisticsUpdateRightTableViewCell.m
//  Charts
//
//  Created by Eleven on 16/9/6.
//  Copyright © 2016年 Eleven. All rights reserved.
//

#import "EXLogisticsUpdateRightTableViewCell.h"

@interface EXLogisticsUpdateRightTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *HandleDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *AutoNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *CfgNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *VehicleTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *ModelNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *VehicleInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *BuyVehicleDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *VehicleFrameNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *EngineNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *SourcePriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *BuyPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *LastedDepreciationLabel;
@property (weak, nonatomic) IBOutlet UILabel *NetAssetLabel;
@property (weak, nonatomic) IBOutlet UILabel *PlanUserAgeLabel;
@property (weak, nonatomic) IBOutlet UILabel *DepreciationAgeLabel;
@property (weak, nonatomic) IBOutlet UILabel *CurrentDepreciationMonryLabel;
@property (weak, nonatomic) IBOutlet UILabel *AssessMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *PassportStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *YearCheckDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *BuyDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *StrongDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *BusinessDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *StrongMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *BusinessMoneyLabel;

@end

@implementation EXLogisticsUpdateRightTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setEquipmentInfo:(EXEquipmentInfo *)equipmentInfo{
    _equipmentInfo = equipmentInfo;
    _HandleDateLabel.text = equipmentInfo.HandleDate;
    _AutoNumberLabel.text = equipmentInfo.AutoNumber;
    _CfgNoLabel.text = equipmentInfo.CfgNo;
    _VehicleTypeLabel.text = equipmentInfo.VehicleType;
    _ModelNumberLabel.text = equipmentInfo.ModelNumber;
    _VehicleInfoLabel.text = equipmentInfo.VehicleInfo;
    _BuyVehicleDateLabel.text = equipmentInfo.BuyVehicleDate;
    _VehicleFrameNumberLabel.text = equipmentInfo.VehicleFrameNumber;
    _EngineNumberLabel.text = equipmentInfo.EngineNumber;
    _SourcePriceLabel.text = equipmentInfo.SourcePrice;
    _BuyPriceLabel.text = equipmentInfo.BuyPrice;
    _LastedDepreciationLabel.text = equipmentInfo.LastedDepreciation;
    _NetAssetLabel.text = equipmentInfo.NetAsset;
    _PlanUserAgeLabel.text = equipmentInfo.PlanUserAge;
    _DepreciationAgeLabel.text = equipmentInfo.DepreciationAge;
    _CurrentDepreciationMonryLabel.text = equipmentInfo.CurrentDepreciationMonry;
    _AssessMoneyLabel.text = equipmentInfo.AssessMoney;
    _PassportStatusLabel.text = equipmentInfo.PassportStatus;
    _YearCheckDateLabel.text = equipmentInfo.YearCheckDate;
    _BuyDateLabel.text = equipmentInfo.BuyDate;
    _StrongDateLabel.text = equipmentInfo.StrongDate;
    _BusinessDateLabel.text = equipmentInfo.BusinessDate;
    _StrongMoneyLabel.text = equipmentInfo.StrongMoney;
    _BusinessMoneyLabel.text = equipmentInfo.BusinessMoney;
}

@end
