//
//  EXMValueViewController.m
//  Charts
//
//  Created by Eleven on 16/8/24.
//  Copyright © 2016年 Eleven. All rights reserved.
//

#import "EXMValueViewController.h"
#import "MValueData.h"
#import "EXMValueRightTableViewCell.h"
@interface EXMValueViewController () <UIScrollViewDelegate, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewTop;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewRight;
@property (weak, nonatomic) IBOutlet UITextField *timeTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) UITableView *MValueDataTableView;
@property (assign, nonatomic) NSInteger selectIndex;
@property (nonatomic, strong) NSArray *MValueDataArray;
@property (weak, nonatomic) UIView *topView;
@property (assign, nonatomic) CGFloat X;
@property (assign, nonatomic) CGFloat Y;
/**
 *  用于存储站点名
 */
@property (nonatomic, strong) NSArray *stationNames;

/**
 *  用于存储站点id
 */
@property (nonatomic, strong) NSArray *stationIds;

#pragma mark - 时间选择器
@property (nonatomic, weak) UIDatePicker *datePickerView;
@end

@implementation EXMValueViewController

static NSString *MValueCellID = @"MValueCellID";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"项目M值";
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.scrollViewTop.delegate = self;
    self.scrollViewRight.delegate = self;
    _X = 0;
    _Y = 0;
    self.selectIndex = 0;
    [self configuration];
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
    
    
    //获取当前日期
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    self.timeTextField.text = dateString;
    
    //左部视图
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:228 / 255.0 blue:229 / 255.0 alpha:1];
    //上部视图
    UIView *topView = [[[NSBundle mainBundle] loadNibNamed:@"EXMValueTopView" owner:nil options:nil] firstObject];
    self.topView = topView;
    topView.frame = CGRectMake(0, 0, topView.frame.size.width, self.view.frame.size.height * 1 / 11);
    [self.scrollViewTop addSubview:topView];
    self.scrollViewTop.contentSize = CGSizeMake(topView.frame.size.width, 0);
    
    UITableView *MValueDataTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, topView.frame.size.width, kScreenHeight - 64 - kScreenHeight * 11 / 120 - 80 - 80) style:UITableViewStylePlain];
    MValueDataTableView.dataSource = self;
    MValueDataTableView.delegate = self;
    MValueDataTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    MValueDataTableView.userInteractionEnabled = NO;
    [MValueDataTableView registerNib:[UINib nibWithNibName:@"EXMValueRightTableViewCell" bundle:nil] forCellReuseIdentifier:MValueCellID];
    MValueDataTableView.scrollEnabled = NO;
    [self.scrollViewRight addSubview:MValueDataTableView];
    self.scrollViewRight.contentSize = CGSizeMake(2021, MValueDataTableView.frame.size.height);
    self.MValueDataTableView = MValueDataTableView;
    self.scrollViewTop.delegate = self;
    self.scrollViewRight.delegate = self;
    self.scrollViewTop.directionalLockEnabled = YES;
    self.scrollViewRight.directionalLockEnabled = YES;
    [self getData];
}

- (void)backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
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


- (void)getData{
    //1.创建会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    //2.根据会话对象创建task
    NSURL *url = [NSURL URLWithString:@"http://113.57.155.226:9631/api/Station/GetStationData"];
    //3.创建可变的请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //4.修改请求方法为POST
    request.HTTPMethod = @"POST";
    //5.设置请求体
    request.HTTPBody = [[NSString stringWithFormat:@"UserId=%@&AccessToken=%@&MenuCode=%@", @"387441b0-177e-4e67-8f9d-c2d0cf194300", [BMAccountManager sharedInstance].loginInfo.AccessToken, @""] dataUsingEncoding:NSUTF8StringEncoding];
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
        NSMutableArray *stationNames = [NSMutableArray arrayWithCapacity:5];
        NSMutableArray *stationIds = [NSMutableArray arrayWithCapacity:5];
        NSArray *tempArray = dict[@"AppendData"];
        for (NSDictionary *tem in tempArray) {
            NSString *stationName = tem[@"StationName"];
            NSString *stationId = tem[@"StationId"];
            [stationNames addObject:stationName];
            [stationIds addObject:stationId];
        }
        self.stationNames = [stationNames copy];
        self.stationIds = [stationIds copy];
        [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
        [self getDetailData];
    }];
    //7.执行任务
    [dataTask resume];
    
}


