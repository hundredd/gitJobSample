//
//  BMHttpTool.h
//  xbrc
//
//  Created by 陈宇 on 15/7/16.
//  Copyright (c) 2015年 陈宇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "BMRequest.h"
#import "BMResponse.h"

typedef void(^finishBlock)(BMResponse *response, NSError *error);

FOUNDATION_EXTERN NSString *const kDefaultMessage;
FOUNDATION_EXTERN NSString *const kBMNetworkRequestDomain;
FOUNDATION_EXTERN NSString *const kBMNetworkRequestErrorKey;

@interface BMHttpTool : NSObject

kSingletonH

@property (nonatomic, strong) AFHTTPSessionManager *manager;

- (void)postWith:(BMRequest *)request finish:(finishBlock)finish;

- (void)getWith:(BMRequest *)request finish:(finishBlock)finish;

- (void)uploadWith:(BMRequest *)request finish:(finishBlock)finish;

@end
