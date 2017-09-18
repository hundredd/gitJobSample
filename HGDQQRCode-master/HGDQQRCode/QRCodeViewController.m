//
//  QRCodeViewController.m
//  HGDQQRCode
//
//  Created by hun on 2017/9/18.
//  Copyright © 2017年 zhuming. All rights reserved.
//

#import "QRCodeViewController.h"
#import "HGDQQRCodeView.h"
#import <Masonry.h>

@interface QRCodeViewController ()

@property(nonatomic,strong)UIView *showView ;//展示

@property(nonatomic,strong)UIButton *upLoad ;//上传图片



@end

@implementation QRCodeViewController
{
    UIImage *_uploadQRImage;//自己的上传的二维码
    UIImage *_showQRImage;//生成自己的二维码
}



#pragma mark - method
-(void)uploadAction
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择上传的二维码的方式" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        _uploadQRImage = [UIImage imageNamed:@"WechatIMG128"];
        
        // 截图
        UIImage *im = _uploadQRImage;
        // 读取图片中的二维码
        NSArray *array = [HGDQQRCodeView readQRCodeFromImage:im];
        // 显示二维码中的信息
//        NSMutableString *str = [[NSMutableString alloc] init];
        __block NSString *str = @"";
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CIQRCodeFeature *temp = (CIQRCodeFeature *)obj;
//            [str appendFormat:@"地址:%@",temp.messageString];
            str = temp.messageString;
            NSLog(@"地址:%@",temp.messageString);
        }];
        //进行图片的识别!
        [HGDQQRCodeView creatQRCodeWithURLString:str superView:self.showView logoImage:[UIImage imageNamed:@"logo"] logoImageSize:CGSizeMake(40, 40) logoImageWithCornerRadius:0];
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}


#pragma mark - private
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

-(void)setupUI
{
    [self.showView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@100);
        make.centerX.equalTo(self.view);
        make.width.height.mas_equalTo(@200);
    }];
    
    [self.upLoad mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_showView.mas_bottom).offset(10);
        make.centerX.equalTo(self.view);
    }];
}

#pragma mark - getter
-(UIView *)showView
{
    if (!_showView) {
        UIView *view = [UIView new];
        [self.view addSubview:view];
        _showView = view;
        
    }
    return _showView;
}


-(UIButton *)upLoad
{
    if (!_upLoad) {
        UIButton *btn = [UIButton new];
        [btn setTitle:@"上传" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(uploadAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        _upLoad=btn;
    }
    return _upLoad;
}


@end
