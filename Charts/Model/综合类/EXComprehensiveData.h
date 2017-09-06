//
//  EXComprehensiveData.h
//  Charts
//
//  Created by Eleven on 16/9/8.
//  Copyright © 2016年 Eleven. All rights reserved.
//

#import <BM4Group/BM4Group.h>

@interface EXComprehensiveData : BMBaseModel
/**
 *  销量
 */
@property (nonatomic, copy) NSString *SalesVolume;
/**
 *  销售-本年度累计
 */
@property (nonatomic, copy) NSString *lastyearSalesVolume;
/**
 *  主营业务收入=>金额
 */
@property (nonatomic, copy) NSString *MainBus;
/**
 *  主营业务收入=>单方金额
 */
@property (nonatomic, copy) NSString *MainBusAdverbs;
/**
 *  主营业务收入=>本年度累计
 */
@property (nonatomic, copy) NSString *lastyearMainBus;
/**
 *  原材料成本=>金额
 */
@property (nonatomic, copy) NSString *RawMaterialCost;
/**
 *  原材料成本=>单方金额
 */
@property (nonatomic, copy) NSString *RawMaterialCostAdverbs;
/**
 *  原材料成本=>本年度累计
 */
@property (nonatomic, copy) NSString *lastyearRawMaterialCost;
/**
 *  制造费用=>金额
 */
@property (nonatomic, copy) NSString *ManufacturingCosts;
/**
 *  制造费用=>单方金额
 */
@property (nonatomic, copy) NSString *ManufacturingCostsAdverbs;
/**
 *  制造费用=>本年度累计
 */
@property (nonatomic, copy) NSString *lastyearManufacturingCosts;
/**
 *  物流费用=>金额
 */
@property (nonatomic, copy) NSString *LogisticsCosts;
/**
 *  物流费用=>单方金额
 */
@property (nonatomic, copy) NSString *LogisticsCostsAdverbs;
/**
 *  物流费用=>本年度累计
 */
@property (nonatomic, copy) NSString *lastyearLogisticsCosts;
/**
 *  销售费用=>金额
 */
@property (nonatomic, copy) NSString *SalesCosts;
/**
 *  销售费用=>单方金额
 */
@property (nonatomic, copy) NSString *SalesCostsAdverbs;
/**
 *  销售费用=>本年度累计
 */
@property (nonatomic, copy) NSString *lastyearSalesCosts;
/**
 *  管理费用=>金额
 */
@property (nonatomic, copy) NSString *ManagementCosts;
/**
 *  管理费用=>单方金额
 */
@property (nonatomic, copy) NSString *ManagementCostsAdverbs;
/**
 *  管理费用=>本年度累计
 */
@property (nonatomic, copy) NSString *lastyearManagementCosts;
/**
 *  财务费用=>金额
 */
@property (nonatomic, copy) NSString *FinancialExpenses;
/**
 *  财务费用=>单方金额
 */
@property (nonatomic, copy) NSString *FinancialExpensesAdverbs;
/**
 *  财务费用=>本年度累计
 */
@property (nonatomic, copy) NSString *lastyearFinancialExpenses;
/**
 *  主营成本合计=>金额
 */
@property (nonatomic, copy) NSString *MainCostTotals;
/**
 *  主营成本合计=>单方金额
 */
@property (nonatomic, copy) NSString *MainCostTotalsAdverbs;
/**
 *  主营成本合计=>本年度累计
 */
@property (nonatomic, copy) NSString *lastyearMainCostTotals;
/**
 *  主营利润=>金额
 */
@property (nonatomic, copy) NSString *MainProfit;
/**
 *  主营利润=>单方金额
 */
@property (nonatomic, copy) NSString *MainProfitAdverbs;
/**
 *  主营利润=>本年度累计
 */
@property (nonatomic, copy) NSString *lastyearMainProfit;
/**
 *  主营利润率
 */
@property (nonatomic, copy) NSString *MainProfitMargin;
/**
 *  主营利润率-->本年度累计
 */
