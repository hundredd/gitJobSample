//
//  EXEquipmentInfo.h
//  Charts
//
//  Created by Eleven on 16/9/6.
//  Copyright © 2016年 Eleven. All rights reserved.
//

#import <BM4Group/BM4Group.h>

@interface EXEquipmentInfo : BMBaseModel

/**
 *  月份
 */
@property (nonatomic, strong) NSString *HandleDate;
/**
 *  自编号
 */
@property (nonatomic, strong) NSString *AutoNumber;
/**
 *  车牌号
 */
@property (nonatomic, strong) NSString *CfgNo;
/**
 *  车型
 */
@property (nonatomic, strong) NSString *VehicleType;
/**
 *  型号
 */
@property (nonatomic, strong) NSString *ModelNumber;
/**
 *  车辆信息
 */
@property (nonatomic, strong) NSString *VehicleInfo;
/**
 *  购车时间
 */
@property (nonatomic, strong) NSString *BuyVehicleDate;
/**
 *  车架号
 */
@property (nonatomic, strong) NSString *VehicleFrameNumber;
/**
 *  发动机号
 */
@property (nonatomic, strong) NSString *EngineNumber;
/**
 *  原购置价
 */
@property (nonatomic, strong) NSString *SourcePrice;
/**
 *  购置价
 */
@property (nonatomic, strong) NSString *BuyPrice;
/**
 *  累计折旧
 */
@property (nonatomic, strong) NSString *LastedDepreciation;
/**
 *  净值
 */
@property (nonatomic, strong) NSString *NetAsset;
/**
 *  预计使用寿命
 */
@property (nonatomic, strong) NSString *PlanUserAge;
/**
 *  已折旧寿命
 */
@property (nonatomic, strong) NSString *DepreciationAge;
/**
 *  本期应提折旧额
 */
@property (nonatomic, strong) NSString *CurrentDepreciationMonry;
/**
 *  评估价格
 */
@property (nonatomic, strong) NSString *AssessMoney;
/**
 *  通行证状态
 */
@property (nonatomic, strong) NSString *PassportStatus;
/**
 *  年审日期
 */
@property (nonatomic, strong) NSString *YearCheckDate;
/**
 *  购买登记日期
 */
@property (nonatomic, strong) NSString *BuyDate;
/**
 *  交强险到期日
 */
@property (nonatomic, strong) NSString *StrongDate;
/**
 *  商业险到期日
 */
@property (nonatomic, strong) NSString *BusinessDate;
/**
 *  交强险金额
 */
@property (nonatomic, strong) NSString *StrongMoney;
/**
 *  商业险金额
 */
@property (nonatomic, strong) NSString *BusinessMoney;
@end
