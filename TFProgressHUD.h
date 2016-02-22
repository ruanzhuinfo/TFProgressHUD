//
//  TFProgressHUD.h
//  daily
//
//  Created by taffy on 15/12/3.
//  Copyright © 2015年 taffy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProgressIndicatorView.h"

typedef void(^CompletionBlock)();

@interface TFProgressHUD : UIView

@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) ProgressIndicatorView *progressView;

+ (id) share;

/**
 *  纯文本的提示框
 *
 *  @param text       提示语
 *  @param inView     显示在指定 view 上
 *  @param delayHide  显示时间
 *  @param completion 提示框消失后的回调
 */
- (void) showWithText: (NSString *)text inView: (UIView *)inView
            delayHide: (NSTimeInterval)delayHide completion: (CompletionBlock) completion;

/**
 *  显示操作进度
 *
 *  @param inView 显示在指定的 view 上
 */
- (void) showProgressAddToView: (UIView *)inView;

/**
 *  操作完成后要调用的方法
 *
 *  @param completion 方法完成后的回调
 */
- (void) finishedProgress:(BOOL)hideDuration completion: (CompletionBlock)completion;

@end
