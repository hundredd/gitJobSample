//
//  User.h
//  特种车调度
//
//  Created by 陈宇 on 15/9/2.
//
//

#import "BMBaseModel.h"

typedef enum : NSUInteger {
    WithdrawalsType_Personal = 0,  //个人
    WithdrawalsType_Enterprise   //企业
} WithdrawalsType;

/**
 *  登录信息
 */
@interface LoginInfo : NSObject <NSCoding>

@property (nonatomic, copy) NSString *AccessToken;

@property (nonatomic, copy) NSString *userCname;

@property (nonatomic, copy) NSString *userType;

@end

/**
 *  绑定的站点信息
 */
@interface StationInfo : NSObject<NSCoding>




@end

/**
 *  用户信息
 */
@interface User : BMBaseModel <NSCoding>

/**
 *  主键
 */
@property (nonatomic, copy) NSString *UserId;

/**
 *  菜单ID
 */

@property (nonatomic, copy) NSString *MenuId;

/**
 *  菜单名称
 */
@property (nonatomic, copy) NSString *MenuName;

/**
 *  菜单代码，用于获取站点的权限使用
 */
@property (nonatomic, copy) NSString *MenuCode;

/**
 *  登陆状态
 */
@property (nonatomic, assign) BOOL isLog;

/**
 *  用户名
 */
@property (nonatomic, copy) NSString *userName;

/**
 *  密码
 */
@property (nonatomic, copy) NSString *password;

@end


