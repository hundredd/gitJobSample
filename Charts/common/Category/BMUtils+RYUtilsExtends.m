//
//  BMUtils+RYUtilsExtends.m
//  特种车调度
//
//  Created by 韩学鹏 on 16/3/26.
//
//

#import "BMUtils+RYUtilsExtends.h"

@implementation BMUtils (RYUtilsExtends)

+ (BOOL)isValidateCode:(NSString *)code
{
    NSString *codeRegex = @"^\\d{6}$";
    NSPredicate *codeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", codeRegex];
    return [codeTest evaluateWithObject:code];
}

+ (BOOL)isValidatePassword:(NSString *)password
{
    NSString *pwdRegex = @"^\\w{6,}$";
    NSPredicate *pwdTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pwdRegex];
    
    return [pwdTest evaluateWithObject:password];
}

@end
