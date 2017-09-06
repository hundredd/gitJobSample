//
//  BMProtocolViewController.m
//  特种车调度
//
//  Created by 王鑫 on 16/3/10.
//
//

#import "BMProtocolViewController.h"

@interface BMProtocolViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation BMProtocolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kGlobalColor;
    
    if (_path) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:_path]];
    } else {
        [self getData];
    }
    self.webView.delegate = self;
}

- (void)getData {
    weakSelf(self);
    BMRequest *request = [BMRequest requestWithPath:k_GetSinglePageByType];
    NSMutableString *typeStr = [NSMutableString stringWithString:kRoleType ? @"站点端" : @"车主端"];
    NSString *destStr;
    switch (self.type) {
        case 1:
            destStr = [typeStr stringByAppendingString:@"使用指南"];
            break;
        case 2:
            destStr = [typeStr stringByAppendingString:@"关于我们"];
            break;
        case 3:
            destStr = [typeStr stringByAppendingString:@"注册协议"];
            break;
    }
    self.title = destStr;
    request.params = @{@"typeName" : destStr};
    [self showHudWithhint:kDefaultMessage];
    [[BMHttpTool sharedInstance] postWith:request finish:^(BMResponse *response, NSError *error) {
        [self hideHud];
        if (response.Status == kResultOK) {
            NSString *content = response.rawResult[@"singlePage"][@"content"];
            if (![BMUtils isEmptyString:content]) {
                [weakSelf.webView loadHTMLString:content baseURL:nil];
            }
            self.title = response.rawResult[@"singlePage"][@"typeName"];
        } else {
            [self showHint:response.Message];
        }
    }];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if ([BMUtils isEmptyString:self.title]) {
        NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
        self.title = title;
    }
}

- (IBAction)agreeAction:(UIButton *)sender {
    if (self.returnAgree != nil) {
        self.returnAgree(YES);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)isAgree:(ReturnAgree)block{
    self.returnAgree = block;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
