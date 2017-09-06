//
//  BMUpateModel.h
//  特种车调度
//
//  Created by 韩学鹏 on 16/4/20.
//
//

#import <BM4Group/BM4Group.h>

@interface BMUpateModel : BMBaseModel

@property (nonatomic, copy) NSString *content;

@property (nonatomic, assign)NSInteger forceUpdate;

@property (nonatomic, copy) NSString *platform;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, assign) NSInteger versionCode;

@property (nonatomic, copy) NSString *versionUrl;

@end
