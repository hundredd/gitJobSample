//
//  EXVehicleTransportRightTableViewCell.m
//  Charts
//
//  Created by Eleven on 16/9/3.
//  Copyright © 2016年 Eleven. All rights reserved.
//

#import "EXVehicleTransportRightTableViewCell.h"

@interface EXVehicleTransportRightTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *tranListIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *projectNamelabel;
@property (weak, nonatomic) IBOutlet UILabel *unitNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *particularPartLabel;
@property (weak, nonatomic) IBOutlet UILabel *plyPlanLabel;
@property (weak, nonatomic) IBOutlet UILabel *productGradeLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *insideVehicleNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *motormanLabel;
@property (weak, nonatomic) IBOutlet UILabel *sendDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *leaveFacTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *arriveBSTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstXLTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastXLTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *leaveBSTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *returnFacTimeLabel;

@end

@implementation EXVehicleTransportRightTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setVehicleTransportData:(EXVehicleTransportData *)vehicleTransportData{
    _vehicleTransportData = vehicleTransportData;
    _tranListIDLabel.text = vehicleTransportData.TranListID;
    _projectNamelabel.text = vehicleTransportData.ProjectName;
    _unitNameLabel.text = vehicleTransportData.UnitName;
    _particularPartLabel.text = vehicleTransportData.ParticularPart;
    _plyPlanLabel.text = vehicleTransportData.PlyPlan;
    _productGradeLabel.text = vehicleTransportData.ProductGrade;
    _numberLabel.text = vehicleTransportData.Number;
    _insideVehicleNoLabel.text = vehicleTransportData.InsideVehicleNo;
    _motormanLabel.text = vehicleTransportData.Motorman;
    _sendDateLabel.text = vehicleTransportData.SendDate;
    _leaveFacTimeLabel.text = vehicleTransportData.LeaveFacTime;
    _arriveBSTimeLabel.text = vehicleTransportData.ArriveBSTime;
    _firstXLTimeLabel.text = vehicleTransportData.FirstXLTime;
    _lastXLTimeLabel.text = vehicleTransportData.LastXLTime;
    _leaveBSTimeLabel.text = vehicleTransportData.leaveBSTime;
    _returnFacTimeLabel.text = vehicleTransportData.ReturnFacTime;
}
@end
