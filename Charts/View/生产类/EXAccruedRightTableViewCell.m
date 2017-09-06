//
//  EXAccruedRightTableViewCell.m
//  Charts
//
//  Created by Eleven on 16/9/5.
//  Copyright © 2016年 Eleven. All rights reserved.
//

#import "EXAccruedRightTableViewCell.h"

@interface EXAccruedRightTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *BeginRecivableBalanceMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *BeginPayableBalanceMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *CurrentRecivbleMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *CurrentPayableMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *yeartargetMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearHandleRemainMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearReturnedpreLabel;
@property (weak, nonatomic) IBOutlet UILabel *CurrentReturnPlanMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthReturnMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *CurrentPayablePlanMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthpayMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthohterpayMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearReturnedMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *CrowdMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *BrankLoanMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *GroupBorrowMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *OtherBorrowMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *CurrentMoneyLabel;
@end

@implementation EXAccruedRightTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setAccruedData:(EXAccruedData *)accruedData{
    _accruedData = accruedData;
    _BeginRecivableBalanceMoneyLabel.text = accruedData.BeginRecivableBalanceMoney;
    _BeginPayableBalanceMoneyLabel.text = accruedData.BeginPayableBalanceMoney;
    _CurrentRecivbleMoneyLabel.text = accruedData.CurrentRecivbleMoney;
    _CurrentPayableMoneyLabel.text = accruedData.CurrentPayableMoney;
    _yeartargetMoneyLabel.text = accruedData.yeartargetMoney;
    _yearHandleRemainMoneyLabel.text = accruedData.yearHandleRemainMoney;
    _yearReturnedpreLabel.text = accruedData.yearReturnedpre;
    _CurrentReturnPlanMoneyLabel.text = accruedData.CurrentReturnPlanMoney;
    _monthReturnMoneyLabel.text = accruedData.monthReturnMoney;
    _CurrentPayablePlanMoneyLabel.text = accruedData.CurrentPayablePlanMoney;
    _monthpayMoneyLabel.text = accruedData.monthpayMoney;
    _monthohterpayMoneyLabel.text = accruedData.monthohterpayMoney;
    _yearReturnedMoneyLabel.text = accruedData.yearReturnedMoney;
    _CrowdMoneyLabel.text = accruedData.CrowdMoney;
    _BrankLoanMoneyLabel.text = accruedData.BrankLoanMoney;
    _GroupBorrowMoneyLabel.text = accruedData.GroupBorrowMoney;
    _OtherBorrowMoneyLabel.text = accruedData.OtherBorrowMoney;
    _CurrentMoneyLabel.text = accruedData.CurrentMoney;
}

@end
