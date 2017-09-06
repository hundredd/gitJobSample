//
//  RYWebControllerViewController.m
//  特种车调度
//
//  Created by 韩学鹏 on 16/4/18.
//
//

#import "RYWebControllerViewController.h"

@interface RYWebControllerViewController ()<UIWebViewDelegate>

@end

@implementation RYWebControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"商城";
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    
    NSURL *URL = [NSURL URLWithString:GCB_];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    [webView loadRequest:request];
    webView.delegate = self;
}


#pragma mark - UIWebViewDelegate

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self hideHud];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self showHudWithhint:@"正在进入商城..."];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self hideHud];
    //webview控制内存增长
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
    
    int cacheSizeMemory = 20*1024*1024;
    int cacheSizeDisk = 50*1024*1024;
    NSURLCache *sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:cacheSizeMemory diskCapacity:cacheSizeDisk diskPath:nil] ;
    [NSURLCache setSharedURLCache:sharedCache];
}

- (void)dealloc
{
    
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    //清楚html5产生的缓存 
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
