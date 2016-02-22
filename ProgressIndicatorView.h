//
//  ProgressIndicatorView.h
//  Demos
//
//  Created by taffy on 15/12/3.
//  Copyright © 2015年 taffy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CompletionProgressBlock)();

@interface ProgressIndicatorView : UIView

/**
 *  添加进度条到 view 上
 *
 *  @param inView 进度条始终显示在 inView 的顶端
 */
- (void) showProgressAddToView: (UIView *)inView;


/**
 *  事件处理完要此方法关掉进度条
 *
 *  @param finished
 *  @completionProgress
 */
- (void) finishedProgress:(BOOL)finished
       completionProgress: (CompletionProgressBlock)completionProgress;

@end
