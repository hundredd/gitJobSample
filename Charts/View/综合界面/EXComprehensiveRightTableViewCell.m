//
//  EXComprehensiveRightTableViewCell.m
//  Charts
//
//  Created by Eleven on 16/9/5.
//  Copyright © 2016年 Eleven. All rights reserved.
//

#import "EXComprehensiveRightTableViewCell.h"
@interface EXComprehensiveRightTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *SalesVolumeLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastyearSalesVolumeLabel;
@property (weak, nonatomic) IBOutlet UILabel *MainBusLabel;
@property (weak, nonatomic) IBOutlet UILabel *MainBusAdverbsLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastyearMainBusLabel;
@property (weak, nonatomic) IBOutlet UILabel *RawMaterialCostLabel;
@property (weak, nonatomic) IBOutlet UILabel *RawMaterialCostAdverbsLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastyearRawMaterialCostLabel;
@property (weak, nonatomic) IBOutlet UILabel *ManufacturingCostsLabel;
@property (weak, nonatomic) IBOutlet UILabel *ManufacturingCostsAdverbsLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastyearManufacturingCostsLabel;
@property (weak, nonatomic) IBOutlet UILabel *LogisticsCostsLabel;
@property (weak, nonatomic) IBOutlet UILabel *LogisticsCostsAdverbsLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastyearLogisticsCostsLabel;
@property (weak, nonatomic) IBOutlet UILabel *SalesCostsLabel;
@property (weak, nonatomic) IBOutlet UILabel *SalesCostsAdverbsLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastyearSalesCostsLabel;
@property (weak, nonatomic) IBOutlet UILabel *ManagementCostsLabel;
@property (weak, nonatomic) IBOutlet UILabel *ManagementCostsAdverbsLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastyearManagementCostsLabel;
@property (weak, nonatomic) IBOutlet UILabel *FinancialExpensesLabel;
@property (weak, nonatomic) IBOutlet UILabel *FinancialExpensesAdverbsLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastyearFinancialExpensesLabel;
@property (weak, nonatomic) IBOutlet UILabel *MainCostTotalsLabel;
@property (weak, nonatomic) IBOutlet UILabel *MainCostTotalsAdverbsLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastyearMainCostTotalsLabel;
@property (weak, nonatomic) IBOutlet UILabel *MainProfitLabel;
@property (weak, nonatomic) IBOutlet UILabel *MainProfitAdverbsLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastyearMainProfitLabel;
@property (weak, nonatomic) IBOutlet UILabel *MainProfitMarginLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastyearMainProfitMarginLabel;
@property (weak, nonatomic) IBOutlet UILabel *InvestmentCostsLabel;
@property (weak, nonatomic) IBOutlet UILabel *InvestmentCostsAdverbsLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastyearInvestmentCostsLabel;
@property (weak, nonatomic) IBOutlet UILabel *OtherOperationsCostsLabel;
@property (weak, nonatomic) IBOutlet UILabel *OtherOperationsCostsAdverbsLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastyearOtherOperationsCostsLabel;
@property (weak, nonatomic) IBOutlet UILabel *NotOperatingCostsLabel;
@property (weak, nonatomic) IBOutlet UILabel *NotOperatingCostsAdverbsLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastyearNotOperatingCostsLabel;
@property (weak, nonatomic) IBOutlet UILabel *NotOperatingExpensesLabel;
@property (weak, nonatomic) IBOutlet UILabel *NotOperatingExpensesAdverbsLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastyearNotOperatingExpensesLabel;
@property (weak, nonatomic) IBOutlet UILabel *ProfitLabel;
@property (weak, nonatomic) IBOutlet UILabel *ProfitAdverbsLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastyearProfitLabel;
@property (weak, nonatomic) IBOutlet UILabel *ProfitRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastyearProfitRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *CostRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastyearCostRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *SalesChargeRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastyearSalesChargeRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *ManagementExpenseRatioLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastyearManagementExpenseRatioLabel;
@property (weak, nonatomic) IBOutlet UILabel *FinanceChargeRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastyearFinanceChargeRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *RecoveryAccountsReceivableLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastyearRecoveryAccountsReceivableLabel;
@property (weak, nonatomic) IBOutlet UILabel *CashFlowCashLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastyearCashFlowCashLabel;
@property (weak, nonatomic) IBOutlet UILabel *ReceivableBalancesLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastyearReceivableBalancesLabel;
@property (weak, nonatomic) IBOutlet UILabel *BalanceDueLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastyearBalanceDueLabel;

@end

