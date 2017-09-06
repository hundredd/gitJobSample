//
//  AppDelegate.m
//  showPush
//
//  Created by hun on 2017/9/6.
//  Copyright © 2017年 hun. All rights reserved.
//

#import "AppDelegate.h"
#import "UMessage.h"
@interface AppDelegate ()<UNUserNotificationCenterDelegate>
@property(nonatomic,strong)NSDictionary *dic ;//
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //设置 AppKey 及 LaunchOptions
    [UMessage startWithAppkey:@"59af501daed1791eb500118f" launchOptions:launchOptions httpsEnable:YES ];
    [UMessage openDebugMode:YES];
    [UMessage setLogEnabled:YES];
    UIStoryboard *board=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    [UMessage addLaunchMessageWithWindow:self.window finishViewController:[board instantiateInitialViewController]];
    //注册通知
    [UMessage registerForRemoteNotifications];
    //iOS10必须加下面这段代码。
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate=self;
    UNAuthorizationOptions types10=UNAuthorizationOptionBadge|UNAuthorizationOptionAlert|UNAuthorizationOptionSound;
    [center requestAuthorizationWithOptions:types10 completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            //点击允许
            
        } else {
            //点击不允许
            
        }
    }];
    [UMessage setAlias:@"alias1310" type:@"alias" response:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
        
        NSLog([NSString stringWithFormat:@"成功返回数据--%@",responseObject]);
        
    }];
    return YES;
}

#pragma mark - mark
-(NSDictionary *)dic
{
    return @{@"aps":@{
                     @"alert":@{
                             @"body":@"临时修改",
                             @"subtitle":@"副标题",
                             @"title":@"标题",
                             },
                     @"sound": @"default"
                     },
             @"d":@"us01304150466618642111",
             @"p":@"0",
             };
}
#pragma mark - delegate
//iOS10以下使用这个方法接收通知
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [UMessage didReceiveRemoteNotification:self.dic];
    NSLog(@"获取的数据%@",userInfo);
    //    self.userInfo = userInfo;
    //    //定制自定的的弹出框
    //    if([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
    //    {
    //        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"标题"
    //                                                            message:@"Test On ApplicationStateActive"
    //                                                           delegate:self
    //                                                  cancelButtonTitle:@"确定"
    //                                                  otherButtonTitles:nil];
    //
    //        [alertView show];
    //
    //    }
}

//iOS10新增：处理前台收到通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    NSDictionary * userInfo = notification.request.content.userInfo;
    NSLog(@"IOS10,获取的数据%@",userInfo);
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于前台时的远程推送接受
        //关闭U-Push自带的弹出框
        [UMessage setAutoAlert:NO];
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:self.dic];
        
    }else{
        //应用处于前台时的本地推送接受
    }
    //当应用处于前台时提示设置，需要哪个可以设置哪一个
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
}

//iOS10新增：处理后台点击通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于后台时的远程推送接受
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:self.dic];
        
    }else{
        //应用处于后台时的本地推送接受
    }
}



@end
