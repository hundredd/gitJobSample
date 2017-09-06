//
//  BMUpateAlert.m
//  特种车调度
//
//  Created by 韩学鹏 on 16/3/24.
//
//

#import "BMUpateAlert.h"

@interface BMUpateAlert ()

@property (nonatomic, strong) NSURL *updateURL;


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIWebView *updateContentWebView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutConstraint;

@property (weak, nonatomic) IBOutlet UIButton *noUpdateButton;
@property (weak, nonatomic) IBOutlet UIButton *updateButton;
- (IBAction)updateAction:(id)sender;
- (IBAction)cancelAction:(id)sender;
@end

@implementation BMUpateAlert

- (void)awakeFromNib
{
    self.updateContentWebView.layer.borderWidth = kOnePix;
    self.updateContentWebView.layer.borderColor = kGlobalColor.CGColor;
    
    self.noUpdateButton.layer.cornerRadius = 5.0f;
    self.noUpdateButton.layer.masksToBounds = YES;
    self.updateButton.layer.cornerRadius = 5.0f;
    self.updateButton.layer.masksToBounds = YES;
}

- (void)show
{
    if (!_updateInfo.status) {
        return;
    }
    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
    self.frame = window.bounds;
    [window addSubview:self];
}

- (void)dismiss
{
    [self removeFromSuperview];
}

- (void)setUpdateInfo:(BMUpateModel *)updateInfo
{
    _updateInfo = updateInfo;
    
    self.updateURL = [NSURL URLWithString:updateInfo.versionUrl];
    //self.titleLabel.text = title;
    if (updateInfo.content) {
        [self.updateContentWebView loadHTMLString:updateInfo.content baseURL:nil];
    }
    
    self.layoutConstraint.priority = updateInfo.forceUpdate ? 900 : 800;
    self.noUpdateButton.hidden = updateInfo.forceUpdate;
}

- (IBAction)updateAction:(id)sender {
    
    //        UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    //        [self.view addSubview:webView];
    //        NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //        [webView loadRequest:request];
    [[UIApplication sharedApplication] openURL:self.updateURL];
    
}

- (IBAction)cancelAction:(id)sender {
    [self dismiss];
}
@end
