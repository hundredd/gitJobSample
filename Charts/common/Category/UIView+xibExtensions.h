//
//  UIView+xibExtensions.h
//  特种车调度
//
//  Created by 韩学鹏 on 16/3/30.
//
//

#import <UIKit/UIKit.h>

@interface UIView (xibExtensions)

/**
 *  快速使用xib创建view  xib的文件名字必须和绑定的类名完全一致
 *
 *  @return return value description
 */
+ (id)createViewWithNib;

@end
