//
//  EXMValueRightTableViewCell.m
//  Charts
//
//  Created by Eleven on 16/9/7.
//  Copyright © 2016年 Eleven. All rights reserved.
//

#import "EXMValueRightTableViewCell.h"

@interface EXMValueRightTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *HandleDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *SubjectNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *SubjectNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *PayUnitLabel;
@property (weak, nonatomic) IBOutlet UILabel *DutyManLabel;
@property (weak, nonatomic) IBOutlet UILabel *ProductNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *ProductValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *MaterialCostLabel;
@property (weak, nonatomic) IBOutlet UILabel *BusinessPushMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *CustomerServiceCostLabel;
@property (weak, nonatomic) IBOutlet UILabel *BetweenCostLabel;
@property (weak, nonatomic) IBOutlet UILabel *TaxMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *TransportcostLabel;
@property (weak, nonatomic) IBOutlet UILabel *JumpCostLabel;
@property (weak, nonatomic) IBOutlet UILabel *FinanceCostLabel;
@property (weak, nonatomic) IBOutlet UILabel *StationShareLabel;
@property (weak, nonatomic) IBOutlet UILabel *GroupShareLabel;
@property (weak, nonatomic) IBOutlet UILabel *BaseHvalueLabel;
@property (weak, nonatomic) IBOutlet UILabel *CurrentMvalueLabel;
@property (weak, nonatomic) IBOutlet UILabel *LastedMvalueLabel;

@end

@implementation EXMValueRightTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMvalueData:(MValueData *)mvalueData{
    _mvalueData = mvalueData;
    _HandleDateLabel.text = mvalueData.HandleDate;
    _SubjectNumberLabel.text = mvalueData.SubjectNumber;
    _SubjectNameLabel.text = mvalueData.SubjectName;
    _PayUnitLabel.text = mvalueData.PayUnit;
    _DutyManLabel.text = mvalueData.DutyMan;
    _ProductNumberLabel.text = mvalueData.ProductNumber;
    _ProductValueLabel.text = mvalueData.ProductValue;
    _MaterialCostLabel.text = mvalueData.MaterialCost;
    _BusinessPushMoneyLabel.text = mvalueData.BusinessPushMoney;
    _CustomerServiceCostLabel.text = mvalueData.CustomerServiceCost;
    _BetweenCostLabel.text = mvalueData.BetweenCost;
    _TaxMoneyLabel.text = mvalueData.TaxMoney;
    _TransportcostLabel.text = mvalueData.Transportcost;
    _JumpCostLabel.text = mvalueData.JumpCost;
    _FinanceCostLabel.text = mvalueData.FinanceCost;
    _StationShareLabel.text = mvalueData.StationShare;
    _GroupShareLabel.text = mvalueData.GroupShare;
    _BaseHvalueLabel.text = mvalueData.BaseHvalue;
    _CurrentMvalueLabel.text = mvalueData.CurrentMvalue;
    _LastedMvalueLabel.text = mvalueData.LastedMvalue;
}

@end
