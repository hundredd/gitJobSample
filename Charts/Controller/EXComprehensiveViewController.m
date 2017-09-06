//
//  EXEXComprehensiveViewController.m
//  Charts
//
//  Created by Eleven on 16/8/8.
//  Copyright © 2016年 Eleven. All rights reserved.
//

#import "EXComprehensiveViewController.h"
#import "EXAddViewController.h"
#import "EXAddTopItemView.h"
#import "EXComprehensiveRightTableViewCell.h"
#import "EXComprehensiveData.h"
@interface EXComprehensiveViewController ()<UIScrollViewDelegate,UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *leftScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *topScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *rightScrollView;
@property (weak, nonatomic) IBOutlet UITextField *timeTextField;
@property (weak, nonatomic) UIView *topAddView;
@property (assign, nonatomic) CGFloat X;
@property (assign, nonatomic) CGFloat Y;
@property (assign, nonatomic) NSInteger count;
@property (strong, nonatomic) NSArray *resultArray;
@property (strong, nonatomic) NSArray *comprehensiveDataArray;
@property (weak, nonatomic) UITableView *tableView;
@property (assign, nonatomic) NSInteger removeIndex;
@property (weak, nonatomic) UIView *topItemView;
/**
 *  添加的站点
 */
@property (nonatomic, strong) NSDictionary *stationDic;
@property (nonatomic, strong) NSMutableArray *addStationNameArray;
@property (nonatomic, strong) NSMutableArray *addStationIdArray;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
#pragma mark - 时间选择器
@property (nonatomic, weak) UIDatePicker *datePickerView;

@end

@implementation EXComprehensiveViewController

static NSString *cellReuse = @"cellReuse";
- (void)viewDidLoad {
    [super viewDidLoad];
    //导航栏
    self.title = @"综合";
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.leftScrollView.delegate = self;
    self.topScrollView.delegate = self;
    self.rightScrollView.delegate = self;
    self.topScrollView.directionalLockEnabled = YES;
    self.rightScrollView.directionalLockEnabled = YES;
    self.leftScrollView.directionalLockEnabled = YES;
    _X = 0;
    _Y = 0;
    [self configuration];
    self.count = 0;
    [self getDetailData];
    if (self.rightScrollView.contentOffset.x == 0) {
        self.leftButton.hidden = YES;
    }
    if (self.rightScrollView.contentSize.width - self.rightScrollView.frame.size.width - self.rightScrollView.contentOffset.x == 0) {
        self.rightButton.hidden = YES;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.stationDic != nil) {
        [self changeViewAction];
        [self refreshUI];
    }
    
    
}

- (void)backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)leftAction:(UIButton *)sender {
    if (self.rightScrollView.contentOffset.x > 0) {
        if (self.rightScrollView.contentOffset.x < 90) {
            self.rightScrollView.contentOffset = CGPointMake(0, self.rightScrollView.contentOffset.y);
        }else{
            self.X = self.X - 90;
            self.rightScrollView.contentOffset = CGPointMake(self.X, self.rightScrollView.contentOffset.y);
        }
    }

}
- (IBAction)rightAction:(UIButton *)sender {
    if (self.rightScrollView.contentSize.width - self.rightScrollView.frame.size.width - self.rightScrollView.contentOffset.x > 0) {
        if (self.rightScrollView.contentSize.width - self.rightScrollView.frame.size.width - self.rightScrollView.contentOffset.x < 90) {
            self.rightScrollView.contentOffset = CGPointMake(self.rightScrollView.contentSize.width - self.rightScrollView.frame.size.width, self.rightScrollView.contentOffset.y);
        }else{
            self.X = self.X + 90;
            self.rightScrollView.contentOffset = CGPointMake(self.X, self.rightScrollView.contentOffset.y);
        }
    }

    
}

