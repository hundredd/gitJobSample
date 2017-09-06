//
//  XBResponse.m
//  xbrc
//
//  Created by 陈宇 on 15/7/16.
//  Copyright (c) 2015年 陈宇. All rights reserved.
//

#import "BMResponse.h"

NSString *const kBMErrorDomain = @"com.bm.error";
NSInteger const kResultOK = 1;
NSInteger const kNoMoreMoneyForPay = 8;
NSInteger const kNoBindStation = 9;

@interface BMResponse ()

@end

@implementation BMResponse

+ (NSArray *)ignoredPropertyNames
{
    return @[@"result", @"rawResult"];
}

- (NSString *)msg {
    if ([BMUtils isEmptyString:_Message]) {
        NSInteger errorCode = _error.code;
        NSString *errorMsg = _error.description;
        if ([BMUtils isEmptyString:errorMsg]) {
            return @"未知错误";
        } else {
            switch (errorCode) {
                case 3840:
                    return @"服务器数据格式返回错误";
                default:
                    return @"";
            }
        }
    }
    return _Message;
}


@end
