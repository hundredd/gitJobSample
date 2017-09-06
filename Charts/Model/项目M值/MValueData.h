//
//  MValueData.h
//  Charts
//
//  Created by Eleven on 16/9/7.
//  Copyright © 2016年 Eleven. All rights reserved.
//

#import <BM4Group/BM4Group.h>

@interface MValueData : BMBaseModel
/**
 *  发生月份
 */
@property (nonatomic, strong) NSString *HandleDate;
/**
 *  项目编码
 */
@property (nonatomic, strong) NSString *SubjectNumber;
/**
 *  项目名称
 */
@property (nonatomic, strong) NSString *SubjectName;
/**
 *  付款单位
 */
@property (nonatomic, strong) NSString *PayUnit;
/**
 *  负责人
 */
@property (nonatomic, strong) NSString *DutyMan;
/**
 *  产量
 */
@property (nonatomic, strong) NSString *ProductNumber;
/**
 *  产值
 */
@property (nonatomic, strong) NSString *ProductValue;
/**
 *  材料成本
 */
@property (nonatomic, strong) NSString *MaterialCost;
/**
 *  业务提成
 */
@property (nonatomic, strong) NSString *BusinessPushMoney;
/**
 *  客服费用
 */
@property (nonatomic, strong) NSString *CustomerServiceCost;
/**
 *  居间费用
 */
@property (nonatomic, strong) NSString *BetweenCost;
/**
 *  税金
 */
@property (nonatomic, strong) NSString *TaxMoney;
/**
 *  运输费用
 */
@property (nonatomic, strong) NSString *Transportcost;
/**
 *  泵送费用
 */
@property (nonatomic, strong) NSString *JumpCost;
/**
 *  财务费用
 */
@property (nonatomic, strong) NSString *FinanceCost;
/**
 *  站点分摊
 */
@property (nonatomic, strong) NSString *StationShare;
/**
 *  总部分摊
 */
@property (nonatomic, strong) NSString *GroupShare;
/**
 *  基本H值
 */
@property (nonatomic, strong) NSString *BaseHvalue;
/**
 *  本期M值
 */
@property (nonatomic, strong) NSString *CurrentMvalue;
/**
 *  累计M值
 */
@property (nonatomic, strong) NSString *LastedMvalue;
@end