- (void)getDetailData{
    //1.创建会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    //2.根据会话对象创建task
    NSURL *url = [NSURL URLWithString:@"http://113.57.155.226:9631/api/SalesMSubejct/GetSalesMSubejctData"];
    //3.创建可变的请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //4.修改请求方法为POST
    request.HTTPMethod = @"POST";
    //5.设置请求体
    
    request.HTTPBody = [[NSString stringWithFormat:@"UserId=%@&AccessToken=%@&stationId=%@&Selectmonth=%@&PageIndex=%@&PageSize=%@", @"387441b0-177e-4e67-8f9d-c2d0cf194300", [BMAccountManager sharedInstance].loginInfo.AccessToken, self.stationIds[self.selectIndex], self.timeTextField.text, @"1", @"20"] dataUsingEncoding:NSUTF8StringEncoding];
    //测试
//    request.HTTPBody = [[NSString stringWithFormat:@"UserId=%@&AccessToken=%@&stationId=%@&Selectmonth=%@&PageIndex=%@&PageSize=%@", @"387441b0-177e-4e67-8f9d-c2d0cf194300", [BMAccountManager sharedInstance].loginInfo.AccessToken, self.stationIds[self.selectIndex], @"2016-07-01", @"1", @"20"] dataUsingEncoding:NSUTF8StringEncoding];
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
        id result = dict[@"AppendData"];
        NSMutableArray *tempDataArray = [[NSMutableArray alloc] initWithCapacity:5];
        if ([result isKindOfClass:[NSArray class]]) {
            NSArray *temArray = dict[@"AppendData"];
            for (NSDictionary *temDic in temArray) {
                MValueData *mvalueData = [MValueData mj_objectWithKeyValues:temDic];
                [tempDataArray addObject:mvalueData];
            }
        }
        self.MValueDataArray = [tempDataArray copy];
        [self.MValueDataTableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    }];
    //7.执行任务
    [dataTask resume];
    
}


#pragma mark --- UITableViewDataSource/ UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.MValueDataTableView) {
        self.scrollViewRight.contentSize = CGSizeMake(2021, self.MValueDataArray.count * 60 + 2);
        self.MValueDataTableView.frame = CGRectMake(0, 0, self.MValueDataTableView.frame.size.width, self.MValueDataArray.count * 60);
        return self.MValueDataArray.count;
    }
    if (tableView == self.tableView) {
        return self.stationNames.count;
        
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.MValueDataTableView) {
        EXMValueRightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MValueCellID];
        cell.mvalueData = self.MValueDataArray[indexPath.row];
        return cell;
    }
    if (tableView == self.tableView) {
        static NSString *identifier = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.textLabel.text = self.stationNames[indexPath.row];
        cell.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:228 / 255.0 blue:229 / 255.0 alpha:1];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        if (indexPath.row == 0) {
            NSIndexPath *selectRow = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.tableView selectRowAtIndexPath:selectRow animated:NO scrollPosition:UITableViewScrollPositionNone];
        }
        cell.textLabel.textColor = [UIColor colorWithRed:87 / 255.0 green:84 / 255.0 blue:84/ 255.0 alpha:1];
        cell.selectedTextColor = [UIColor whiteColor];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:188 / 255.0 green:185 / 255.0 blue:188 / 255.0 alpha:1];
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _X = 0;
    _Y = 0;
    self.selectIndex = indexPath.row;
    [self getDetailData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.MValueDataTableView) {
        return 60;
    }
    return 60;
}

#pragma mark --- UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.scrollViewRight) {
        self.X = scrollView.contentOffset.x;
        self.Y = scrollView.contentOffset.y;
        self.scrollViewTop.contentOffset =  CGPointMake(self.X, self.scrollViewTop.contentOffset.y);
    }
    if (scrollView == self.scrollViewTop) {
        self.X = scrollView.contentOffset.x;
        self.scrollViewRight.contentOffset = CGPointMake(self.X, self.Y);
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
