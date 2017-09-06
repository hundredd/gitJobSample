//
//  BMBaseModel+XBExtensions.m
//  xbrc
//
//  Created by 陈宇 on 15/7/16.
//  Copyright (c) 2015年 陈宇. All rights reserved.
//

#import "BMBaseModel+BMExtensions.h"
#import "BMHttpTool.h"

@implementation BMBaseModel (BMExtensions)

+ (BMResponse *)responseWith:(id)responseObj contentKey:(NSString *)contentKey
{
    NSDictionary *dictResponseObj = [responseObj mj_JSONObject];
    BMResponse *response = [BMResponse mj_objectWithKeyValues:dictResponseObj];
    
    BMLog(@"================  响应数据 begin  =======================");
    BMLog(@"%@", dictResponseObj);
    BMLog(@"================  响应数据 end  =======================");
    
//    id result = dictResponseObj[@"data"];
    id result = dictResponseObj;
    response.rawResult = result;
    
    if (result && ![result isKindOfClass:[NSNull class]] && contentKey && [result isKindOfClass:[NSDictionary class]]) {
        NSDictionary *pageDict = result[@"page"];
        if (pageDict) {
            response.page = [BMPage mj_objectWithKeyValues:pageDict];
        }
        result = result[contentKey];
    }
    
    if (result && ![result isKindOfClass:[NSNull class]]) { //判断服务器返回的主数据是否为空
        response.emptyResult = NO;
        if ([result isKindOfClass:[NSArray class]]) {    //需要的是数组，并且result确实为数组
            response.result = [self mj_objectArrayWithKeyValuesArray:result];
        } else if ([result isKindOfClass:[NSDictionary class]]) {   //需要的是字典，并且result确实为字典
            response.result = [self mj_objectWithKeyValues:result];
        }
    } else {
        response.emptyResult = YES;
    }
    
    if (response.Status == kAccessTokenTimeoutStatus) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kAccessTokenTimeoutNotificationName object:nil];
    }
    
    return response;
}

+ (void)getWithRequest:(BMRequest *)request finish:(finishBlock)finish
{
    [[BMHttpTool sharedInstance].manager GET:[kInterfacePath stringByAppendingPathComponent:request.path] parameters:request.params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        BMResponse *response = [self responseWith:responseObject contentKey:request.contentKey];
        finish(response, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        finish(nil, error);
    }];
}

+ (void)postWithRequest:(BMRequest *)request finish:(finishBlock)finish
{
    BMLog(@"================  请求数据 begin  =======================");
    BMLog(@"%@", request.mj_JSONObject);
    BMLog(@"================  请求数据 end  =======================");
    NSString *url = [kInterfacePath stringByAppendingString:request.path];
    [[BMHttpTool sharedInstance].manager POST:url parameters:request.params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finish([self responseWith:responseObject contentKey:request.contentKey], nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        BMLog(@"================  错误信息 begin  =======================");
        BMLog(@"错误描述：%@", error.localizedDescription);
        BMLog(@"错误原因：%@", error.localizedFailureReason);
        BMLog(@"错误建议：%@", error.localizedRecoverySuggestion);
        BMLog(@"================  错误信息 end  =======================");
        finish(nil, error);
    }];
    
}

/**
 *  通过Request从缓存取数据
 *
 *  @param request 取数据的request对象
 *
 *  @return 如果有缓存数据，返回XBResponse，且fromCache为yes。没有则为nil；
 */
+ (BMResponse *)getCacheWith:(BMRequest *)request
{
    NSString *cachePath = [self encodePath:request.path];
    BOOL exists = [[NSFileManager defaultManager] fileExistsAtPath:cachePath];
    if (!exists) return nil;
    
    id cacheFile = [NSKeyedUnarchiver unarchiveObjectWithFile:cachePath];
    
    if (!cacheFile) return nil;
    
    BMResponse *response;
    
    response = [[BMResponse alloc] init];
    response.Status = 1;
    response.emptyResult = NO;
    response.fromCache = YES;
    
    if ([cacheFile isKindOfClass:[NSArray class]]) {
        response.rawResult = cacheFile;
        response.result = [self mj_objectArrayWithKeyValuesArray:cacheFile];
        return response;
    } else if ([cacheFile isKindOfClass:[NSDictionary class]]) {
        response.rawResult = cacheFile;
        response.result = [self mj_objectWithKeyValues:cacheFile];
        return response;
    }
    
    return nil;
}

/**
 *  通过Request缓存服务器返回的数据
 *
 *  @param response 需要缓存的response对象
 *  @param request  缓存的request
 */
+ (void)cacheResponse:(BMResponse *)response withRequest:(BMRequest *)request
{
    //response为空、服务器返回失败、服务器返回空数据(状态)、当前数据来自缓存...pass
    if (!response || response.Status != 1 || response.isEmptyResult || response.fromCache) {
        return;
    }
    
    // MARK 写文件耗费系统资源，可改为子线程操作
    NSString *cachePath = [self encodePath:request.path];
    if (cachePath) {
        [self checkDirectory];
        [NSKeyedArchiver archiveRootObject:response.rawResult toFile:cachePath];
    }
}

/**
 *  通过接口路径返回缓存存储的路径
 *
 *  @param path 接口路径
 *
 *  @return 缓存存储位置
 */
+ (NSString *)encodePath:(NSString *)path
{
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    cachePath = [cachePath stringByAppendingPathComponent:@"xbrcCache"];
    return [cachePath stringByAppendingPathComponent:[path stringByReplacingOccurrencesOfString:@"/" withString:@"."]];
}

+ (void)checkDirectory {
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    path = [path stringByAppendingPathComponent:@"xbrcCache"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    if (![fileManager fileExistsAtPath:path isDirectory:&isDir]) {
        [self createBaseDirectoryAtPath:path];
    } else {
        if (!isDir) {
            NSError *error = nil;
            [fileManager removeItemAtPath:path error:&error];
            [self createBaseDirectoryAtPath:path];
        }
    }
}

+ (void)createBaseDirectoryAtPath:(NSString *)path {
    __autoreleasing NSError *error = nil;
    [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES
                                               attributes:nil error:&error];
    if (error) {
        BMLog(@"create cache directory failed, error = %@", error);
    }
}

@end
