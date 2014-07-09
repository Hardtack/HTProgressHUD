//
//  HTProgressHUDIndicatorView.h
//  HTProgressHUD
//
//  Created by 최건우 on 13. 6. 30..
//

#import <UIKit/UIKit.h>

typedef enum{
    HTProgressHUDIndicatorTypeActivityIndicator,
    HTProgressHUDIndicatorTypePie,
    HTProgressHUDIndicatorTypeRing,
} HTProgressHUDIndicatorType;

@interface HTProgressHUDIndicatorView : UIView

@property (nonatomic) float progress; // 0.0 ~ 1.0

- (instancetype)initWithFrame:(CGRect)frame;
- (instancetype)initWithCustomView:(UIView *)view;

+ (HTProgressHUDIndicatorView *)indicatorViewWithType:(HTProgressHUDIndicatorType)type;

@end
