//
//  EXSignalTableViewCell.m
//  Charts
//
//  Created by Eleven on 16/9/19.
//  Copyright © 2016年 Eleven. All rights reserved.
//

#import "EXSignalTableViewCell.h"

@interface EXSignalTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *dataLabel;

@end
@implementation EXSignalTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataText:(NSString *)dataText{
    _dataText = dataText;
    self.dataLabel.text = dataText;
}

@end
