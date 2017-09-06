//
//  WebChatShareViewController.m
//  OnlinepdfDemo
//
//  Created by hun on 2017/8/14.
//  Copyright © 2017年 hun. All rights reserved.
//

#import "WebChatShareViewController.h"
#import "WXApiRequestHandler.h"
@interface WebChatShareViewController ()

@property (nonatomic) enum WXScene currentScene;

@end

@implementation WebChatShareViewController
-(enum WXScene)currentScene
{
    //分享到会话
    return WXSceneSession;
}

//分享文件
-(void)fileAction
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Reader" ofType:@"pdf"];
    UIImage *thumbImage = [UIImage imageNamed:@"icon_pdf"];
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    
    [WXApiRequestHandler sendFileData:fileData
                        fileExtension:kFileExtension
                                Title:kFileTitle
                          Description:kFileDescription
                           ThumbImage:thumbImage
                              InScene:_currentScene];
}

//URL分享
-(void)urlAction
{
    NSString *urlStr = @"http://www.wuhuepb.gov.cn/WebFileDb/NewFile/201407010837081010.pdf";
    UIImage *thumbImage = [UIImage imageNamed:@"logo"];
    [WXApiRequestHandler sendLinkURL:urlStr
                             TagName:kLinkTagName
                               Title:kLinkTitle
                         Description:kLinkDescription
                          ThumbImage:thumbImage
                             InScene:_currentScene];
    
}

//图片分享
-(void)pictureAction
{
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"logo" ofType:@"png"];
    NSData *imageData = [NSData dataWithContentsOfFile:filePath];
    
    //展示图片!
    UIImage *thumbImage = [UIImage imageNamed:@"logo"];
    [WXApiRequestHandler sendImageData:imageData
                               TagName:kImageTagName
                            MessageExt:kMessageExt
                                Action:kMessageAction
                            ThumbImage:thumbImage
                               InScene:self.currentScene];
    
}




#pragma mark - private
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =  @"微信分享";
    
    [self setupUI];
    
}


-(void)setupUI
{
    UIButton *fileBtn = [UIButton new];
    fileBtn.backgroundColor = [UIColor purpleColor];
    [fileBtn setTitle:@"文件分享" forState:UIControlStateNormal];
    [fileBtn addTarget:self action:@selector(fileAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fileBtn];
    
    UIButton *urlBtn = [UIButton new];
    urlBtn.backgroundColor = [UIColor greenColor];
    [urlBtn setTitle:@"URL分享" forState:UIControlStateNormal];
    [urlBtn addTarget:self action:@selector(urlAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:urlBtn];
    
    UIButton *imgBtn = [UIButton new];
    imgBtn.backgroundColor = [UIColor redColor];
    [imgBtn setTitle:@"图片分享" forState:UIControlStateNormal];
    [imgBtn addTarget:self action:@selector(pictureAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:imgBtn];
    
    CGFloat magin  =20;
    [fileBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(-3*magin);
        make.height.equalTo(@44);
    }];
    
    [urlBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(fileBtn.mas_bottom).offset(10);
        //        make.centerY.equalTo(self.view).offset(-magin);
        make.height.equalTo(@44);
    }];
    [imgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(urlBtn.mas_bottom).offset(10);
        make.height.equalTo(@44);
    }];

}


@end
