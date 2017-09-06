//
//  EXAboutUsViewController.m
//  Charts
//
//  Created by Eleven on 16/9/14.
//  Copyright © 2016年 Eleven. All rights reserved.
//

#import "EXAboutUsViewController.h"

@interface EXAboutUsViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation EXAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = leftItem;
//    NSURL *url = [[NSURL alloc]initWithString:@"http://www.baidu.com"];
//    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"agree.html" withExtension:nil];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
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
