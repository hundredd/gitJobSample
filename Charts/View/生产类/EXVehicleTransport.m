//
//  EXVehicleTransport.m
//  Charts
//
//  Created by Eleven on 16/8/18.
//  Copyright © 2016年 Eleven. All rights reserved.
//

#import "EXVehicleTransport.h"
#import "EXVehicleTransportData.h"
#import "EXVehicleTransportRightTableViewCell.h"
@interface EXVehicleTransport () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *projectTextField;
@property (weak, nonatomic) IBOutlet UITextField *userTextField;
@property (weak, nonatomic) IBOutlet UITextField *numberTextField;
@property (weak, nonatomic) IBOutlet UITextField *driverTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIScrollView *topScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *bottomScrollView;
@property (assign, nonatomic) CGFloat X;
@property (assign, nonatomic) CGFloat Y;
@property (weak, nonatomic) IBOutlet UITextField *startTimeTextField;
@property (weak, nonatomic) IBOutlet UITextField *endTimeTextField;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) UITableView *vehicleTransportTableView;
@property (assign, nonatomic) NSInteger selectIndex;
/**
 *  用于存储站点名
 */
@property (nonatomic, strong) NSArray *stationNames;

/**
 *  用于存储站点id
 */
@property (nonatomic, strong) NSArray *stationIds;
@property (nonatomic, strong) NSArray *vehicleTransportData;

- (IBAction)searchAction:(UIButton *)sender;

#pragma mark - 时间选择器
@property (nonatomic, weak) UIDatePicker *datePickerView;

@end

@implementation EXVehicleTransport

static NSString *reuseIdenti = @"reuseCellId";
- (void)awakeFromNib{
    //上部视图
    UIView *topView = [[[NSBundle mainBundle] loadNibNamed:@"EXVehicleTransportRightView" owner:nil options:nil] firstObject];
    topView.frame = CGRectMake(0, 0, topView.frame.size.width, self.topScrollView.frame.size.height);
    [self.topScrollView addSubview:topView];
    self.topScrollView.contentSize = CGSizeMake(topView.frame.size.width, 0);

    _X = 0;
    _Y = 0;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.projectTextField.delegate = self;
    self.userTextField.delegate = self;
    self.numberTextField.delegate = self;
    self.driverTextField.delegate = self;
    self.topScrollView.delegate = self;
    self.bottomScrollView.delegate = self;
    [self getStationData];
    [self datePicker];
    self.selectIndex = 0;
    //创建tableView显示数据
    UITableView *vehicleTransportTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, topView.frame.size.width, kScreenHeight - 64 - kScreenHeight * 1 / 15 - 80 - 80) style:UITableViewStylePlain];
    vehicleTransportTableView.dataSource = self;
    vehicleTransportTableView.delegate = self;
    vehicleTransportTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    vehicleTransportTableView.userInteractionEnabled = NO;
    [vehicleTransportTableView registerNib:[UINib nibWithNibName:@"EXVehicleTransportRightTableViewCell" bundle:nil] forCellReuseIdentifier:reuseIdenti];
    vehicleTransportTableView.scrollEnabled = NO;
    [self.bottomScrollView addSubview:vehicleTransportTableView];
    self.bottomScrollView.contentSize = CGSizeMake(1816, vehicleTransportTableView.frame.size.height);
    self.vehicleTransportTableView = vehicleTransportTableView;
    self.topScrollView.delegate = self;
    self.bottomScrollView.delegate = self;
    self.topScrollView.directionalLockEnabled = YES;
    self.bottomScrollView.directionalLockEnabled = YES;
    self.searchButton.backgroundColor = [UIColor colorWithRed:162 / 255.0 green:161 / 255.0 blue:169 / 255.0 alpha:1];
    [self.searchButton addTarget:self action:@selector(hilightedBackgroundColor:) forControlEvents:UIControlEventTouchDown];
}

- (void)datePicker{
    self.startTimeTextField.delegate = self;
    self.endTimeTextField.delegate = self;
    UIDatePicker *dateInputView = [[UIDatePicker alloc] init];
    dateInputView.datePickerMode = UIDatePickerModeDate;
    dateInputView.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    self.startTimeTextField.inputView = dateInputView;
    self.startTimeTextField.inputAccessoryView = [[[NSBundle mainBundle] loadNibNamed:@"InputToolbar" owner:self options:nil] firstObject];
    self.endTimeTextField.inputView = dateInputView;
    self.endTimeTextField.inputAccessoryView = [[[NSBundle mainBundle] loadNibNamed:@"InputToolbar" owner:self options:nil] firstObject];
    self.datePickerView = dateInputView;
}

- (void)hilightedBackgroundColor:(UIButton *)sender{
    sender.backgroundColor = [UIColor colorWithRed:142 / 255.0 green:142 / 255.0 blue:142 / 255.0 alpha:1];
}

