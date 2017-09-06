//
//  EXMValue_changeViewController.m
//  Charts
//
//  Created by Eleven on 16/9/18.
//  Copyright © 2016年 Eleven. All rights reserved.
//

#import "EXMValue_changeViewController.h"
#import "MValueData.h"
#import "EXAddItemViewController.h"
#import "EXMValueAdd.h"
#import "EXSignalTableViewCell.h"
@interface EXMValue_changeViewController () <UIScrollViewDelegate, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIScrollView *topScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *bottomScrollView;
@property (weak, nonatomic) IBOutlet UITextField *timeTextField;
@property (weak, nonatomic) UIView *topAddView;
@property (weak, nonatomic) UIView *topItemView;
@property (assign, nonatomic) NSInteger count;
@property (nonatomic, strong) NSArray *MValueDataArray;
@property (assign, nonatomic) CGFloat X;
@property (assign, nonatomic) CGFloat Y;
@property (weak, nonatomic) UITableView *reuseTableView;
@property (strong, nonatomic) NSDictionary *dataDic;
@property (strong, nonatomic) NSMutableArray *addItemArray;
@property (strong, nonatomic) NSMutableArray *addDataArray;
@property (strong, nonatomic) NSMutableArray *indexOfCellArray;
@property (strong, nonatomic) NSMutableArray *addDataMutableArray;
@property (strong, nonatomic) NSMutableArray *tableViewArray;
@property (weak, nonatomic) UITableView *tableView0;
@property (weak, nonatomic) UITableView *tableView1;
@property (weak, nonatomic) UITableView *tableView2;
@property (weak, nonatomic) UITableView *tableView3;
@property (weak, nonatomic) UITableView *tableView4;
@property (weak, nonatomic) UITableView *tableView5;
@property (weak, nonatomic) UITableView *tableView6;
@property (weak, nonatomic) UITableView *tableView7;
@property (weak, nonatomic) UITableView *tableView8;
@property (weak, nonatomic) UITableView *tableView9;
@property (weak, nonatomic) UITableView *tableView10;
@property (weak, nonatomic) UITableView *tableView11;
@property (weak, nonatomic) UITableView *tableView12;
@property (weak, nonatomic) UITableView *tableView13;
@property (weak, nonatomic) UITableView *tableView14;
@property (weak, nonatomic) UITableView *tableView15;
@property (weak, nonatomic) UITableView *tableView16;
@property (weak, nonatomic) UITableView *tableView17;
@property (weak, nonatomic) UITableView *tableView18;
@property (weak, nonatomic) UITableView *tableView19;
@property (assign, nonatomic) NSInteger indexOfCell;
@property (assign, nonatomic) NSInteger removeIndex;
@property (assign, nonatomic) NSInteger flag;
/**
 *  用于存储站点名
 */
@property (nonatomic, strong) NSArray *stationNames;

/**
 *  用于存储站点id
 */
@property (nonatomic, strong) NSArray *stationIds;
@property (assign, nonatomic) NSInteger selectIndex;
#pragma mark - 时间选择器
@property (nonatomic, weak) UIDatePicker *datePickerView;
@end

@implementation EXMValue_changeViewController

static NSString *cellReusefor = @"cellReusefor";
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"项目M值";
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.topScrollView.delegate = self;
    self.bottomScrollView.delegate = self;
    _X = 0;
    _Y = 0;
    self.selectIndex = 0;
    self.count = 0;
    self.flag = 0;
    [self configuration];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.dataDic != nil) {
        [self refreshUI];
        [self changeViewAction];
        
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
    UIView *topAddView = [[[NSBundle mainBundle] loadNibNamed:@"MValueAdd" owner:nil options:nil] firstObject];
    topAddView.frame = CGRectMake(0, 0, 140, self.view.frame.size.height * 1 / 11);
    topAddView.tag = 999;
    self.topAddView = topAddView;
    [self.topScrollView addSubview:topAddView];
    [self getData];
    self.addItemArray = [[NSMutableArray alloc] initWithCapacity:5];
    self.addDataArray = [[NSMutableArray alloc] initWithCapacity:5];
    self.addDataMutableArray = [[NSMutableArray alloc] initWithCapacity:5];
    self.indexOfCellArray = [[NSMutableArray alloc] initWithCapacity:5];
    self.tableViewArray = [[NSMutableArray alloc] initWithCapacity:5];
}

