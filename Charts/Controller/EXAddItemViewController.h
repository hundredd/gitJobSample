//
//  EXAddItemViewController.h
//  Charts
//
//  Created by Eleven on 16/9/19.
//  Copyright © 2016年 Eleven. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^AddDataBlock) (NSDictionary *dic);
@interface EXAddItemViewController : UIViewController
@property (assign, nonatomic) NSInteger type;
@property (nonatomic, copy) AddDataBlock dataBlock;
- (void)feedbackData:(AddDataBlock)block;
@end