- (IBAction)toolbarCancle:(id)sender {
    [self.startTimeTextField resignFirstResponder];
    [self.endTimeTextField resignFirstResponder];
}

- (IBAction)toolbarOK:(id)sender {
    NSDate *date = self.datePickerView.date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    if (self.startTimeTextField.isFirstResponder) {
        self.startTimeTextField.text = dateString;
        [self.startTimeTextField resignFirstResponder];
    }
    if (self.endTimeTextField.isFirstResponder) {
        self.endTimeTextField.text = dateString;
        [self.endTimeTextField resignFirstResponder];
    }
}


- (void)getStationData{
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
    }];
    //7.执行任务
    [dataTask resume];
}

- (void)getDetailData{
    //1.创建会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    //2.根据会话对象创建task
    NSURL *url = [NSURL URLWithString:@"http://113.57.155.226:9631/api/VehicleTransport/GetVehicleTransportData"];
    //3.创建可变的请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //4.修改请求方法为POST
    request.HTTPMethod = @"POST";
    //5.设置请求体
    //    request.HTTPBody = [@"UserId=387441b0-177e-4e67-8f9d-c2d0cf194300&AccessToken=Mzg3NDQxYjAtMTc3ZS00ZTY3LThmOWQtYzJkMGNmMTk0MzAwJDIwMTYvOC8zMSAxNjoyNzo1NA==&stationId=" dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody = [[NSString stringWithFormat:@"UserId=%@&AccessToken=%@&stationId=%@&ProjectName=%@&UnitName=%@&InsideVehicleNo=%@&Motorman=%@&BeginDate=%@&EndDate=%@&PageIndex=%@&PageSize=%@", @"387441b0-177e-4e67-8f9d-c2d0cf194300", [BMAccountManager sharedInstance].loginInfo.AccessToken, self.stationIds[self.selectIndex], self.projectTextField.text, self.userTextField.text, self.numberTextField.text, self.driverTextField.text, self.startTimeTextField.text, self.endTimeTextField.text, @"1", @"30"] dataUsingEncoding:NSUTF8StringEncoding];
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
                EXVehicleTransportData *vehicleTransportData = [EXVehicleTransportData mj_objectWithKeyValues:temDic];
                [tempDataArray addObject:vehicleTransportData];
            }
        }
        self.vehicleTransportData = [tempDataArray copy];
//        [self performSelectorOnMainThread:@selector(loadRightData) withObject:nil waitUntilDone:YES];
        [self.vehicleTransportTableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    }];
    //7.执行任务
    [dataTask resume];

}


#pragma mark --- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.bottomScrollView) {
        self.X = scrollView.contentOffset.x;
        self.Y = scrollView.contentOffset.y;
        self.topScrollView.contentOffset =  CGPointMake(self.X, self.topScrollView.contentOffset.y);
    }
    if (scrollView == self.topScrollView) {
        self.X = scrollView.contentOffset.x;
        self.bottomScrollView.contentOffset = CGPointMake(self.X, self.Y);
    }
}



#pragma mark --- UITableViewDataSource/ UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.tableView) {
        return self.stationNames.count;
    }
    if (tableView == self.vehicleTransportTableView) {
        self.bottomScrollView.contentSize = CGSizeMake(1816, self.vehicleTransportData.count * 60 + 2);
        self.vehicleTransportTableView.frame = CGRectMake(0, 0, self.vehicleTransportTableView.frame.size.width, self.vehicleTransportData.count * 60);
        return self.vehicleTransportData.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.tableView) {
        static NSString *identifier = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.textLabel.text = self.stationNames[indexPath.row];
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:228 / 255.0 blue:229 / 255.0 alpha:1];
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:188 / 255.0 green:185 / 255.0 blue:188 / 255.0 alpha:1];
        cell.textLabel.textColor = [UIColor colorWithRed:87 / 255.0 green:84 / 255.0 blue:84/ 255.0 alpha:1];
        cell.selectedTextColor = [UIColor whiteColor];
        if (indexPath.row == 0) {
            NSIndexPath *selectRow = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.tableView selectRowAtIndexPath:selectRow animated:NO scrollPosition:UITableViewScrollPositionNone];
        }

        return cell;
    }
    
    if (tableView == self.vehicleTransportTableView) {
        EXVehicleTransportRightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdenti];
        cell.vehicleTransportData = self.vehicleTransportData[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
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
    if (tableView == self.vehicleTransportTableView) {
        return 60;
    }
    return 60;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)searchAction:(UIButton *)sender {
    sender.backgroundColor = [UIColor colorWithRed:162 / 255.0 green:161 / 255.0 blue:169 / 255.0 alpha:1];
    [self getDetailData];
}
@end
