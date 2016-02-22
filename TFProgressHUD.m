//
//  TFProgressHUD.m
//  daily
//
//  Created by taffy on 15/12/3.
//  Copyright © 2015年 taffy. All rights reserved.
//

#import "TFProgressHUD.h"

#define WIDTH_SCREEN_RAW ([UIScreen mainScreen].bounds.size.width)
#define HEIGHT_SCREEN_RAW ([UIScreen mainScreen].bounds.size.height)
#define WIDTH_SCREEN (MIN(WIDTH_SCREEN_RAW, HEIGHT_SCREEN_RAW))
#define HEIGHT_SCREEN (MAX(WIDTH_SCREEN_RAW, HEIGHT_SCREEN_RAW))

@implementation TFProgressHUD {
  
}

+ (id) share {
  static TFProgressHUD *HUD;
  
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    HUD = [TFProgressHUD new];
    HUD.maskView = [[UIView alloc] initWithFrame:CGRectZero];
    HUD.progressView = [[ProgressIndicatorView alloc] init];
  });
  
  return HUD;
}


- (void) showWithText: (NSString *)text inView: (UIView *)inView
            delayHide: (NSTimeInterval)delayHide completion: (CompletionBlock) completion {
  [self.maskView setFrame:inView.bounds];
  [self.maskView setBackgroundColor:[UIColor clearColor]];
  [self.maskView setAlpha:0];
  [inView addSubview:self.maskView];
  
  UIView *tipView = [[UIView alloc] initWithFrame:CGRectZero];
  [tipView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.90]];
  [tipView.layer setCornerRadius:5.0];
  [self.maskView addSubview:tipView];
  
  UILabel *tipText = [[UILabel alloc] initWithFrame:CGRectZero];
  [tipView addSubview:tipText];
  [tipText setText:text];
  [tipText setTextColor:[UIColor whiteColor]];
  [tipText setTextAlignment:NSTextAlignmentCenter];
  [tipText setFont:[UIFont systemFontOfSize:16]];
  [tipText sizeToFit];
  [tipView setFrame:CGRectMake((WIDTH_SCREEN - tipText.bounds.size.width - 20) / 2,
                               (HEIGHT_SCREEN - tipText.bounds.size.height - 20) / 2,
                               tipText.bounds.size.width + 20,
                               tipText.bounds.size.height + 20)];
  [tipText setFrame:CGRectMake(10, 10, tipText.bounds.size.width, tipText.bounds.size.height)];
  
  [UIView animateWithDuration:0.1 animations:^{
    [self.maskView setAlpha:1.0];
  } completion:^(BOOL finished) {
    [UIView animateWithDuration:0.1
                          delay:delayHide
                        options:UIViewAnimationOptionCurveEaseOut animations:^{
                          [self.maskView setAlpha:0];
                        } completion:^(BOOL finished) {
                          [self.maskView removeFromSuperview];
                          [tipView removeFromSuperview];
                          completion();
                        }];
  }];
  
  
  
  
}
- (void) showProgressAddToView: (UIView *)inView {
  [self.maskView setFrame:CGRectMake(0, 64, inView.bounds.size.width, inView.bounds.size.height - 64)];
  [self.maskView setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.5]];
  [self.maskView setAlpha:0];
  [inView addSubview:self.maskView];
  
  [UIView animateWithDuration:0.1 animations:^{
    [self.maskView setAlpha:1.0];
  }];
  
  [self.progressView showProgressAddToView:self.maskView];
}


- (void) finishedProgress:(BOOL)hideDuration completion:(CompletionBlock)completion {
  
  [self.progressView finishedProgress:hideDuration completionProgress:^{
    [UIView animateWithDuration:0.1 animations:^{
      [self.maskView setAlpha:0];
    } completion:^(BOOL finished) {
      completion();
    }];
  }];
}

@end
