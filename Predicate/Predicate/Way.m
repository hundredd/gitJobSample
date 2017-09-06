//
//  Way.m
//  Predicate
//
//  Created by hun on 2017/8/31.
//  Copyright © 2017年 hun. All rights reserved.
//

#import "Way.h"

@implementation Way

//港澳居民的证件验证验证
+ (BOOL) validateGangPassbook:(NSString *)passNo
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^(H|M)\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:passNo];
}

@end
