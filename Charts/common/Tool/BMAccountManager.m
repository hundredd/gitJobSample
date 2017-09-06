//
//  BMAccountManager.m
//  特种车调度
//
//  Created by 陈宇 on 15/9/2.
//
//


#import "BMAccountManager.h"

NSString *const kLocationChangedNotification = @"kLocationChangedNotification";
NSString *const kUpdateUserInfoNotification = @"kUpdateUserInfoNotification";

#define kUserPath   [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"user"]
#define kLoginInfoPath   [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"loginInfo"]
#define kStationPath   [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"stationInfo"]

@interface BMAccountManager ()


@end

@implementation BMAccountManager

kSingletonM

- (instancetype)init
{
    if (self = [super init]) {
        _user = [NSKeyedUnarchiver unarchiveObjectWithFile:kUserPath];
        _loginInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:kLoginInfoPath];
        _stationInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:kStationPath];
       
    }
    return self;
}

- (void)setUser:(User *)user
{
    if (user == nil) {
        return;
    }
    _user = user;
    [NSKeyedArchiver archiveRootObject:_user toFile:kUserPath];
}


- (void)setLoginInfo:(LoginInfo *)loginInfo
{
    if (!loginInfo) {
        return;
    }
    _loginInfo = loginInfo;
    [NSKeyedArchiver archiveRootObject:_loginInfo toFile:kLoginInfoPath];
    
}

- (void)setStationInfo:(StationInfo *)stationInfo
{
    if (!stationInfo) {
        return;
    }
    _stationInfo = stationInfo;
    [NSKeyedArchiver archiveRootObject:_stationInfo toFile:kStationPath];
}

- (BOOL)isLogin
{
    return _user != nil;
}

- (BOOL)isBindStation
{
    return _stationInfo != nil;
}

- (void)logout
{
    BMLog(@"注销极光别名：%lu", (unsigned long)_user.ID);
    _user = nil;
    _loginInfo = nil;
    _stationInfo = nil;
    
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:kUserPath]) {
        [fm removeItemAtPath:kUserPath error:nil];
    }
    
    if ([fm fileExistsAtPath:kLoginInfoPath]) {
        [fm removeItemAtPath:kLoginInfoPath error:nil];
    }
    
    if ([fm fileExistsAtPath:kStationPath]) {
        [fm removeItemAtPath:kStationPath error:nil];
    }
}

- (void)updateInfo
{
    if (!_user) {
        return;
    }
    
    weakSelf(self);
    BMRequest *request = [BMRequest requestWithPath:k_GetOwnerOrDispatcherById contentKey:kRoleType ? @"dispatcher" : @"owner"];
    request.params = @{@"id": [BMAccountManager sharedInstance].user.UserId,
                       @"role": kRole};
    [User postWithRequest:request finish:^(BMResponse *response, NSError *error) {
        if (response.Status == kResultOK) {
            weakSelf.user = response.result;
            weakSelf.loginInfo = [LoginInfo mj_objectWithKeyValues:response.rawResult[@"loginInfo"]];
            weakSelf.stationInfo = [StationInfo mj_objectWithKeyValues:response.rawResult[@"station"]];
            [self performSelectorOnMainThread:@selector(updateUserInfoNotifyAction:) withObject:nil waitUntilDone:YES];
        }
    }];
}


- (void)updateUserInfoNotifyAction:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kUpdateUserInfoNotification object:nil];
}







@end
