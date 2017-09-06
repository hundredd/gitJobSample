//
//  BMUtils+RYUtilsExtends.h
//  特种车调度
//
//  Created by 韩学鹏 on 16/3/26.
//
//

#import <BM4Group/BM4Group.h>

@interface BMUtils (RYUtilsExtends)


/**
 *  验证码有效性验证
 *
 *  @param code 验证码
 *
 *  @return return value description
 */
+ (BOOL)isValidateCode:(NSString *)code;



/**
 *  验证密码有效性
 *
 *  @param password 密码
 *
 *  @return return value description
 */
+ (BOOL)isValidatePassword:(NSString *)password;


@end
