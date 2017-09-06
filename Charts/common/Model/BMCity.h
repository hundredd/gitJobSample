//
//  BMCity.h
//  ZPM
//
//  Created by 陈宇 on 15/3/25.
//  Copyright (c) 2015年 蓝色互动. All rights reserved.
//  代表城市

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface BMCity : BMBaseModel

@property (nonatomic, copy  ) NSString *first;//拼音
@property (nonatomic, copy  ) NSString *full;//全拼
@property (nonatomic, copy  ) NSString *fullName;//省市名

@property (nonatomic, strong) NSArray  *nextArea;

@property (nonatomic, assign, readonly, getter = isHot) BOOL hot;

@property (nonatomic, assign) CLLocationCoordinate2D position;

@end