@property (nonatomic, copy) NSString *lastyearMainProfitMargin;
/**
 *  投资收益=>金额
 */
@property (nonatomic, copy) NSString *InvestmentCosts;
/**
 *  投资收益=>单方金额
 */
@property (nonatomic, copy) NSString *InvestmentCostsAdverbs;
/**
 *  投资收益=>本年度累计
 */
@property (nonatomic, copy) NSString *lastyearInvestmentCosts;
/**
 *  其他业务利润=>金额
 */
@property (nonatomic, copy) NSString *OtherOperationsCosts;
/**
 *  其他业务利润=>单方金额
 */
@property (nonatomic, copy) NSString *OtherOperationsCostsAdverbs;
/**
 *  其他业务利润=>本年度累计
 */
@property (nonatomic, copy) NSString *lastyearOtherOperationsCosts;
/**
 *  营业外收入=>金额
 */
@property (nonatomic, copy) NSString *NotOperatingCosts;
/**
 *  营业外收入=>单方金额
 */
@property (nonatomic, copy) NSString *NotOperatingCostsAdverbs;
/**
 *  营业外收入=>本年度累计
 */
@property (nonatomic, copy) NSString *lastyearNotOperatingCosts;
/**
 *  营业外支出=>金额
 */
@property (nonatomic, copy) NSString *NotOperatingExpenses;
/**
 *  营业外支出=>单方金额
 */
@property (nonatomic, copy) NSString *NotOperatingExpensesAdverbs;
/**
 *  营业外支出=>本年度累计
 */
@property (nonatomic, copy) NSString *lastyearNotOperatingExpenses;
/**
 *  净利润=>金额
 */
@property (nonatomic, copy) NSString *Profit;
/**
 *  净利润=>单方金额
 */
@property (nonatomic, copy) NSString *ProfitAdverbs;
/**
 *  净利润=>本年度累计
 */
@property (nonatomic, copy) NSString *lastyearProfit;
/**
 *  净利润率
 */
@property (nonatomic, copy) NSString *ProfitRate;
/**
 *  净利润率=>本年度累计
 */
@property (nonatomic, copy) NSString *lastyearProfitRate;
/**
 *  成本率
 */
@property (nonatomic, copy) NSString *CostRate;
/**
 *  成本率=>本年度累计
 */
@property (nonatomic, copy) NSString *lastyearCostRate;
/**
 *  销售费用率
 */
@property (nonatomic, copy) NSString *SalesChargeRate;
/**
 *  销售费用率=>本年度累计
 */
@property (nonatomic, copy) NSString *lastyearSalesChargeRate;
/**
 *  管理费用率
 */
@property (nonatomic, copy) NSString *ManagementExpenseRatio;
/**
 *  管理费用率=>本年度累计
 */
@property (nonatomic, copy) NSString *lastyearManagementExpenseRatio;
/**
 *  财务费用率
 */
@property (nonatomic, copy) NSString *FinanceChargeRate;
/**
 *  财务费用率=>本年度累计
 */
@property (nonatomic, copy) NSString *lastyearFinanceChargeRate;
/**
 *  应收帐款回收额
 */
@property (nonatomic, copy) NSString *RecoveryAccountsReceivable;
/**
 *  应收帐款回收额=>本年度累计
 */
@property (nonatomic, copy) NSString *lastyearRecoveryAccountsReceivable;
/**
 *  现金流回款
 */
@property (nonatomic, copy) NSString *CashFlowCash;
/**
 *  现金流回款=>本年度累计
 */
@property (nonatomic, copy) NSString *lastyearCashFlowCash;
/**
 *  应收余额
 */
@property (nonatomic, copy) NSString *ReceivableBalances;
/**
 *  应收余额=>本年度累计
 */
@property (nonatomic, copy) NSString *lastyearReceivableBalances;
/**
 *  应付余额
 */
@property (nonatomic, copy) NSString *BalanceDue;
/**
 *  应付余额=>本年度累计
 */
@property (nonatomic, copy) NSString *lastyearBalanceDue;
@end
