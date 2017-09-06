//
//  ZDTextView.h
//  特种车调度
//
//  Created by 王鑫 on 16/3/9.
//
//

#import <UIKit/UIKit.h>

@interface ZDTextView : UITextView


@property(copy,nonatomic)   NSString *placeholder;

@property(strong,nonatomic) NSIndexPath * indexPath;

//最大长度设置
@property(assign,nonatomic) NSInteger maxTextLength;

//更新高度的时候
@property(assign,nonatomic) float updateHeight;

/**
 *  增加text 长度限制
 *
 *  @param maxLength <#maxLength description#>
 *  @param limit     <#limit description#>
 */
-(void)addMaxTextLengthWithMaxLength:(NSInteger)maxLength andEvent:(void(^)(ZDTextView *text))limit;
/**
 *  开始编辑 的 回调
 *
 *  @param begin <#begin description#>
 */
-(void)addTextViewBeginEvent:(void(^)(ZDTextView *text))begin;

/**
 *  结束编辑 的 回调
 *
 *  @param begin <#begin description#>
 */
-(void)addTextViewEndEvent:(void(^)(ZDTextView *text))End;

/**
 *  设置Placeholder 颜色
 *
 *  @param color <#color description#>
 */
-(void)setPlaceholderColor:(UIColor*)color;

/**
 *  设置Placeholder 字体
 *
 *  @param font <#font description#>
 */
-(void)setPlaceholderFont:(UIFont*)font;

/**
 *  设置透明度
 *
 *  @param opacity <#opacity description#>
 */
-(void)setPlaceholderOpacity:(float)opacity;

@end
