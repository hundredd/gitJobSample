//
//  BMHttpTool.m
//  xbrc
//
//  Created by 陈宇 on 15/7/16.
//  Copyright (c) 2015年 陈宇. All rights reserved.
//

NSString *const kDefaultMessage = @"数据加载中...";
NSString *const kBMNetworkRequestDomain = @"com.BlueMobi.chrain";
NSString *const kBMNetworkRequestErrorKey = @"kBMNetworkRequestErrorKey";

const NSUInteger count = 1024 * 1024;

@interface BMHttpTool ()

@end

@implementation BMHttpTool

kSingletonM

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kServerPath]];
        NSMutableSet *contentTypes= [NSMutableSet setWithSet:_manager.responseSerializer.acceptableContentTypes];
        [contentTypes addObject:@"text/html"];
        [contentTypes addObject:@"html/text"];
        [contentTypes addObject:@"text/plain"];
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//        _manager.requestSerializer = [AFJSONRequestSerializer serializer];
//        [_manager.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        _manager.responseSerializer.acceptableContentTypes = contentTypes;
        _manager.requestSerializer.timeoutInterval = k_HttpTimeout;
    }
    return _manager;
}

- (void)getWith:(BMRequest *)request finish:(finishBlock)finish
{
    BMLog(@"================  请求数据 begin  =======================");
    BMLog(@"%@", request.mj_JSONObject);
    BMLog(@"================  请求数据 end  =======================");
    [[BMHttpTool sharedInstance].manager GET:[kInterfacePath stringByAppendingPathComponent:request.path] parameters:request.params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        BMResponse *response = [self responseWithJson:responseObject];
        if (finish) {
            finish(response, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (finish) {
            BMResponse *response = [BMResponse new];
            response.error = error;
            finish(response, error);
            BMLog(@"================  错误信息 begin  =======================");
            BMLog(@"错误描述：%@", error.localizedDescription);
            BMLog(@"错误原因：%@", error.localizedFailureReason);
            BMLog(@"错误建议：%@", error.localizedRecoverySuggestion);
            BMLog(@"================  错误信息 end  =======================");

        }
    }];
}

- (void)postWith:(BMRequest *)request finish:(finishBlock)finish
{
    BMLog(@"================  请求数据 begin  =======================");
    BMLog(@"%@", request.mj_JSONObject);
    BMLog(@"================  请求数据 end  =======================");
    NSString *url = [kInterfacePath stringByAppendingString:request.path];
    [[BMHttpTool sharedInstance].manager POST:url parameters:request.params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        BMResponse *response = [self responseWithJson:responseObject];
        if (finish) {
            finish(response, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (finish) {
            BMResponse *response = [BMResponse new];
            response.error = error;
            finish(response, error);
            BMLog(@"================  错误信息 begin  =======================");
            BMLog(@"错误描述：%@", error.localizedDescription);
            BMLog(@"错误原因：%@", error.localizedFailureReason);
            BMLog(@"错误建议：%@", error.localizedRecoverySuggestion);
            BMLog(@"================  错误信息 end  =======================");
        }
    }];
    
}

- (void)uploadWith:(BMRequest *)request finish:(finishBlock)finish
{
    NSString *url =  [kInterfacePath stringByAppendingPathComponent:request.path];
    [[BMHttpTool sharedInstance].manager POST:url parameters:request.params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [request.uploadData enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSData *obj, BOOL *stop) {
            [formData appendPartWithFileData:obj name:key fileName:@"a.jpg" mimeType:@"image/jpeg"];
        }];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        BMLog(@"*******响应开始*********");
        BMResponse *response = [self responseWithJson:responseObject];
        if (finish) {
            finish(response, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        BMResponse *response = [BMResponse new];
        response.error = error;
        finish(response, error);
    }];
}

- (BMResponse *)responseWithJson:(id)responseObj
{
    NSDictionary *dictResponseObj = [responseObj mj_JSONObject];
    BMLog(@"================  响应数据 begin  =======================");
    BMLog(@"%@", dictResponseObj);
    BMLog(@"================  响应数据 end  =======================");
    BMResponse *response = [BMResponse mj_objectWithKeyValues:dictResponseObj];
    
    id result = dictResponseObj[@"data"];
    
    if (result && ![result isKindOfClass:[NSNull class]] && [result isKindOfClass:[NSDictionary class]]) {
        NSDictionary *pageDict = result[@"page"];
        if (pageDict) {
            response.page = [BMPage mj_objectWithKeyValues:pageDict];
        }
        response.rawResult = result;
        response.emptyResult = NO;
    } else {
        response.emptyResult = YES;
    }
    
    if (response.Status == kAccessTokenTimeoutStatus) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kAccessTokenTimeoutNotificationName object:nil];
    }
    
    return response;
}

@end