- (void)configuration{
    
    //时间选择器
    self.timeTextField.delegate = self;
    UIDatePicker *dateInputView = [[UIDatePicker alloc] init];
    dateInputView.datePickerMode = UIDatePickerModeDate;
    dateInputView.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    self.timeTextField.inputView = dateInputView;
    self.timeTextField.inputAccessoryView = [[[NSBundle mainBundle] loadNibNamed:@"InputToolbar" owner:self options:nil] firstObject];
    self.datePickerView = dateInputView;
    self.addStationNameArray = [[NSMutableArray alloc] initWithCapacity:5];
    self.addStationIdArray = [[NSMutableArray alloc] initWithCapacity:5];
    
    //获取当前日期
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    self.timeTextField.text = dateString;
    
    //左边视图
    UIView *leftView = [[[NSBundle mainBundle] loadNibNamed:@"comprehensiveLeftView" owner:nil options:nil] lastObject];
    [self.leftScrollView addSubview:leftView];
    self.leftScrollView.contentSize = CGSizeMake(0, leftView.frame.size.height);
    
    //上边视图
    UIView *topAddView = [[[NSBundle mainBundle] loadNibNamed:@"comprehensiveTopView" owner:nil options:nil] firstObject];
    topAddView.tag = 10000;
    self.topAddView = topAddView;
    [self.topScrollView addSubview:topAddView];
    topAddView.frame = CGRectMake((self.topScrollView.subviews.count - 1) * 185, 0, 185, self.view.frame.size.height * 1 / 10);
    self.topScrollView.contentSize = CGSizeMake((self.topScrollView.subviews.count - 1) * 185, 0);
    
    
    
    //右边视图
//    UIView *rightInitialView = [[[NSBundle mainBundle] loadNibNamed:@"comprehensiveRightInitialView" owner:nil options:nil] lastObject];
//    [self.rightScrollView addSubview:rightInitialView];
//    self.rightScrollView.contentSize = CGSizeMake(rightInitialView.frame.size.width, rightInitialView.frame.size.height);
}

- (IBAction)toolbarCancle:(id)sender {
    [self.timeTextField resignFirstResponder];
}

- (IBAction)toolbarOK:(id)sender {
    NSDate *date = self.datePickerView.date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    if (dateString != self.timeTextField.text) {
        self.timeTextField.text = dateString;
        [self getDetailData];
    }
    
    [self.timeTextField resignFirstResponder];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addAction:(id)sender{
    EXAddViewController *addVC = [[UIStoryboard storyboardWithName:@"Add" bundle:nil] instantiateInitialViewController];
    [addVC feedbackData:^(NSDictionary *dic) {
        self.stationDic = dic;
        if (self.stationDic != nil) {
            NSString *stationName = self.stationDic[@"stationName"];
            [self.addStationNameArray addObject:stationName];
            [self.addStationIdArray addObject:self.stationDic[@"stationId"]];
        }
           }];
    [self.navigationController showViewController:addVC sender:nil];
}

- (void)changeViewAction{
    
        //添加右边视图
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(185 * self.count , 0,185, 1151) style:UITableViewStylePlain];
        [tableView registerNib:[UINib nibWithNibName:@"EXComprehensiveRightTableViewCell" bundle:nil] forCellReuseIdentifier:cellReuse];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.userInteractionEnabled = NO;
        tableView.scrollEnabled = NO;
        tableView.tag = self.count;
        self.tableView = tableView;
        
        [self.rightScrollView addSubview:tableView];
        self.rightScrollView.contentSize = CGSizeMake(185 * (self.count + 1), 1151);

        //添加上部视图
        EXAddTopItemView *topItemView = [[[NSBundle mainBundle] loadNibNamed:@"comprehensiveTopView" owner:nil options:nil] lastObject];
        topItemView.stationNameLabel.text = self.addStationNameArray[self.count];
        topItemView.tag = self.count;
        topItemView.frame = CGRectMake(topItemView.tag * 185, 0, 185, self.view.frame.size.height * 1 / 10);
        [self.topScrollView addSubview:topItemView];
        self.topItemView = topItemView;
        self.topAddView.frame = CGRectMake((self.count + 1)* 185, 0, 185, self.view.frame.size.height * 1 / 10);
        self.topScrollView.contentSize = CGSizeMake((self.count + 2) * 185, 0);
        self.count ++;
}


- (IBAction)comprehensiveRemoveAction:(UIButton *)sender{
    
    for (int i = 0; i < self.count; i++) {
        if (sender.superview.tag == i) {
            self.removeIndex = i;
        }
    }
    [self removeViewAction];
    
}


