//
//  RYCityItemCell.h
//  特种车调度
//
//  Created by 韩学鹏 on 16/3/23.
//
//

#import <UIKit/UIKit.h>
#import "BMCity.h"

@interface RYCityItemCell : UITableViewCell

@property (nonatomic, assign) NSInteger type;  //0: 第一个  1:第二个  2:第三个

@property (nonatomic, assign) BOOL hasNextLevel;

@property (nonatomic, strong) BMCity *city;

@end
