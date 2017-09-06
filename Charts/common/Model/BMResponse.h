//
//  XBResponse.h
//  xbrc
//
//  Created by 陈宇 on 15/7/16.
//  Copyright (c) 2015年 陈宇. All rights reserved.
//

#import "BMPage.h"

extern NSString *const kBMErrorDomain;
extern NSInteger const kResultOK;
extern NSInteger const kNoMoreMoneyForPay;
extern NSInteger const kNoBindStation;

@interface BMResponse : BMBaseModel

/**
 *  1为成功；其他均为失败
 */
@property (nonatomic, assign) int Status;

/**
 *  提示信息
 */
@property (nonatomic, copy) NSString *Message;

/**
 *  单个实体或实体的集合(可选)
 */
@property (nonatomic, strong) id result;

@property (nonatomic, strong) BMPage *page;
/**
 *  result的原始json类型
 */
@property (nonatomic, strong) id rawResult;

/**
 *  服务器的result是否是个空的.
 */
@property (nonatomic, assign, getter=isEmptyResult) BOOL emptyResult;

/**
 *  数据是否来自缓存
 */
@property (nonatomic, assign) BOOL fromCache;

@property(nonatomic, strong) NSError *error;

@end