- (void)changeViewAction{
    
    //添加右边视图
    //创建tableView
    UITableView *reuseTableView = [[UITableView alloc] initWithFrame:CGRectMake(120 * self.count , 0,120, self.MValueDataArray.count * 60) style:UITableViewStylePlain];
    [reuseTableView registerNib:[UINib nibWithNibName:@"EXSignalTableViewCell" bundle:nil] forCellReuseIdentifier:cellReusefor];
    reuseTableView.dataSource = self;
    reuseTableView.delegate = self;
    reuseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    reuseTableView.userInteractionEnabled = NO;
    reuseTableView.scrollEnabled = NO;
    reuseTableView.tag = self.count;

    [self.bottomScrollView addSubview:reuseTableView];
    self.reuseTableView = reuseTableView;
    [self.reuseTableView reloadData];
    [self.tableViewArray addObject:self.reuseTableView];
    self.bottomScrollView.contentSize = CGSizeMake(120 * (self.count + 1), self.MValueDataArray.count * 60);
    
    //添加上部视图
    EXMValueAdd *topItemView = [[[NSBundle mainBundle] loadNibNamed:@"MValueAdd" owner:nil options:nil] lastObject];
    topItemView.itemLabel.text = self.addItemArray[self.count];
    topItemView.tag = self.count;
    topItemView.frame = CGRectMake(topItemView.tag * 120, 0, 120, self.view.frame.size.height * 1 / 11);
    [self.topScrollView addSubview:topItemView];
    self.topItemView = topItemView;
    self.topAddView.frame = CGRectMake((self.count + 1)* 120, 0, 120, self.view.frame.size.height * 1 / 11);
    self.topScrollView.contentSize = CGSizeMake((self.count + 2) * 120, 0);
    self.count ++;
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

- (IBAction)MValueAddAction:(id)sender{
    if (self.MValueDataArray.count == 0) {
        [self showHint:@"当前无数据"];
        return;
    }
    EXAddItemViewController *addItemVC = [[UIStoryboard storyboardWithName:@"AddItem" bundle:nil] instantiateInitialViewController];
    [addItemVC feedbackData:^(NSDictionary *dic) {
        self.dataDic = dic;
        if (self.dataDic != nil) {
            NSString *itemName = self.dataDic[@"item"];
            [self.addItemArray addObject:itemName];
            self.indexOfCell = [self.dataDic[@"index"] integerValue];
            [self.indexOfCellArray addObject:@(self.indexOfCell)];
        }
    }];
    [self.navigationController showViewController:addItemVC sender:nil];
}

- (IBAction)MValueRmoveAction:(UIButton *)sender{
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
                    topItemView.frame = CGRectMake((topItemView.tag - 1) * 120, 0, 120, self.view.frame.size.height * 1 / 11);
                    topItemView.tag--;
                }
            }
            break;
        }
    }
    for (UITableView *tableView in self.bottomScrollView.subviews) {
        if (tableView.tag == self.removeIndex) {
            [tableView removeFromSuperview];
            for (UITableView *tableView in self.bottomScrollView.subviews) {
                if (tableView.tag > self.removeIndex) {
                    tableView.frame = CGRectMake(120 * (tableView.tag - 1), 0, 120, tableView.frame.size.height);
                    tableView.tag--;
                    self.reuseTableView = tableView;
                }
                
            }
            break;
        }
        
    }
    self.count--;
    self.topAddView.frame = CGRectMake((self.count) * 120, 0, 120, self.view.frame.size.height * 1 / 11);
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
        [tempDataArray removeAllObjects];
        if ([result isKindOfClass:[NSArray class]]) {
            NSArray *temArray = dict[@"AppendData"];
            for (NSDictionary *temDic in temArray) {
                MValueData *mvalueData = [MValueData mj_objectWithKeyValues:temDic];
                [tempDataArray addObject:mvalueData];
            }
        }
        self.MValueDataArray = [tempDataArray copy];
        if (self.topScrollView.subviews.count > 1) {
            [self performSelectorOnMainThread:@selector(changeStationAction) withObject:nil waitUntilDone:YES];
        }
    }];
    //7.执行任务
    [dataTask resume];
}

