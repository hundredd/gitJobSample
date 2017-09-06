//
//  XBRequest.m
//  xbrc
//
//  Created by 陈宇 on 15/7/16.
//  Copyright (c) 2015年 陈宇. All rights reserved.
//

#import "BMRequest.h"

@implementation BMRequest

+ (instancetype)requestWithPath:(NSString *)path
{
    NSAssert1(path != nil, @"%@不能为空", @"path");
    
    BMRequest *request = [[BMRequest alloc] init];
    NSString *realPath = path;
    
//    LoginInfo *loginInfo = [BMAccountManager sharedInstance].loginInfo;
//    if (loginInfo.AccessToken) {
//        realPath = [NSString stringWithFormat:@"%@?access_token=%@", path, loginInfo.AccessToken];
//    }
    
    request.path = realPath;
    
    return request;
}

+ (instancetype)requestWithPath:(NSString *)path contentKey:(NSString *)key
{
    NSAssert1(key != nil, @"%@不能为空", @"contentKey");
    BMRequest *request = [self requestWithPath:path];
    [request setValue:key forKeyPath:@"contentKey"];
    return request;
}

@end
