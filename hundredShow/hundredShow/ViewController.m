//
//  ViewController.m
//  hundredShow
//
//  Created by hun on 2017/8/28.
//  Copyright © 2017年 hun. All rights reserved.
//

#import "ViewController.h"
#import "NSCodingSearchBar.h"


#define H_SCREENWIDTH       [UIScreen mainScreen].bounds.size.width
@interface ViewController ()<UISearchBarDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSelfSearch];
    
    
    
}


-(void)setupSelfSearch
{
    NSCodingSearchBar *searchBar = [[NSCodingSearchBar alloc] initWithFrame:(CGRectMake(0, 40, H_SCREENWIDTH, 40))];
    [self.view addSubview:searchBar];
    searchBar.placeholder = @"产品名称/投顾/发行方/发行通道";
    searchBar.delegate = self;
}

-(void)setupNomalSearch
{
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:(CGRectMake(0, 40, H_SCREENWIDTH, 40))];
    [self.view addSubview:searchBar];
    searchBar.placeholder = @"姓名/昵称/电话/姓名/昵称/电话";
    [searchBar setContentMode:UIViewContentModeLeft];
    searchBar.delegate = self;
    // 样式
    searchBar.searchBarStyle = UISearchBarStyleDefault;
    // ** 自定义searchBar的样式 **
    UITextField* searchField = nil;
    // 注意searchBar的textField处于孙图层中
    for (UIView* subview  in [searchBar.subviews firstObject].subviews) {
        NSLog(@"%@", subview.class);
        // 打印出两个结果:
        /*
         UISearchBarBackground
         UISearchBarTextField
         */
        
        if ([subview isKindOfClass:[UITextField class]]) {
            
            searchField = (UITextField*)subview;
            // leftView就是放大镜
            // searchField.leftView=nil;
            // 删除searchBar输入框的背景
            [searchField setBackground:nil];
            [searchField setBorderStyle:UITextBorderStyleNone];
            searchField.backgroundColor = [UIColor whiteColor];
            // 设置圆角
            searchField.layer.cornerRadius = 15;
            searchField.layer.masksToBounds = YES;
            break;
        }
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


@end
