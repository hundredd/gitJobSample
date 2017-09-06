//
//  BMRegisterController.m
//  特种车调度
//
//  Created by 陈宇 on 15/8/19.
//
//

#import <Foundation/Foundation.h>
#import "BMRegisterController.h"
#import "BMProtocolViewController.h"
#import "BMAccountManager.h"

@interface BMRegisterController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *agreeButton;

@property (weak, nonatomic) IBOutlet UIButton *obtainVCodeButton;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@property (nonatomic, copy) NSString *mobile;

- (IBAction)argeeAction:(UIButton *)sender;
- (IBAction)codeAction:(UIButton *)sender;
- (IBAction)protocolAction:(UIButton *)sender;
- (IBAction)nextAction:(id)sender;
- (IBAction)directLoginAction:(id)sender;

@end

@implementation BMRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kGlobalColor;
    [self.registerButton setEnabled:NO];
    [self.phoneTextField addTarget:self action:@selector(canClick) forControlEvents:UIControlEventEditingDidEnd];
    [self.passwordTextField addTarget:self action:@selector(canClick) forControlEvents:UIControlEventEditingDidEnd];
    [self.codeTextField addTarget:self action:@selector(canClick) forControlEvents:UIControlEventEditingDidEnd];
}


- (IBAction)argeeAction:(UIButton *)sender {
    
    
    sender.selected = !sender.selected;
    [self canClick];
}


- (void)canClick{
    
    NSString *phone = _phoneTextField.text;
    NSString *password = _passwordTextField.text;
    NSString *code = _codeTextField.text;
    if ([BMUtils isEmptyString:phone] || [BMUtils isEmptyString:code] || !_agreeButton.isSelected || [BMUtils isEmptyString:password]) {
        [self.registerButton setEnabled:NO];
    }
    
    if (![BMUtils isEmptyString:phone] && ![BMUtils isEmptyString:code] && _agreeButton.isSelected && ![BMUtils isEmptyString:password]) {
        [self.registerButton setEnabled:YES];
    }

}


/**
 *  获取验证码
 *
 *  @param sender sender description
 */
- (IBAction)codeAction:(UIButton *)sender {
    weakSelf(self);
    [self.phoneTextField resignFirstResponder];
    NSString *phone = _phoneTextField.text;
    if (![BMUtils isValidateMobile:phone]) {
        [self showHint:@"请输入有效手机号码!"];
        return;
    }
    
    BMRequest *request = [BMRequest requestWithPath:k_ObtainVCode];
    request.params = @{@"mobile": phone, @"role": kRole};
    [self showHudWithhint:kDefaultMessage];
    [[BMHttpTool sharedInstance] postWith:request finish:^(BMResponse *response, NSError *error) {
        [weakSelf hideHud];
        if (response.Status == kResultOK) {
            [weakSelf showHint:response.Message];
            [weakSelf showCodeCountdown];
        } else {
            [weakSelf showHint:response ? response.Message : @"获取验证码失败,请重新获取!"];
        }
    }];
}


