//
//  EXHomeViewController.m
//  Charts
//
//  Created by Eleven on 16/7/21.
//  Copyright © 2016年 Eleven. All rights reserved.
//

#import "EXHomeViewController.h"
#import "EXRoundOrderView.h"
@interface EXHomeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *ActualDayTotalLabel;
@property (weak, nonatomic) IBOutlet UILabel *ActualMonthTotalLabel;
@property (weak, nonatomic) IBOutlet UILabel *PlanDayTotalLabel;
@property (weak, nonatomic) IBOutlet UILabel *PlanMonthTotalLabel;
@property (strong, nonatomic) NSDictionary *productDataDic;
@end

@implementation EXHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *image0 = [UIImage imageNamed:@"roundOrder_logistics"];
    UIImage *image1 = [UIImage imageNamed:@"roundOrder_comprehensive"];
    UIImage *image2 = [UIImage imageNamed:@"roundOrder_CustomerService"];
    UIImage *image3 = [UIImage imageNamed:@"roundOrder_production"];
    UIImage *image4 = [UIImage imageNamed:@"roundOrder_technology"];
    UIImage *centerImage = [UIImage imageNamed:@"roundOrder_logo"];
    EXRoundOrderView *roundOrderView = [[EXRoundOrderView alloc] initWithFrame:CGRectMake(self.view.center.x - 40, self.view.center.y - self.view.frame.size.height / 3, self.view.frame.size.width * 1.2, self.view.frame.size.width * 1.2) andImage:[UIImage imageNamed:@"roundOrder_bg"]];
    [roundOrderView addSubViewWithSubView:@[image0, image1, image2, image3, image4] andTitle:@[@"物流类",@"综合类",@"客服类",@"生产类",@"技术类"] andSize:CGSizeMake(120, 120) andcenterImage:centerImage];
    [self.view addSubview:roundOrderView];
    roundOrderView.clickSomeOne=^(NSString *str){
        NSLog(@"%@被点击了",str);
    };
    //tabBar添加向左滑动手势
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipLeftAction:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipeLeft];
    self.productDataDic = [[NSDictionary alloc] init];
    [self getData];
}

- (void)getData{
    //1.创建会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    //2.根据会话对象创建task
    NSURL *url = [NSURL URLWithString:@"http://113.57.155.226:9631/api/Production/GetProductionHomeData"];
    //3.创建可变的请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //4.修改请求方法为POST
    request.HTTPMethod = @"POST";
    //5.设置请求体
    request.HTTPBody = [[NSString stringWithFormat:@"UserId=%@&AccessToken=%@", [BMAccountManager sharedInstance].user.UserId, [BMAccountManager sharedInstance].loginInfo.AccessToken] dataUsingEncoding:NSUTF8StringEncoding];
    //6.根据会话对象创建一个Task(发送请求）
    /*
     第一个参数：请求对象
     第二个参数：completionHandler回调（请求完成【成功|失败】的回调）
     data：响应体信息（期望的数据）
     response：响应头信息，主要是对服务器端的描述
     error：错误信息，如果请求失败，则error有值
     */
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //8.解析数据
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSLog(@"%@",dict);
        self.productDataDic = dict[@"AppendData"];
        [self performSelectorOnMainThread:@selector(refreshUI) withObject:nil waitUntilDone:YES];
    }];
    //7.执行任务
    [dataTask resume];
}

- (void)refreshUI{
    if (self.productDataDic && ![self.productDataDic isEqual:@""]) {
        self.ActualDayTotalLabel.text = self.productDataDic[@"ActualDayTotal"];
        self.ActualMonthTotalLabel.text = self.productDataDic[@"ActualMonthTotal"];
        self.PlanDayTotalLabel.text = self.productDataDic[@"PlanDayTotal"];
        self.PlanMonthTotalLabel.text = self.productDataDic[@"PlanMonthTotal"];
    }else{
        self.ActualDayTotalLabel.text = @"0.0";
        self.ActualMonthTotalLabel.text = @"0.0";
        self.PlanDayTotalLabel.text = @"0.0";
        self.PlanMonthTotalLabel.text = @"0.0";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)swipLeftAction:(UISwipeGestureRecognizer *)recognizer
{
    self.tabBarController.selectedIndex = 1;
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
