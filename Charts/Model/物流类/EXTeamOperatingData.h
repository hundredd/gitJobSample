//
//  EXTeamOperatingData.h
//  Charts
//
//  Created by Eleven on 16/9/7.
//  Copyright © 2016年 Eleven. All rights reserved.
//

#import <BM4Group/BM4Group.h>

@interface EXTeamOperatingData : BMBaseModel
/**
 *  月份
 */
@property (nonatomic, copy) NSString *HandleDate;
/**
 *  车号
 */
@property (nonatomic, copy) NSString *VehicleNumber;
/**
 *  车型
 */
@property (nonatomic, copy) NSString *VehicleType;
/**
 *  正常运输量
 */
@property (nonatomic, copy) NSString *NormaltranNumber;
/**
 *  非正常运输量
 */
@property (nonatomic, copy) NSString *NotNormaltranNumber;
/**
 *  外租运输方量
 */
@property (nonatomic, copy) NSString *RenttranNumber;
/**
 *  正常方量小计
 */
@property (nonatomic, copy) NSString *NormalNumberTotal;
/**
 *  补偿方量
 */
@property (nonatomic, copy) NSString *CompensateNumber;
/**
 *  其他补偿方量
 */
@property (nonatomic, copy) NSString *OtherCompensateNumber;
/**
 *  合计方量
 */
@property (nonatomic, copy) NSString *TotalNumber;
/**
 *  方量金额
 */
@property (nonatomic, copy) NSString *NumberAmount;
/**
 *  超时
 */
@property (nonatomic, copy) NSString *TimeOut;
/**
 *  工地接水洗泵
 */
@property (nonatomic, copy) NSString *BuildingDehydration;
/**
 *  余料带回
 */
@property (nonatomic, copy) NSString *LeaveReturn;
/**
 *  拖水
 */
@property (nonatomic, copy) NSString *Dehydration;
/**
 *  外派补油
 */
@property (nonatomic, copy) NSString *Patchoil;
/**
 *  其他补偿金额
 */
@property (nonatomic, copy) NSString *OtherPatch;
/**
 *  补偿费用汇总
 */
@property (nonatomic, copy) NSString *PatchTotal;
/**
 *  外租收入
 */
@property (nonatomic, copy) NSString *RenttranAmount;
/**
 *  总收入汇总
 */
@property (nonatomic, copy) NSString *TotalAmount;
/**
 *  用油量
 */
@property (nonatomic, copy) NSString *UserOil;
/**
 *  单价
 */
@property (nonatomic, copy) NSString *OilPrice;
/**
 *  油费
 */
@property (nonatomic, copy) NSString *OilCost;
/**
 *  轮胎费用
 */
@property (nonatomic, copy) NSString *TyreCost;
/**
 *  车辆保险费
 */
@property (nonatomic, copy) NSString *VehiclePremium;
/**
 *  事故费用
 */
@property (nonatomic, copy) NSString *AccidentCost;
/**
 *  维修费用
 */
@property (nonatomic, copy) NSString *RepairCost;
/**
 *  维修工时费
 */
@property (nonatomic, copy) NSString *RepairHourCost;
/**
 *  交通协调费
 */
@property (nonatomic, copy) NSString *TrafficCost;
/**
 *  折旧费
 */
@property (nonatomic, copy) NSString *DepreciationCost;
/**
 *  管理费用
 */
@property (nonatomic, copy) NSString *ManageCost;
/**
 *  泵管费
 */
@property (nonatomic, copy) NSString *JumpCost;
/**
 *  ETC费用
 */
@property (nonatomic, copy) NSString *SimpleCarProfit;
/**
 *  其他费用
 */
@property (nonatomic, copy) NSString *CarTeamProfit;
/**
 *  底薪
 */
@property (nonatomic, copy) NSString *CarProfit;
/**
 *  福利费用
 */
@property (nonatomic, copy) NSString *SimpleTranCap;
/**
 *  社保/公积金
 */
@property (nonatomic, copy) NSString *TranCapCompele;
/**
 *  总成本
 */
@property (nonatomic, copy) NSString *TotalCost;
/**
 *  单车总利润
 */
@property (nonatomic, copy) NSString *SimpleMoney;
@end
