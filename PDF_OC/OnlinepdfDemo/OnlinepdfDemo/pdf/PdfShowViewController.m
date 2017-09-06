//
//  PdfShowViewController.m
//  OnlinepdfDemo
//
//  Created by hun on 2017/8/7.
//  Copyright © 2017年 hun. All rights reserved.
//

#import "PdfShowViewController.h"

@interface PdfShowViewController ()

@property(nonatomic,strong)UIWebView *webView ;//主要用作浏览在线页面的

@end

@implementation PdfShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title =  @"pdf展示页面";
    [self loadWebData];
    
}

-(void)loadWebData
{
    if (_urlStr)
    {
        NSURL *url = [NSURL URLWithString:_urlStr];
        NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
        [self.webView loadRequest:request];
    }else
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Reader" ofType:@"pdf"];
        NSURL *url = [NSURL fileURLWithPath:path];
        NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
        [self.webView loadRequest:request];
    }
}



-(UIWebView *)webView
{
    if (!_webView)
    {
         UIWebView *webView = [UIWebView new];
        webView.scalesPageToFit = YES;//实现放大!
        [self.view addSubview:webView];
        [webView mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.edges.equalTo(self.view);
        }];
        
        _webView = webView;
    }
    return _webView;
}

@end
