//
//  EXAddViewController.h
//  Charts
//
//  Created by Eleven on 16/8/15.
//  Copyright © 2016年 Eleven. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^AddDataBlock) (NSDictionary *dic);

@interface EXAddViewController : UIViewController

@property (nonatomic, copy) AddDataBlock dataBlock;

- (void)feedbackData:(AddDataBlock)block;

@end
