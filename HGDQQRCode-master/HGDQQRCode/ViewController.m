//
//  ViewController.m
//  HGDQQRCode
//
//  Created by zhuming on 16/3/9.
//  Copyright © 2016年 zhuming. All rights reserved.
//

#import "ViewController.h"
#import "HGDQQRCodeView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *QRView;

@property (weak, nonatomic) IBOutlet UILabel *msglabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.msglabel sizeToFit];
    // Do any additional setup after loading the view, typically from a nib.
}
/**
 *  生成二维码
 *
 *  @param sender sender description
 */
- (IBAction)btnClick:(id)sender {
    [HGDQQRCodeView creatQRCodeWithURLString:@"http://blog.csdn.net/zhuming3834" superView:self.QRView logoImage:[UIImage imageNamed:@"logo"] logoImageSize:CGSizeMake(40, 40) logoImageWithCornerRadius:0];
}
/**
 *  读取图片中的二维码
 *
 *  @param sender sender description
 */
- (IBAction)readBtnClick:(id)sender {
    // 截图
    UIImage *im = [HGDQQRCodeView screenShotFormView:self.view];
    // 读取图片中的二维码
    NSArray *array = [HGDQQRCodeView readQRCodeFromImage:im];
    // 显示二维码中的信息
    NSMutableString *str = [[NSMutableString alloc] init];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CIQRCodeFeature *temp = (CIQRCodeFeature *)obj;
        [str appendFormat:@"地址:%@",temp.messageString];
    }];
    self.msglabel.text = str;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