- (void)refreshUI{
    for (MValueData *mvalueData in self.MValueDataArray) {
        
        if (self.indexOfCell == 0) {
            NSString *data = mvalueData.HandleDate;
            [self.addDataArray addObject:data];
            break;
        }
        if (self.indexOfCell == 1) {
            NSString *data = mvalueData.SubjectNumber;
            [self.addDataArray addObject:data];
            break;
        }
        if (self.indexOfCell == 2) {
            NSString *data = mvalueData.SubjectName;
            [self.addDataArray addObject:data];
            break;
        }
        if (self.indexOfCell == 3) {
            NSString *data = mvalueData.PayUnit;
            [self.addDataArray addObject:data];
            break;
        }
        if (self.indexOfCell == 4) {
            NSString *data = mvalueData.DutyMan;
            [self.addDataArray addObject:data];
            break;
        }
        if (self.indexOfCell == 5) {
            NSString *data = mvalueData.ProductNumber;
            [self.addDataArray addObject:data];
            break;
        }
        if (self.indexOfCell == 6) {
            NSString *data = mvalueData.ProductValue;
            [self.addDataArray addObject:data];
            break;
        }
        if (self.indexOfCell == 7) {
            NSString *data = mvalueData.MaterialCost;
            [self.addDataArray addObject:data];
            break;
        }
        if (self.indexOfCell == 8) {
            NSString *data = mvalueData.BusinessPushMoney;
            [self.addDataArray addObject:data];
            break;
        }
        if (self.indexOfCell == 9) {
            NSString *data = mvalueData.CustomerServiceCost;
            [self.addDataArray addObject:data];
            break;
        }
        if (self.indexOfCell == 10) {
            NSString *data = mvalueData.BetweenCost;
            [self.addDataArray addObject:data];
            break;
        }
        if (self.indexOfCell == 11) {
            NSString *data = mvalueData.TaxMoney;
            [self.addDataArray addObject:data];
            break;
        }
        if (self.indexOfCell == 12) {
            NSString *data = mvalueData.Transportcost;
            [self.addDataArray addObject:data];
            break;
        }
        if (self.indexOfCell == 13) {
            NSString *data = mvalueData.JumpCost;
            [self.addDataArray addObject:data];
            break;
        }
        if (self.indexOfCell == 14) {
            NSString *data = mvalueData.FinanceCost;
            [self.addDataArray addObject:data];
            break;
        }
        if (self.indexOfCell == 15) {
            NSString *data = mvalueData.StationShare;
            [self.addDataArray addObject:data];
            break;
        }
        if (self.indexOfCell == 16) {
            NSString *data = mvalueData.GroupShare;
            [self.addDataArray addObject:data];
            break;
        }
        if (self.indexOfCell == 17) {
            NSString *data = mvalueData.BaseHvalue;
            [self.addDataArray addObject:data];
            break;
        }
        if (self.indexOfCell == 18) {
            NSString *data = mvalueData.CurrentMvalue;
            [self.addDataArray addObject:data];
            break;
        }
        if (self.indexOfCell == 19) {
            NSString *data = mvalueData.LastedMvalue;
            [self.addDataArray addObject:data];
            break;
        }

    }
}



- (void)changeStationAction{
//    [self.bottomScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.addDataArray removeAllObjects];
    for (NSString *indexStr in self.indexOfCellArray) {
        self.indexOfCell = [indexStr integerValue];
        [self refreshUI];
    }
    [self refreshBottomUI];
}

