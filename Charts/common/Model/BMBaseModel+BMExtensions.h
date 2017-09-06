//
//  BMBaseModel+XBExtensions.h
//  xbrc
//
//  Created by 陈宇 on 15/7/16.
//  Copyright (c) 2015年 陈宇. All rights reserved.
//

#import <BM4Group/BM4Group.h>

@interface BMBaseModel (BMExtensions)

+ (void)getWithRequest:(BMRequest *)request finish:(finishBlock)finish;

+ (void)postWithRequest:(BMRequest *)request finish:(finishBlock)finish;


@end
