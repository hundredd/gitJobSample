//
//  BMUtils.m
//  BM4Group
//
//  Created by Chrain on 15/5/25.
//  Copyright (c) 2015年 蓝色互动. All rights reserved.
//

#import "BMUtils.h"
#import "NSString+BM.h"
#import "BMGlobalMacro.h"
#import "MBProgressHUD.h"

@implementation BMUtils

+ (BOOL)showNewFeature
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *previewFeatureVersion = [userDefaults stringForKey:@"previewFeatureVersion"];
    
    if ([BMUtils isEmptyString:previewFeatureVersion]) return YES;
    
    NSString *version = [NSBundle mainBundle].infoDictionary[(__bridge NSString *)kCFBundleVersionKey];
    if ([previewFeatureVersion isEqualToString:version]) {
        return NO;
    }
    return YES;
}

+ (void)updateFeatureVersion
{
    NSString *version = [NSBundle mainBundle].infoDictionary[(__bridge NSString *)kCFBundleVersionKey];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:version forKey:@"previewFeatureVersion"];
    [userDefaults synchronize];
}

+ (void)callWithPhoneNumber:(NSString *)phone
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", phone]];
    [[UIApplication sharedApplication] openURL:url];
}

+ (void)showMessage:(NSString *)msg
{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kWindow animated:YES];
        hud.labelText = [NSString stringWithFormat:@"\r\n%@", msg];
        BMLog(@"%@", hud.labelText);
    });
}

+ (void)hideMessage
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:kWindow animated:NO];
    });
}

+ (void)showToast:(NSString *)msg delay:(NSUInteger)delay
{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kWindow animated:YES];
        hud.labelText = msg;
        hud.mode = MBProgressHUDModeText;
        [hud hide:YES afterDelay:delay];
    });
}

+ (BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+ (BOOL)isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9])|(17[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

+ (BOOL)isValidateIDCard:(NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

+ (BOOL)isValidateCarNo:(NSString *)carNo
{
    NSString *carRegex = @"^[A-Za-z]{1}[A-Za-z_0-9]{5}$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    return [carTest evaluateWithObject:carNo];
}

+ (BOOL)isValidateChejiaNo:(NSString *)chejiaNo
{
    NSString *carRegex = @"^([0-9A-Z]){17}$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    return [carTest evaluateWithObject:chejiaNo];
}

+ (NSDate *)convertWithString:(NSString *)dateString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [NSLocale currentLocale];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return [formatter dateFromString:dateString];
}

+ (BOOL)isEmptyString:(NSString *)str
{
    if (str == nil || str == NULL) {
        return YES;
    }
    if ([str isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    return NO;
}

@end
