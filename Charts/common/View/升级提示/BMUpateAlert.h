//
//  BMUpateAlert.h
//  特种车调度
//
//  Created by 韩学鹏 on 16/3/24.
//
//

#import "JCRBlurView.h"

@interface BMUpateAlert : JCRBlurView

@property (nonatomic, strong) BMUpateModel *updateInfo;

- (void)show;

- (void)dismiss;

@end
