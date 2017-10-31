//
//  ScreenViewController.m
//  CompositePic
//
//  Created by hun on 2017/10/9.
//  Copyright © 2017年 hun. All rights reserved.
//

#import "ScreenViewController.h"

@interface ScreenViewController ()
@property(nonatomic,strong)UIImageView *backImgV ;//
@property(nonatomic,strong)UIImageView *backQHImgV ;//
@property(nonatomic,strong)UIImageView *QHImgV ;//


@end

@implementation ScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
