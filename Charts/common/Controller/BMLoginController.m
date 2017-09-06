//
//  BMLoginController.m
//  特种车调度
//
//  Created by 陈宇 on 15/8/19.
//
//

#import "BMLoginController.h"
#import "User.h"
#import "BMAccountManager.h"
#import "EXUUID.h"

@interface BMLoginController ()
@property (weak, nonatomic) IBOutlet UITextField *uidTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
- (IBAction)loginAction:(UIButton *)sender;
@property (nonatomic, copy) NSString *uuid;
@end

@implementation BMLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    [UIImage resizedImage:@"register_line"];
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    // white.png图片自己下载个纯白色的色块，或者自己ps做一个
    [navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_bar"]
                       forBarPosition:UIBarPositionAny
                           barMetrics:UIBarMetricsDefault];
    [navigationBar setShadowImage:[UIImage new]];
    //获取UUID
    self.uuid = [EXUUID getUUID];
    NSLog(@"uuid=%@",self.uuid);
}

- (IBAction)loginAction:(UIButton *)sender {
    NSString *username = _uidTextField.text;
    if ([BMUtils isEmptyString:username]) {
        [self showHint:@"用户名不能为空!"];
        return;
    }
    NSString *password = _passwordTextField.text;
    if ([BMUtils isEmptyString:password]) {
        [self showHint:@"请输入密码!"];
        return;
    }
//    if (password.length > 0 && password.length < 6) {
//        [self showHint:@"密码长度不能小于6位!"];
//        return;
//    }
//
    weakSelf(self);
    BMRequest *request = [BMRequest requestWithPath:@"Login/LoginData" contentKey:@"AppendData"];
    request.params = @{@"LoginName": username, @"Password": password, @"Imei": @"44444444444777777"};
    [self showHudWithhint:kDefaultMessage];
    [User postWithRequest:request finish:^(BMResponse *response, NSError *error) {
        [weakSelf hideHud];
        if (response.Status == kResultOK) {
            [BMAccountManager sharedInstance].user = response.result[0];
            LoginInfo *loginInfo = [LoginInfo new];
            loginInfo.AccessToken = response.rawResult[@"AccessToken"];
            [BMAccountManager sharedInstance].loginInfo = loginInfo;
            User *user = [BMAccountManager sharedInstance].user;
            user.isLog = YES;
            user.userName = username;
            user.password = password;
            [BMAccountManager sharedInstance].user = user;
            //跳转主页
            UITabBarController *tabVC = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"TabVC"];
            [self presentViewController:tabVC animated:YES completion:nil];
        } else {
            if (response.Status == 2) {
                [weakSelf showHint:response.Message];
            }else{
                [self showHint:@"网络故障，暂时无法连接服务器"];
            }
        }
    }];
    //跳转主页
//    UITabBarController *tabVC = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"TabVC"];
//    [self presentViewController:tabVC animated:YES completion:nil];
}

@end
