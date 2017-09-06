//
//  BMAccountManager.h
//  特种车调度
//
//  Created by 陈宇 on 15/9/2.
//
//

#import <Foundation/Foundation.h>
#import "User.h"

extern NSString *const kLocationChangedNotification;
extern NSString *const kUpdateUserInfoNotification;

@interface BMAccountManager : NSObject

kSingletonH

/**
 *  是否登录
 */
@property (nonatomic, assign, readonly, getter=isLogin) BOOL login;

/**
 *  是否绑定站点
 */
@property (nonatomic, assign, readonly, getter=isBindStation) BOOL bindStation;


/**
 *  用户信息
 */
@property (nonatomic, strong) User *user;


/**
 *  登录信息
 */
@property (nonatomic, strong) LoginInfo *loginInfo;

/**
 *  站点信息
 */
@property (nonatomic, strong) StationInfo *stationInfo;

/**
 *  退出登录
 */
- (void)logout;






@end
