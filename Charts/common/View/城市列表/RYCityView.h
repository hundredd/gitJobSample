//
//  RYCityView.h
//  特种车调度
//
//  Created by 韩学鹏 on 16/3/23.
//
//

#import <UIKit/UIKit.h>
#import "JCRBlurView.h"

@interface City : NSObject

/**
 *  省市
 */
@property (nonatomic, copy) NSString *province;


@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *district;


@property (nonatomic, copy) NSString *address;

@end

@class RYCityView;

@protocol RYCityViewDelegate <NSObject>

- (void)onView:(RYCityView *)view didSelect:(City *)city;

@end

@interface RYCityView : JCRBlurView

@property (nonatomic, weak) id<RYCityViewDelegate> delegate;


@property (nonatomic, copy) NSString *currentCityName;

- (void)showOn:(UIView *)view;

- (void)dismiss;

@end
