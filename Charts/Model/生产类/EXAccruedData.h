//
//  EXAccruedData.h
//  Charts
//
//  Created by Eleven on 16/9/6.
//  Copyright © 2016年 Eleven. All rights reserved.
//

#import <BM4Group/BM4Group.h>

@interface EXAccruedData : BMBaseModel

/**
 *  期初应收（万元）
 */
@property (nonatomic, copy) NSString *BeginRecivableBalanceMoney;
/**
 *  期初应付（万元）
 */
@property (nonatomic, copy) NSString *BeginPayableBalanceMoney;
/**
 *  本期应收（万元）
 */
@property (nonatomic, copy) NSString *CurrentRecivbleMoney;
/**
 *  本期应付（万元）
 */
@property (nonatomic, copy) NSString *CurrentPayableMoney;
/**
 *  年回款目标（万元）
 */
@property (nonatomic, copy) NSString *yeartargetMoney;
/**
 *  年累计回款（万元）
 */
@property (nonatomic, copy) NSString *yearHandleRemainMoney;
/**
 *  年回款率
 */
@property (nonatomic, copy) NSString *yearReturnedpre;
/**
 *  月回款计划
 */
@property (nonatomic, copy) NSString *CurrentReturnPlanMoney;
/**
 *  月回款额（万元）
 */
@property (nonatomic, copy) NSString *monthReturnMoney;
/**
 *  月付款计划
 */
@property (nonatomic, copy) NSString *CurrentPayablePlanMoney;
/**
 *  月付款额（万元）
 */
@property (nonatomic, copy) NSString *monthpayMoney;
/**
 *  其他付款（万元）
 */
@property (nonatomic, copy) NSString *monthohterpayMoney;
/**
 *  年累计付款（万元）
 */
@property (nonatomic, copy) NSString *yearReturnedMoney;
/**
 *  众筹资金（万元）
 */
@property (nonatomic, copy) NSString *CrowdMoney;
/**
 *  银行贷款（万元）
 */
@property (nonatomic, copy) NSString *BrankLoanMoney;
/**
 *  集团借贷（万元）
 */
@property (nonatomic, copy) NSString *GroupBorrowMoney;
/**
 *  其他借贷（万元）
 */
@property (nonatomic, copy) NSString *OtherBorrowMoney;
/**
 *  当期资金（万元）
 */
@property (nonatomic, copy) NSString *CurrentMoney;
@end
