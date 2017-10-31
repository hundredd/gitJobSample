//
//  ViewController.m
//  CompositePic
//
//  Created by hun on 2017/9/12.
//  Copyright © 2017年 hun. All rights reserved.
//

#import "ViewController.h"
#import "ShareShowPicView.h"
#import "PicTools.h"


#import "ScreenViewController.h"

@interface ViewController ()
@property(nonatomic,strong)ShareShowPicView *showView ;//看具体的页面
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (IBAction)showAction:(id)sender
{
    
    UIImage *img = [PicTools addImage:[UIImage imageNamed:@"背景"]
                           addHeadImg:[UIImage imageNamed:@"微信"]
                              andName:@"严晨丹"
                          andSubtitle:@"私人银行家"
                               andTel:@"186888866666"
                            andQRCode:[UIImage imageNamed:@"二维码"]];
    [self.showView setShowImg:img];
}
- (IBAction)jump:(id)sender
{
    [self presentViewController:[NSClassFromString(@"ScreenViewController") new] animated:YES completion:nil];
}

-(ShareShowPicView *)showView
{
    if (!_showView) {
        ShareShowPicView *view = [ShareShowPicView new];
        view.backgroundColor = [UIColor redColor];
        view.alpha = 0.9;
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(10, 10, 10, 10));
        }];
        _showView =view;
    }
    return _showView;
}




@end