- (void)showCodeCountdown
{
    weakSelf(self);
    __block int timeout = 60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [weakSelf.obtainVCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                weakSelf.obtainVCodeButton.userInteractionEnabled = YES;
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //NSLog(@"____%@",strTime);
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [weakSelf.obtainVCodeButton setTitle:[NSString stringWithFormat:@"%@s",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
                weakSelf.obtainVCodeButton.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

- (IBAction)protocolAction:(UIButton *)sender {
    weakSelf(self);
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Register" bundle:nil];
    BMProtocolViewController *webVC = [storyboard instantiateViewControllerWithIdentifier:@"protocolVC"];
    webVC.type = 3;
//    webVC.path = [[NSBundle mainBundle] URLForResource:@"agree" withExtension:@"html"];
    
    [webVC isAgree:^(BOOL isAgree) {
        weakSelf.agreeButton.selected = isAgree;
    }];
    [self.navigationController pushViewController:webVC animated:YES];
}


/**
 *  注册
 *
 *  @param sender sender description
 */
- (IBAction)nextAction:(id)sender {
    NSString *phone = _phoneTextField.text;
    if (![BMUtils isValidateMobile:phone]) {
        [self showHint:@"请输入有效手机号码!"];
        return;
    }
    
    //验证码
    NSString *code = _codeTextField.text;
    if (![BMUtils isValidateCode:code]) {
        [self showHint:@"请输入6位有效的验证码"];
        return;
    }
    
    //密码
    NSString *pwd = _passwordTextField.text;
    if (![BMUtils isValidatePassword:pwd]) {
        [self showHint:@"密码长度不能小于6位!"];
        return;
    }
    if (!_agreeButton.isSelected) {
        [self showHint:@"需同意注册协议"];
        return;
    }
    
    //验证验证码
    weakSelf(self);
    BMRequest *request = [BMRequest requestWithPath:k_CheckVCode];
    request.params = @{@"mobile" : phone,  @"vCode" : code};
    [self showHudWithhint:kDefaultMessage];
    [[BMHttpTool sharedInstance] postWith:request finish:^(BMResponse *response, NSError *error) {
        [weakSelf hideHud];
        if (response.Status == kResultOK) {
            //请求注册
            
            BMRequest *request = [BMRequest requestWithPath:k_Register contentKey:kRoleType ? @"Dispatcher" : @"Owner"];
            request.params = @{@"mobile": phone, @"password": pwd, @"role": kRole, @"vCode":code};
            [weakSelf showHudWithhint:kDefaultMessage];
            [User postWithRequest:request finish:^(BMResponse *response, NSError *error) {
                [weakSelf hideHud];
                if (response.Status == kResultOK) {
                    [BMAccountManager sharedInstance].user = response.result;
                    //开始登陆
                    [weakSelf userLogin:phone password:pwd];
                } else {
                    [weakSelf showHint:response ? response.Message : @"注册失败!"];
                    
                }
            }];
        }else{
            [weakSelf showHint:@"验证码验证失败"];
            
        }
    }];
    
    
//    //请求注册
//
//    BMRequest *request = [BMRequest requestWithPath:@"app/register" contentKey:kRoleType ? @"Dispatcher" : @"Owner"];
//    request.params = @{@"mobile": phone, @"password": pwd, @"role": kRole, @"vCode":code};
//    [self showHudWithhint:kDefaultMessage];
//    [User postWithRequest:request finish:^(BMResponse *response, NSError *error) {
//        [weakSelf hideHud];
//        if (response.status == kResultOK) {
//            [weakSelf showHint:response.msg];
//            //开始登陆
//            [weakSelf userLogin:phone password:pwd];
//        } else {
//            [weakSelf showHint:response ? response.msg : @"注册失败!"];
//        }
//    }];
//
}



- (IBAction)directLoginAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)userLogin:(NSString *)userName password:(NSString *)password
{
    weakSelf(self);
    BMRequest *request = [BMRequest requestWithPath:k_Login contentKey:kRoleType ? @"dispatcher" : @"owner"];
    request.params = @{@"username": userName, @"password": password, @"role": kRole};
    [self showHudWithhint:kDefaultMessage];
    [User postWithRequest:request finish:^(BMResponse *response, NSError *error) {
        [weakSelf hideHud];
        if (response.Status == 1) {
            LoginInfo *loginInfo = [LoginInfo mj_objectWithKeyValues:response.rawResult[@"loginInfo"]];
            [BMAccountManager sharedInstance].loginInfo = loginInfo;
            [BMAccountManager sharedInstance].user = response.result;
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        } else {
            [self showHint:response?response.Message:@"登陆失败"];
            [weakSelf directLoginAction:nil];
        }
    }];
}


- (void)showHint:(NSString *)hint
{
    [self showHint:hint yOffset:-100];
}



@end