- (void)removeViewAction{
    for (UIView *topItemView in self.topScrollView.subviews) {
        if (topItemView.tag == self.removeIndex) {
            [topItemView removeFromSuperview];
            for (UIView *topItemView in self.topScrollView.subviews) {
                if (topItemView.tag > self.removeIndex) {
                    topItemView.frame = CGRectMake((topItemView.tag - 1) * 185, 0, 185, self.view.frame.size.height * 1 / 10);
                    topItemView.tag--;
                }
            }
            break;
        }
    }
    for (UITableView *tableView in self.rightScrollView.subviews) {
        if (tableView.tag == self.removeIndex) {
            [tableView removeFromSuperview];
            for (UITableView *tableView in self.rightScrollView.subviews) {
                if (tableView.tag > self.removeIndex) {
                    tableView.frame = CGRectMake(185 * (tableView.tag - 1), 0, 185, 1151);
                    tableView.tag--;
                    self.tableView = tableView;
                }

            }
            break;
        }
        
    }
    self.count--;
    self.topAddView.frame = CGRectMake((self.count) * 185, 0, 185, self.view.frame.size.height * 1 / 10);
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.rightScrollView) {
        self.X = scrollView.contentOffset.x;
        self.Y = scrollView.contentOffset.y;
        self.leftScrollView.contentOffset = CGPointMake(self.leftScrollView.contentOffset.x, self.Y);
        self.topScrollView.contentOffset =  CGPointMake(self.X, self.topScrollView.contentOffset.y);
        if (self.X == 0) {
            self.leftButton.hidden = YES;
        }else{
            self.leftButton.hidden = NO;
        }
        if (self.X >= self.rightScrollView.contentSize.width - self.rightScrollView.frame.size.width) {
            self.rightButton.hidden = YES;
        }else{
            self.rightButton.hidden = NO;
        }
    }
    if (scrollView == self.topScrollView) {
        self.X = scrollView.contentOffset.x;
        self.rightScrollView.contentOffset = CGPointMake(self.X, self.Y);
    }
    if (scrollView == self.leftScrollView) {
        self.Y = scrollView.contentOffset.y;
        self.rightScrollView.contentOffset = CGPointMake(self.X, self.Y);
    }
}

- (void)getDetailData{
    
    //1.创建会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    //2.根据会话对象创建task
    NSURL *url = [NSURL URLWithString:@"http://113.57.155.226:9631/api/BusinessIndexCompany/GetBusinessIndexCompanyData"];
    //3.创建可变的请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //4.修改请求方法为POST
    request.HTTPMethod = @"POST";
    //5.设置请求体
    //    request.HTTPBody = [@"UserId=387441b0-177e-4e67-8f9d-c2d0cf194300&AccessToken=Mzg3NDQxYjAtMTc3ZS00ZTY3LThmOWQtYzJkMGNmMTk0MzAwJDIwMTYvOC8zMSAxNjoyNzo1NA==&stationId=" dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody = [[NSString stringWithFormat:@"UserId=%@&AccessToken=%@&Selectmonth=%@", @"387441b0-177e-4e67-8f9d-c2d0cf194300", [BMAccountManager sharedInstance].loginInfo.AccessToken, self.timeTextField.text] dataUsingEncoding:NSUTF8StringEncoding];
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
        id result = dict[@"AppendData"];
        if ([result isKindOfClass:[NSArray class]]) {
            self.resultArray = result;
        }

    }];
    //7.执行任务
    [dataTask resume];
    
}

- (void)refreshUI{
    NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithCapacity:5];
    for (NSDictionary *temDic in self.resultArray) {
        NSString *stId = temDic[@"StationId"];
        for (NSString *stationId in self.addStationIdArray) {
            if ([stId isEqualToString:stationId]) {
                EXComprehensiveData *comprehensiveData = [EXComprehensiveData mj_objectWithKeyValues:temDic];
                [mutableArray addObject:comprehensiveData];
            }
        }
    }
    self.comprehensiveDataArray = [mutableArray copy];
    [self.tableView reloadData];
}

#pragma mark --- UITableViewDataSource/UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.addStationIdArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EXComprehensiveRightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuse];
    if (self.comprehensiveDataArray.count > 0) {
        cell.comprehensiveData = self.comprehensiveDataArray[self.count -1];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 1151;
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