@implementation EXComprehensiveRightTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setComprehensiveData:(EXComprehensiveData *)comprehensiveData{
    _comprehensiveData = comprehensiveData;
    _SalesVolumeLabel.text = comprehensiveData.SalesVolume;
    _lastyearSalesVolumeLabel.text = comprehensiveData.lastyearSalesVolume;
    _MainBusLabel.text = comprehensiveData.MainBus;
    _MainBusAdverbsLabel.text = comprehensiveData.MainBusAdverbs;
    _lastyearMainBusLabel.text = comprehensiveData.lastyearMainBus;
    _RawMaterialCostLabel.text = comprehensiveData.RawMaterialCost;
    _RawMaterialCostAdverbsLabel.text = comprehensiveData.RawMaterialCostAdverbs;
    _lastyearRawMaterialCostLabel.text = comprehensiveData.lastyearRawMaterialCost;
    _ManufacturingCostsLabel.text = comprehensiveData.ManufacturingCosts;
    _ManufacturingCostsAdverbsLabel.text = comprehensiveData.ManufacturingCostsAdverbs;
    _lastyearManufacturingCostsLabel.text = comprehensiveData.lastyearManufacturingCosts;
    _LogisticsCostsLabel.text = comprehensiveData.LogisticsCosts;
    _LogisticsCostsAdverbsLabel.text = comprehensiveData.LogisticsCostsAdverbs;
    _lastyearLogisticsCostsLabel.text = comprehensiveData.lastyearLogisticsCosts;
    _SalesCostsLabel.text = comprehensiveData.SalesCosts;
    _SalesCostsAdverbsLabel.text = comprehensiveData.SalesCostsAdverbs;
    _lastyearSalesCostsLabel.text = comprehensiveData.lastyearSalesCosts;
    _ManagementCostsLabel.text = comprehensiveData.ManagementCosts;
    _ManagementCostsAdverbsLabel.text = comprehensiveData.ManagementCostsAdverbs;
    _lastyearManagementCostsLabel.text = comprehensiveData.lastyearManagementCosts;
    _FinancialExpensesLabel.text = comprehensiveData.FinancialExpenses;
    _FinancialExpensesAdverbsLabel.text = comprehensiveData.FinancialExpensesAdverbs;
    _lastyearFinancialExpensesLabel.text = comprehensiveData.lastyearFinancialExpenses;
    _MainCostTotalsLabel.text = comprehensiveData.MainCostTotals;
    _MainCostTotalsAdverbsLabel.text = comprehensiveData.MainCostTotalsAdverbs;
    _lastyearMainCostTotalsLabel.text = comprehensiveData.lastyearMainCostTotals;
    _MainProfitLabel.text = comprehensiveData.MainProfit;
    _MainProfitAdverbsLabel.text = comprehensiveData.MainProfitAdverbs;
    _lastyearMainProfitLabel.text = comprehensiveData.lastyearMainProfit;
    _MainProfitMarginLabel.text = comprehensiveData.MainProfitMargin;
    _lastyearMainProfitMarginLabel.text = comprehensiveData.lastyearMainProfitMargin;
    _InvestmentCostsLabel.text = comprehensiveData.InvestmentCosts;
    _InvestmentCostsAdverbsLabel.text = comprehensiveData.InvestmentCostsAdverbs;
    _lastyearInvestmentCostsLabel.text = comprehensiveData.lastyearInvestmentCosts;
    _OtherOperationsCostsLabel.text = comprehensiveData.OtherOperationsCosts;
    _OtherOperationsCostsAdverbsLabel.text = comprehensiveData.OtherOperationsCostsAdverbs;
    _lastyearOtherOperationsCostsLabel.text = comprehensiveData.lastyearOtherOperationsCosts;
    _NotOperatingCostsLabel.text = comprehensiveData.NotOperatingCosts;
    _NotOperatingCostsAdverbsLabel.text = comprehensiveData.NotOperatingCostsAdverbs;
    _lastyearNotOperatingCostsLabel.text = comprehensiveData.lastyearNotOperatingCosts;
    _NotOperatingExpensesLabel.text = comprehensiveData.NotOperatingExpenses;
    _NotOperatingExpensesAdverbsLabel.text = comprehensiveData.NotOperatingExpensesAdverbs;
    _lastyearNotOperatingExpensesLabel.text = comprehensiveData.lastyearNotOperatingExpenses;
    _ProfitLabel.text = comprehensiveData.Profit;
    _ProfitAdverbsLabel.text = comprehensiveData.ProfitAdverbs;
    _lastyearProfitLabel.text = comprehensiveData.lastyearProfit;
    _ProfitRateLabel.text = comprehensiveData.ProfitRate;
    _lastyearProfitRateLabel.text = comprehensiveData.lastyearProfitRate;
    _CostRateLabel.text = comprehensiveData.CostRate;
    _lastyearCostRateLabel.text = comprehensiveData.lastyearCostRate;
    _SalesChargeRateLabel.text = comprehensiveData.SalesChargeRate;
    _lastyearSalesChargeRateLabel.text = comprehensiveData.lastyearSalesChargeRate;
    _ManagementExpenseRatioLabel.text = comprehensiveData.ManagementExpenseRatio;
    _lastyearManagementExpenseRatioLabel.text = comprehensiveData.lastyearManagementExpenseRatio;
    _FinanceChargeRateLabel.text = comprehensiveData.FinanceChargeRate;
    _lastyearFinanceChargeRateLabel.text = comprehensiveData.FinanceChargeRate;
    _RecoveryAccountsReceivableLabel.text = comprehensiveData.RecoveryAccountsReceivable;
    _lastyearRecoveryAccountsReceivableLabel.text = comprehensiveData.lastyearRecoveryAccountsReceivable;
    _CashFlowCashLabel.text = comprehensiveData.CashFlowCash;
    _lastyearCashFlowCashLabel.text = comprehensiveData.lastyearCashFlowCash;
    _ReceivableBalancesLabel.text = comprehensiveData.ReceivableBalances;
    _lastyearReceivableBalancesLabel.text = comprehensiveData.lastyearReceivableBalances;
    _BalanceDueLabel.text = comprehensiveData.BalanceDue;
    _lastyearBalanceDueLabel.text = comprehensiveData.lastyearBalanceDue;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
