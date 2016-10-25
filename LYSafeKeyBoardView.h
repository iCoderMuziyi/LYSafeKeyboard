//
//  LYSafeKeyBoardView.h
//  LYSafeKeyboard
//
//  Created by Mr Li on 16/10/20.
//  Copyright © 2016年 Mr_Li. All rights reserved.

//  Ail Joa Bless me

#import <UIKit/UIKit.h>

#define LY_SAFE_KEYBOARD [LYSafeKeyBoardView shareKeyBoard]

typedef void (^myBlock)(NSString * value);
/**
 *  安全键盘视图
 */
@interface LYSafeKeyBoardView : UIView

/**
 *  单例
 *
 *  @return LYSafeKeyBoard对象
 */
+ (LYSafeKeyBoardView *)shareKeyBoard;

/**
 *  点击按键回调block（返回键上的值）
 */
@property (nonatomic, copy) myBlock clickKeyBlock;

@end
