//
//  EXVehicleTransport.h
//  Charts
//
//  Created by Eleven on 16/9/3.
//  Copyright © 2016年 Eleven. All rights reserved.
//

#import <BM4Group/BM4Group.h>

@interface EXVehicleTransportData : BMBaseModel
/**
 *  发货单号
 */
@property (nonatomic, copy) NSString *TranListID;
/**
 *  工程名称
 */
@property (nonatomic, copy) NSString *ProjectName;
/**
 *  使用单位
 */
@property (nonatomic, copy) NSString *UnitName;
/**
 *  施工部位
 */
@property (nonatomic, copy) NSString *ParticularPart;
/**
 *  浇筑方式
 */
@property (nonatomic, copy) NSString *PlyPlan;
/**
 *  强度等级
 */
@property (nonatomic, copy) NSString *ProductGrade;
/**
 *  运输方量
 */
@property (nonatomic, copy) NSString *Number;
/**
 *  自编车号
 */
@property (nonatomic, copy) NSString *InsideVehicleNo;
/**
 *  司机姓名
 */
@property (nonatomic, copy) NSString *Motorman;
/**
 *  打料时间
 */
@property (nonatomic, copy) NSString *SendDate;
/**
 *  出厂时间
 */
@property (nonatomic, copy) NSString *LeaveFacTime;
/**
 *  到达工地时间
 */
@property (nonatomic, copy) NSString *ArriveBSTime;
/**
 *  初次卸料时间
 */
@property (nonatomic, copy) NSString *FirstXLTime;
/**
 *  末次卸料时间
 */
@property (nonatomic, copy) NSString *LastXLTime;
/**
 *  离开工地时间
 */
@property (nonatomic, copy) NSString *leaveBSTime;
/**
 *  回厂时间
 */
@property (nonatomic, copy) NSString *ReturnFacTime;
@end
