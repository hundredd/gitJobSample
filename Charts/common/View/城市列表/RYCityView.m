//
//  RYCityView.m
//  特种车调度
//
//  Created by 韩学鹏 on 16/3/23.
//
//

#import "RYCityView.h"
#import "BMCity.h"
#import "RYCityItemCell.h"

@implementation City

- (NSString *)address
{
    return [NSString stringWithFormat:@"%@%@%@", _province, _city, _district?_district:@""];
}

@end


@interface RYCityView () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *provincesTableView;
@property (weak, nonatomic) IBOutlet UITableView *citiesTableView;
@property (weak, nonatomic) IBOutlet UITableView *districtsTableView;

@property (nonatomic, strong) NSArray *allProvinces;
@property (nonatomic, strong) NSArray *allCities;
@property (nonatomic, strong) NSArray *allDistricts;


@property (nonatomic, assign) NSInteger provinceIndex;
@property (nonatomic, assign) NSInteger cityIndex;
@property (nonatomic, assign) NSInteger districtIndex;

@end

@implementation RYCityView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"areas" ofType:@"plist"];
        self.allProvinces = [BMCity mj_objectArrayWithFile:path];
        
        self.allCities = [self.allProvinces.firstObject nextArea];
        self.allDistricts = [self.allCities.firstObject nextArea];
    }
    
    return self;
}

- (void)awakeFromNib
{
    [self loadCityData];
}

- (void)setCurrentCityName:(NSString *)currentCityName
{
    _currentCityName = currentCityName;
    
    NSInteger provinceIndex = 0;
    NSInteger cityIndex = 0;
    [self getCurrentCityProvinceIndex:&provinceIndex cityIndex:&cityIndex currentName:currentCityName];
    self.provinceIndex = provinceIndex;
    self.cityIndex = cityIndex;
    
    self.allCities = [self.allProvinces[provinceIndex] nextArea];
    self.allDistricts = [self.allCities[cityIndex] nextArea];
    
    [self.provincesTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:provinceIndex inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    [self.citiesTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:cityIndex inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    
    [self.provincesTableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];
    [self.citiesTableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];
    BMLog(@"%s", __func__);
    
}

- (void)getCurrentCityProvinceIndex:(NSInteger *)provinceIndex cityIndex:(NSInteger*)cityIndex currentName:(NSString *)curName
{
    for (int i=0; i<self.allProvinces.count; i++) {
        NSArray *cities = [self.allProvinces[i] nextArea];
        for (int n=0; n<cities.count; n++) {
            BMCity *city = cities[n];
            if ([curName isEqualToString:city.name]) {
                *provinceIndex = i;
                *cityIndex = n;
            }
        }
    }
}

- (void)loadCityData
{
    
    UINib *nib = [UINib nibWithNibName:@"RYCityItemCell" bundle:nil];
    [self.provincesTableView registerNib:nib forCellReuseIdentifier:reuseIdentifier];
    UINib *nib1 = [UINib nibWithNibName:@"RYCityItemCell" bundle:nil];
    [self.citiesTableView registerNib:nib1 forCellReuseIdentifier:reuseIdentifier];
    UINib *nib2 = [UINib nibWithNibName:@"RYCityItemCell" bundle:nil];
    [self.districtsTableView registerNib:nib2 forCellReuseIdentifier:reuseIdentifier];
    
    self.provincesTableView.delegate = self;
    self.provincesTableView.dataSource = self;
    self.citiesTableView.delegate = self;
    self.citiesTableView.dataSource = self;
    self.districtsTableView.delegate = self;
    self.districtsTableView.dataSource = self;
    
    UIView *footView0 = [UIView new];
    footView0.backgroundColor = [UIColor clearColor];
    
    
    [self.provincesTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismiss];
}

- (void)showOn:(UIView *)view
{
    [view addSubview:self];
}

- (void)dismiss
{
    [self removeFromSuperview];
}


#pragma mark - UITableViewDataSource, UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    return view;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.provincesTableView) {
        self.provinceIndex = indexPath.row;
        self.allCities = [self.allProvinces[indexPath.row] nextArea];
        [self.citiesTableView reloadData];
        self.allDistricts = nil;
        [self.districtsTableView reloadData];
    }else if (tableView == self.citiesTableView) {
        self.cityIndex = indexPath.row;
        self.allDistricts = [self.allCities[indexPath.row] nextArea];
        [self.districtsTableView reloadData];
        if (_allDistricts.count<=0) {
            [self selectCity];
        }
    }else if (tableView == self.districtsTableView) {
        self.districtIndex = indexPath.row;
        [self selectCity];
    }
    
}

- (void)selectCity
{
    if (self.delegate && [self.delegate respondsToSelector:NSSelectorFromString(@"onView:didSelect:")]) {
        City *city = [City new];
        BMCity *bmCity = _allProvinces[_provinceIndex];
        city.province = bmCity.name;
        bmCity = _allCities[_cityIndex];
        city.city = bmCity.name;
        bmCity = _allDistricts[_districtIndex];
        city.district = bmCity.name;
        if (!city.district) {
            city.district = city.city;
        }
        [self.delegate onView:self didSelect:city];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger number = 0;
    if (tableView == self.provincesTableView) {
        number = self.allProvinces.count;
    }else if (tableView == self.citiesTableView) {
        number = self.allCities.count;
    }else if (tableView == self.districtsTableView) {
        number = self.allDistricts.count;
    }
    
    return number;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RYCityItemCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (tableView == self.provincesTableView) {
        cell.city = self.allProvinces[indexPath.row];
        cell.type = 0;
    }else if (tableView == self.citiesTableView) {
        cell.city = self.allCities[indexPath.row];
        cell.type = 1;
    }else if (tableView == self.districtsTableView) {
        cell.city = self.allDistricts[indexPath.row];
        cell.type = 2;
    }
    return cell;
}

@end
