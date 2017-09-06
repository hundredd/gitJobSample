//
//  EXAddItemViewController.m
//  Charts
//
//  Created by Eleven on 16/9/19.
//  Copyright © 2016年 Eleven. All rights reserved.
//

#import "EXAddItemViewController.h"

@interface EXAddItemViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *array;
@property (nonatomic, strong) NSDictionary *dataDic;
@property (nonatomic, strong) NSMutableArray *addItemArray;
@property (assign, nonatomic) NSInteger index;
@end

@implementation EXAddItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.title = @"添加";
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = leftItem;
    [self getData];

}
- (NSMutableArray *)addItemArray{
    if (!_addItemArray) {
        _addItemArray = [[NSMutableArray alloc] initWithCapacity:5];
    }
    return _addItemArray;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.dataBlock != nil) {
        self.dataBlock(self.dataDic);
    }
}

- (void)feedbackData:(AddDataBlock)block{
    self.dataBlock = block;
}

- (void)getData{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"MValue" ofType:@"plist"];
    NSArray *array = [[NSArray alloc] initWithContentsOfFile:filePath];
    self.array = array;
    self.index = -1;
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark --- UITableViewDataSource/UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cells";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = self.array[indexPath.row];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSArray *tempArray = [userDefault objectForKey:@"addItemArray"];
    self.addItemArray = [NSMutableArray arrayWithArray:tempArray];
    for (int i = 0; i < self.addItemArray.count; i++) {
        NSInteger flag = [self.addItemArray[i] integerValue];
        if (indexPath.row == flag) {
            cell.detailTextLabel.text = @"已添加";
            cell.userInteractionEnabled = NO;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //获取选择站点数据
    NSString *item = self.array[indexPath.row];
    self.index = indexPath.row;
    self.dataDic = @{
                     @"item" : item,
                     @"index" : @(self.index)
                     };
    [self.addItemArray addObject:@(self.index)];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:self.addItemArray forKey:@"addItemArray"];
    [tableView reloadData];
    [self backAction];
    
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
