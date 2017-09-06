//
//  EXLogisticsUpdateViewController.m
//  Charts
//
//  Created by Eleven on 16/8/16.
//  Copyright © 2016年 Eleven. All rights reserved.
//

#import "EXLogisticsUpdateViewController.h"
#import "IQKeyboardManager.h"
@interface EXLogisticsUpdateViewController ()
@property (weak, nonatomic) IBOutlet UIButton *equipmentInformationButton;
@property (weak, nonatomic) IBOutlet UIButton *teamOperatingButton;
- (IBAction)buttonClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *indicatorLeftMargin;
@property (weak, nonatomic) UIButton *currentButton;
@end

@implementation EXLogisticsUpdateViewController

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //禁用IQKeyboardManager
    [[IQKeyboardManager sharedManager] setEnable:NO];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"物流";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self configuration];
}

- (void)configuration {
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = leftItem;
    _currentButton = _equipmentInformationButton;
    _scrollView.contentSize = CGSizeMake(kScreenWidth * 2, 0);
    UIView *logisticsUpdateView = [[[NSBundle mainBundle] loadNibNamed:@"EXLogisticsUpdate" owner:nil options:nil] lastObject];
    logisticsUpdateView.frame = CGRectMake(0, 0, self.scrollView.frame.size.width, self.scrollView.size.height);
    [self.scrollView addSubview:logisticsUpdateView];
    UIView *teamOperatingView = [[[NSBundle mainBundle] loadNibNamed:@"EXTeamOperating" owner:nil options:nil] lastObject];
    teamOperatingView.frame = CGRectMake(kScreenWidth, 0, self.scrollView.frame.size.width, self.scrollView.size.height);
    [self.scrollView addSubview:teamOperatingView];
}

- (void)backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - UIScrollViewDelegate代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _scrollView) {
        _indicatorLeftMargin.constant = scrollView.contentOffset.x / 2;
        CGFloat index = scrollView.contentOffset.x / self.scrollView.width + 0.5;
        if (index > 0 && index < 1) {
            _equipmentInformationButton.selected = YES;
            _teamOperatingButton.selected = NO;
            _currentButton = _equipmentInformationButton;
        } else if (index >= 1 && index < 2) {
            _equipmentInformationButton.selected = NO;
            _teamOperatingButton.selected = YES;
            _currentButton = _teamOperatingButton;
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)buttonClick:(UIButton *)sender {
    if (_currentButton == sender) return;
    if (_currentButton == _equipmentInformationButton) {
        
    }
    [_scrollView setContentOffset:CGPointMake(_scrollView.width * sender.tag, 0) animated:YES];

}
@end
