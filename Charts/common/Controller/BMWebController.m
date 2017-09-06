//
//  BMWebController.m
//  电商框架
//
//  Created by 陈宇 on 15/8/5.
//  Copyright (c) 2015年 陈宇. All rights reserved.
//

#import "BMWebController.h"

@interface BMWebController () <UIWebViewDelegate>

@property(nonatomic, weak) UIWebView *webView;

@end

@implementation BMWebController

- (void)loadView {
    UIWebView *webView = [[UIWebView alloc] init];
    webView.delegate = self;
    webView.scalesPageToFit = YES;
    self.view = webView;
    _webView = webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    if (_path) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:_path]];
    } else {
        [self getData];
    }
}

- (void)getData {
    weakSelf(self);
    BMRequest *request = [BMRequest requestWithPath:k_GetSinglePageByType];
    NSMutableString *typeStr = [NSMutableString stringWithString:kRoleType ? @"站点端" : @"车主端"];
    NSString *destStr;
    switch (_type) {
        case 1:
            destStr = [typeStr stringByAppendingString:@"使用指南"];
            break;
        case 2:
            destStr = @"关于平台";
            break;
        case 3:
            destStr = [typeStr stringByAppendingString:@"注册协议"];
            break;
        case 4:{
            destStr = @"站点端钱包使用说明";
        }break;
        case 5:{
            destStr = @"车主端钱包使用说明";
        }break;
    }
    self.title = destStr;
    request.params = @{@"typeName" : destStr};
    [self showHudWithhint:kDefaultMessage];
    [[BMHttpTool sharedInstance] postWith:request finish:^(BMResponse *response, NSError *error) {
        [self hideHud];
        if (response.Status == kResultOK) {
            if ([response.rawResult[@"singlePage"] isKindOfClass:[NSDictionary class]]) {
                NSString *content = response.rawResult[@"singlePage"][@"content"];
                if (![BMUtils isEmptyString:content]) {
                    [weakSelf.webView loadHTMLString:content baseURL:nil];
                }
            }
        }else{
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


@end
