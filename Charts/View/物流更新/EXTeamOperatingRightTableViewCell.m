//
//  EXTeamOperatingRightTableViewCell.m
//  Charts
//
//  Created by Eleven on 16/9/7.
//  Copyright © 2016年 Eleven. All rights reserved.
//

#import "EXTeamOperatingRightTableViewCell.h"

@interface EXTeamOperatingRightTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *HandleDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *VehicleNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *VehicleTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *NormaltranNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *NotNormaltranNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *RenttranNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *NormalNumberTotalLabel;
@property (weak, nonatomic) IBOutlet UILabel *CompensateNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *OtherCompensateNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *TotalNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *NumberAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *TimeOutLabel;
@property (weak, nonatomic) IBOutlet UILabel *BuildingDehydrationLabel;
@property (weak, nonatomic) IBOutlet UILabel *LeaveReturnLabel;
@property (weak, nonatomic) IBOutlet UILabel *DehydrationLabel;
@property (weak, nonatomic) IBOutlet UILabel *PatchoilLabel;
@property (weak, nonatomic) IBOutlet UILabel *OtherPatchLabel;
@property (weak, nonatomic) IBOutlet UILabel *PatchTotalLabel;
@property (weak, nonatomic) IBOutlet UILabel *RenttranAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *TotalAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *UserOilLabel;
@property (weak, nonatomic) IBOutlet UILabel *OilPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *OilCostLabel;
@property (weak, nonatomic) IBOutlet UILabel *TyreCostLabel;
@property (weak, nonatomic) IBOutlet UILabel *VehiclePremiumLabel;
@property (weak, nonatomic) IBOutlet UILabel *AccidentCostLabel;
@property (weak, nonatomic) IBOutlet UILabel *RepairCostLabel;
@property (weak, nonatomic) IBOutlet UILabel *RepairHourCostLabel;
@property (weak, nonatomic) IBOutlet UILabel *TrafficCostLabel;
@property (weak, nonatomic) IBOutlet UILabel *DepreciationCostLabel;
@property (weak, nonatomic) IBOutlet UILabel *ManageCostLabel;
@property (weak, nonatomic) IBOutlet UILabel *JumpCostLabel;
@property (weak, nonatomic) IBOutlet UILabel *SimpleCarProfitLabel;
@property (weak, nonatomic) IBOutlet UILabel *CarTeamProfitLabel;
@property (weak, nonatomic) IBOutlet UILabel *CarProfitLabel;
@property (weak, nonatomic) IBOutlet UILabel *SimpleTranCapLabel;
@property (weak, nonatomic) IBOutlet UILabel *TranCapCompeleLabel;
@property (weak, nonatomic) IBOutlet UILabel *TotalCostLabel;
@property (weak, nonatomic) IBOutlet UILabel *SimpleMoneyLabel;

@end

@implementation EXTeamOperatingRightTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTeamOperatingData:(EXTeamOperatingData *)teamOperatingData{
    _teamOperatingData = teamOperatingData;
    _HandleDateLabel.text = teamOperatingData.HandleDate;
    _VehicleNumberLabel.text = teamOperatingData.VehicleNumber;
    _VehicleTypeLabel.text = teamOperatingData.VehicleType;
    _NormaltranNumberLabel.text = teamOperatingData.NormaltranNumber;
    _NotNormaltranNumberLabel.text = teamOperatingData.NotNormaltranNumber;
    _RenttranNumberLabel.text = teamOperatingData.RenttranNumber;
    _NormalNumberTotalLabel.text = teamOperatingData.NormalNumberTotal;
    _CompensateNumberLabel.text = teamOperatingData.CompensateNumber;
    _OtherCompensateNumberLabel.text = teamOperatingData.OtherCompensateNumber;
    _TotalNumberLabel.text = teamOperatingData.TotalNumber;
    _NumberAmountLabel.text = teamOperatingData.NumberAmount;
    _TimeOutLabel.text = teamOperatingData.TimeOut;
    _BuildingDehydrationLabel.text = teamOperatingData.BuildingDehydration;
    _LeaveReturnLabel.text = teamOperatingData.LeaveReturn;
    _DehydrationLabel.text = teamOperatingData.Dehydration;
    _PatchoilLabel.text = teamOperatingData.Patchoil;
    _OtherPatchLabel.text = teamOperatingData.OtherPatch;
    _PatchTotalLabel.text = teamOperatingData.PatchTotal;
    _RenttranAmountLabel.text = teamOperatingData.RenttranAmount;
    _TotalAmountLabel.text = teamOperatingData.TotalAmount;
    _UserOilLabel.text = teamOperatingData.UserOil;
    _OilPriceLabel.text = teamOperatingData.OilPrice;
    _OilCostLabel.text = teamOperatingData.OilCost;
    _TyreCostLabel.text = teamOperatingData.TyreCost;
    _VehiclePremiumLabel.text = teamOperatingData.VehiclePremium;
    _AccidentCostLabel.text = teamOperatingData.AccidentCost;
    _RepairCostLabel.text = teamOperatingData.RepairCost;
    _RepairHourCostLabel.text = teamOperatingData.RepairHourCost;
    _TrafficCostLabel.text = teamOperatingData.TrafficCost;
    _DepreciationCostLabel.text = teamOperatingData.DepreciationCost;
    _ManageCostLabel.text = teamOperatingData.ManageCost;
    _JumpCostLabel.text = teamOperatingData.JumpCost;
    _SimpleCarProfitLabel.text = teamOperatingData.SimpleCarProfit;
    _CarTeamProfitLabel.text = teamOperatingData.CarTeamProfit;
    _CarProfitLabel.text = teamOperatingData.CarProfit;
    _SimpleTranCapLabel.text = teamOperatingData.SimpleTranCap;
    _TranCapCompeleLabel.text = teamOperatingData.TranCapCompele;
    _TotalCostLabel.text = teamOperatingData.TotalCost;
    _SimpleMoneyLabel.text = teamOperatingData.SimpleMoney;
}

@end
