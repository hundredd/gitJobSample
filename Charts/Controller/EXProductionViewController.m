//
//  EXProductionViewController.m
//  Charts
//
//  Created by Eleven on 16/8/15.
//  Copyright © 2016年 Eleven. All rights reserved.
//

#import "EXProductionViewController.h"
#import "IQKeyboardManager.h"
#import "EXProductionData.h"
#import "EXAccruedView.h"
@interface EXProductionViewController () <UITextFieldDelegate>


/**
 *  用于网络请求的Session对象
 */
@property (nonatomic, strong) AFHTTPSessionManager *session;



/**
 *  用于存储生产数据
 */
@property (nonatomic, strong) NSArray *productions;

@property (weak, nonatomic) EXProductionData *productionDataView;
@property (weak, nonatomic) IBOutlet UIButton *productionDataButton;
@property (weak, nonatomic) IBOutlet UIButton *vehicleTransportationButton;
@property (weak, nonatomic) IBOutlet UIButton *accruedButton;
- (IBAction)buttonClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *indicatorLeftMargin;
@property (nonatomic, weak) UIButton *currentButton;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) EXAccruedView *accruedView;

@end

@implementation EXProductionViewController

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //禁用IQKeyboardManager
    [[IQKeyboardManager sharedManager] setEnable:NO];
    [self configuration];
}

- (void)viewWillAppear:(BOOL)animated{
    if (self.accruedView) {
        if (self.accruedView.stationDic != nil) {
            [self.accruedView changeViewAction];
        }
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"生产类";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)configuration {
    _scrollView.contentSize = CGSizeMake(kScreenWidth * 3, 0);
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = leftItem;
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"time"] style:UIBarButtonItemStylePlain target:self action:@selector(timeSheet)];
//    self.navigationItem.rightBarButtonItem = rightItem;
    _currentButton = _productionDataButton;
    EXProductionData *productionDataView = [[[NSBundle mainBundle] loadNibNamed:@"EXProductionData" owner:nil options:nil] lastObject];
    productionDataView.frame = self.scrollView.frame;
    self.productionDataView = productionDataView;
    [self.scrollView addSubview:productionDataView];

     UIView *vehicleTransportView = [[[NSBundle mainBundle] loadNibNamed:@"EXVehicleTransport" owner:nil options:nil] lastObject];
    vehicleTransportView.frame = CGRectMake(kScreenWidth,self.scrollView.frame.origin.y, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    [self.scrollView addSubview:vehicleTransportView];
    if (!self.accruedView) {
        EXAccruedView *accruedView = [[[NSBundle mainBundle] loadNibNamed:@"EXAccruedView" owner:nil options:nil] lastObject];
        self.accruedView = accruedView;
    }
    
    self.accruedView.frame = CGRectMake(kScreenWidth * 2,self.scrollView.frame.origin.y, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    [self.scrollView addSubview:self.accruedView];
}

- (IBAction)buttonClick:(UIButton *)sender {
    if (_currentButton == sender) return;
    [_scrollView setContentOffset:CGPointMake(_scrollView.width * sender.tag, 0) animated:YES];
}

- (void)backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UIScrollViewDelegate代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _scrollView) {
        _indicatorLeftMargin.constant = scrollView.contentOffset.x / 3;
        CGFloat index = scrollView.contentOffset.x / self.scrollView.width + 0.5;
        if (index > 0 && index < 1) {
            _productionDataButton.selected = YES;
            _vehicleTransportationButton.selected = NO;
            _accruedButton.selected = NO;
            _currentButton = _productionDataButton;
        } else if (index >= 1 && index < 2) {
            _productionDataButton.selected = NO;
            _vehicleTransportationButton.selected = YES;
            _accruedButton.selected = NO;
            _currentButton = _vehicleTransportationButton;
        } else if (index >= 2 && index < 3) {
            _productionDataButton.selected = NO;
            _vehicleTransportationButton.selected = NO;
            _accruedButton.selected = YES;
            _currentButton = _accruedButton;
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

@end
