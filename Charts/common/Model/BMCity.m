//
//  BMCity.m
//  ZPM
//
//  Created by 陈宇 on 15/3/25.
//  Copyright (c) 2015年 蓝色互动. All rights reserved.
//

#import "BMCity.h"

@implementation BMCity

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"ID": @"id"};
}

+ (NSDictionary *)objectClassInArray
{
    return @{@"nextArea": [BMCity class]};
}

@end
