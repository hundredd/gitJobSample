//
//  BMMainTool.m
//  ZPM
//
//  Created by 陈宇 on 15/3/20.
//  Copyright (c) 2015年 陈宇. All rights reserved.
//

#import "BMMainTool.h"
#import "BMNewFeatureController.h"
#import "ConstVarHeader.h"

@implementation BMMainTool
//
//+ (UIViewController *)chooseRootViewController
//{
//    if ([BMUtils showNewFeature]) {
//        return [[BMNewFeatureController alloc] init];
//    }
////    return [[ZDPageViewController alloc]init];
//}


+ (UIViewController *)chooseRootViewController
{
    
//    if ([BMUtils showNewFeature]) {
//        return [[BMNewFeatureController alloc] init];
//    }
    //判断是否登录
    if ([BMAccountManager sharedInstance].user.isLog) {
        NSURL *url = [NSURL URLWithString:@"http://113.57.155.226:9631/api/Login/LoginData"];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        [request setHTTPMethod:@"POST"];
        NSString *username = [BMAccountManager sharedInstance].user.userName;
        NSString *password = [BMAccountManager sharedInstance].user.password;
        NSString *postString = [NSString stringWithFormat:@"LoginName=%@&Password=%@&Imei=%@",username, password, @"44444444444777777"];
        NSData *postParameterData = [postString dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:postParameterData];
        NSData *receiveData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSError *error;
        if (receiveData) {
            NSMutableDictionary *getJsonData = [NSJSONSerialization
                                                JSONObjectWithData:receiveData
                                                options:NSJSONReadingMutableContainers
                                                error:&error];
            NSDictionary *dic = getJsonData;
            if ([dic[@"Status"]  isEqual: @1]) {
                return [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"TabVC"];
            }else{
                return [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateInitialViewController];
            }

        }else{
           return [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateInitialViewController];
        }
    }else{
       return [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateInitialViewController];
    }
}
+ (NSDate *)convertWithString:(NSString *)dateString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return [formatter dateFromString:dateString];
}


+ (void)checkAppVersionUpdate:(void (^)(BMUpateModel *))complete
{
    //获取当前版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[(__bridge NSString *)kCFBundleVersionKey];
    //请求服务器数据
    BMRequest *request = [BMRequest requestWithPath:App_CheckVersion contentKey:@"version"];
    request.params = @{ @"role" : kRole, @"plat" : @"iOS", @"versionCode" : [NSNumber numberWithInteger:currentVersion.integerValue]};
    
    [BMUpateModel postWithRequest:request finish:^(BMResponse *response, NSError *error) {

        if (response.Status == kResultOK) {
            complete(response.result);
        }
    }];
}



@end
