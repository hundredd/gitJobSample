//
//  ShareShowPicView.m
//  CompositePic
//
//  Created by hun on 2017/9/12.
//  Copyright © 2017年 hun. All rights reserved.
//

#import "ShareShowPicView.h"
#import "PicTools.h"
#import <MessageUI/MessageUI.h>
@interface ShareShowPicView ()<MFMessageComposeViewControllerDelegate>

@property(nonatomic,strong)UIImageView *showImgV;          //展示的imgV
@property(nonatomic,strong)UIButton *WechatBtn ;        //微信分享
@property(nonatomic,strong)UIButton *WechatFriendBtn;   //朋友圈的分享
@property(nonatomic,strong)UIButton *WeiboBtn;          //微博的分享
@property(nonatomic,strong)UIButton *MessageBtn;        //信息的分享
@property(nonatomic,strong)UIImage  *showImg ;          //
@end

@implementation ShareShowPicView

#pragma mark - public

-(void)setShowImg:(UIImage *)showImg
{
    _showImg = showImg;
    self.hidden = NO;
}

-(void)setHidden:(BOOL)hidden
{
    [super setHidden:hidden];
    if (!hidden)
    {
        [self.showImgV setImage:self.showImg];
    }
}


#pragma mark - private
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setupUI];
    }
    return self;
}

-(void)setupUI
{
    
    [self addSubview:self.showImgV];
    
    UIView *bottomView = [UIView new];
    [self addSubview:bottomView];
    
    [bottomView addSubview:self.WechatBtn];
    [bottomView addSubview:self.WechatFriendBtn];
    [bottomView addSubview:self.WeiboBtn];
    [bottomView addSubview:self.MessageBtn];
    
    __weak typeof(self) weakSelf = self;
    
    [self.showImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(10);
        make.right.mas_equalTo(10);
    }];
    
    CGFloat btnH = 50;
    CGFloat btnW = 50;
    CGFloat magin = ([UIScreen mainScreen].bounds.size.width-20 -4*btnW)/5.0;
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.showImgV.mas_bottom).offset(10);
        make.bottom.left.right.equalTo(weakSelf);
        make.height.equalTo(@100);
    }];
    [self.WechatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(magin);
        make.centerY.equalTo(bottomView);
        make.width.mas_equalTo(btnW);
        make.height.mas_equalTo(btnH);
    }];
    [self.WechatFriendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.WechatBtn.mas_right).offset(magin);
        make.centerY.equalTo(weakSelf.WechatBtn);
        make.width.height.equalTo(weakSelf.WechatBtn);
    }];
    [self.WeiboBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.WechatFriendBtn.mas_right).offset(magin);
        make.centerY.equalTo(weakSelf.WechatFriendBtn);
        make.width.height.equalTo(weakSelf.WechatBtn);
    }];
    [self.MessageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.WeiboBtn.mas_right).offset(magin);
        make.centerY.equalTo(weakSelf.WeiboBtn);
        make.width.height.equalTo(weakSelf.WechatBtn);
        make.right.equalTo(weakSelf).offset(-magin);
    }];
}


-(void)shareAction:(UIButton *)shareBtn
{
    NSInteger tag = shareBtn.tag;
    NSLog(@"点击的按钮%d",tag);
    if (tag == 1)//微信分享
    {
        
    }else if (tag == 2)//朋友圈分享
    {
        
    }else if (tag == 3)//微博分享
    {
        
    }else if (tag == 4)//信息分享
    {
        [self messageAction];
    }
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.hidden = YES;
}


#pragma mark - method

-(void)messageAction
{
    if( [MFMessageComposeViewController canSendText] )
    {
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc] init];
        controller.recipients = @[@"135226372819"];
        controller.navigationBar.tintColor = [UIColor redColor];
        //如果运行商支持附件
        if ([MFMessageComposeViewController canSendAttachments]) {
            /*第一种方法*/
            //messageController.attachments=...;
            
            NSData *data=UIImagePNGRepresentation([UIImage imageNamed:@"微信"]);
            /** * attatchData:文件数据 * uti:统一类型标识，标识具体文件类型，详情查看：帮助文档中System-Declared Uniform Type Identifiers * fileName:展现给用户看的文件名称 */
         [controller addAttachmentData:data typeIdentifier:@"微信" filename:@"photo.png"];
        }
        controller.messageComposeDelegate = self;
        [self.window.rootViewController presentViewController:controller animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息"
                                                        message:@"该设备不支持短信功能"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
}

#pragma mark - MFMessageComposeViewController代理方法
//发送完成，不管成功与否
-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    switch (result) {
        case MessageComposeResultSent:
            NSLog(@"发送成功.");
            break;
        case MessageComposeResultCancelled:
            NSLog(@"取消发送.");
            break;
        default:
            NSLog(@"发送失败.");
            break;
    }
    self.hidden = YES;
}

#pragma mark - getter
-(UIImageView *)showImgV
{
    if (!_showImgV) {
        UIImageView *showView = [UIImageView new];
        showView.contentMode = UIViewContentModeScaleAspectFit;
        _showImgV = showView;
    }
    return _showImgV;
}

-(UIButton *)WechatBtn
{
    if (!_WechatBtn) {
        UIButton *btn = [UIButton new];
        btn.tag = 1;
        [btn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:[UIImage imageNamed:@"微信"] forState:UIControlStateNormal];
        _WechatBtn = btn;
    }
    return _WechatBtn;
}


-(UIButton *)WechatFriendBtn
{
    if (!_WechatFriendBtn) {
        UIButton *btn = [UIButton new];
        btn.tag = 2;
        [btn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:[UIImage imageNamed:@"朋友圈"] forState:UIControlStateNormal];
        
        _WechatFriendBtn = btn;
    }
    return _WechatFriendBtn;
}

-(UIButton *)WeiboBtn
{
    if (!_WeiboBtn) {
        UIButton *btn = [UIButton new];
        btn.tag = 3;
        [btn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:[UIImage imageNamed:@"朋友圈"] forState:UIControlStateNormal];
        _WeiboBtn = btn;
    }
    return _WeiboBtn;
}
-(UIButton *)MessageBtn
{
    if (!_MessageBtn) {
        UIButton *btn = [UIButton new];
        btn.tag = 4;
        [btn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:[UIImage imageNamed:@"朋友圈"] forState:UIControlStateNormal];
        _MessageBtn = btn;
    }
    return _MessageBtn;
}

@end