- (void)refreshBottomUI{
    for (UITableView *reuseTableView in self.tableViewArray) {
        if (reuseTableView.tag == 0) {
            self.tableView0 = reuseTableView;
            [self.tableView0 reloadData];
        }
        if (reuseTableView.tag == 1) {
            self.tableView1 = reuseTableView;
            [self.tableView1 reloadData];
        }
        if (reuseTableView.tag == 2) {
            self.tableView2 = reuseTableView;
            [self.tableView2 reloadData];
        }
        if (reuseTableView.tag == 3) {
            self.tableView3 = reuseTableView;
            [self.tableView3 reloadData];
        }
        if (reuseTableView.tag == 4) {
            self.tableView4 = reuseTableView;
            [self.tableView4 reloadData];
        }
        if (reuseTableView.tag == 5) {
            self.tableView5 = reuseTableView;
            [self.tableView5 reloadData];
        }
        if (reuseTableView.tag == 6) {
            self.tableView6 = reuseTableView;
            [self.tableView6 reloadData];
        }
        if (reuseTableView.tag == 7) {
            self.tableView7 = reuseTableView;
            [self.tableView7 reloadData];
        }
        if (reuseTableView.tag == 8) {
            self.tableView8 = reuseTableView;
            [self.tableView8 reloadData];
        }
        if (reuseTableView.tag == 9) {
            self.tableView9 = reuseTableView;
            [self.tableView9 reloadData];
        }
        if (reuseTableView.tag == 10) {
            self.tableView10 = reuseTableView;
            [self.tableView10 reloadData];
        }
        if (reuseTableView.tag == 11) {
            self.tableView11 = reuseTableView;
            [self.tableView11 reloadData];
        }
        if (reuseTableView.tag == 12) {
            self.tableView12 = reuseTableView;
            [self.tableView12 reloadData];
        }
        if (reuseTableView.tag == 13) {
            self.tableView13 = reuseTableView;
            [self.tableView13 reloadData];
        }
        if (reuseTableView.tag == 14) {
            self.tableView14 = reuseTableView;
            [self.tableView14 reloadData];
        }
        if (reuseTableView.tag == 15) {
            self.tableView15 = reuseTableView;
            [self.tableView15 reloadData];
        }
        if (reuseTableView.tag == 16) {
            self.tableView16 = reuseTableView;
            [self.tableView16 reloadData];
        }
        if (reuseTableView.tag == 17) {
            self.tableView17 = reuseTableView;
            [self.tableView17 reloadData];
        }
        if (reuseTableView.tag == 18) {
            self.tableView18 = reuseTableView;
            [self.tableView18 reloadData];
        }
        if (reuseTableView.tag == 19) {
            self.tableView19 = reuseTableView;
            [self.tableView19 reloadData];
        }

    }
}

- (void)addBottomUI{
    UITableView *reuseTableView = [[UITableView alloc] initWithFrame:CGRectMake(120 * self.count , 0,120, self.MValueDataArray.count * 60) style:UITableViewStylePlain];
    [reuseTableView registerNib:[UINib nibWithNibName:@"EXSignalTableViewCell" bundle:nil] forCellReuseIdentifier:cellReusefor];
    reuseTableView.dataSource = self;
    reuseTableView.delegate = self;
    reuseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    reuseTableView.userInteractionEnabled = NO;
    reuseTableView.scrollEnabled = NO;
    reuseTableView.tag = self.count;
    
    [self.bottomScrollView addSubview:reuseTableView];
    self.reuseTableView = reuseTableView;
    [self.reuseTableView reloadData];
    [self.tableViewArray addObject:self.reuseTableView];
    self.bottomScrollView.contentSize = CGSizeMake(120 * (self.count + 1), self.MValueDataArray.count * 60);
    self.count++;
}

#pragma mark --- UITableViewDataSource/ UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if (tableView == self.reuseTableView) {
//        return self.MValueDataArray.count;
//    }
//    if (tableView == self.tableView0) {
//        return self.MValueDataArray.count;
//    }
//    if (tableView == self.tableView1) {
//        return self.MValueDataArray.count;
//    }
    if (tableView == self.tableView) {
        return self.stationNames.count;
    }else{
        return self.MValueDataArray.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if (tableView == self.reuseTableView) {
//        EXSignalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReusefor];
//        cell.dataText = self.addDataArray[self.reuseTableView.tag];
//        return cell;
//    }
//    if (tableView == self.tableView0) {
//        EXSignalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReusefor];
//        cell.dataText = self.addDataArray[tableView.tag];
//        return cell;
//    }
//    if (tableView == self.tableView1) {
//        EXSignalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReusefor];
//        cell.dataText = self.addDataArray[tableView.tag];
//        return cell;
//    }
    
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
        }else{
            EXSignalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReusefor];
            cell.dataText = self.addDataArray[tableView.tag];
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
    if (tableView == self.reuseTableView) {
        return 60;
    }
    return 60;
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
