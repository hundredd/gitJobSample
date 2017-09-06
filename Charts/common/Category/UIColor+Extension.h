//
//  UIColor+Extension.h
//  FaBo
//
//  Created by hxp on 15/8/19.
//  Copyright (c) 2015年 hxp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extension)

/**
 *  16进制颜色值转UIColor
 *
 *  @param hexColor hexColor description
 *
 *  @return return value description
 */
+ (UIColor *)colorWithHexColor:(NSString *)hexColor;

/**
 *  UIColor转Hex
 *
 *  @param color <#color description#>
 *
 *  @return <#return value description#>
 */
- (NSString *)toHexColor;

@end
