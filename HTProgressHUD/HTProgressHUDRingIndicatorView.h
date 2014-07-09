//
//  HTProgressHUDRingIndicatorView.h
//  HTProgressHUD
//
//  Created by 최건우 on 13. 6. 30..
//

#import "HTProgressHUDIndicatorView.h"

@interface HTProgressHUDRingIndicatorView : HTProgressHUDIndicatorView

@property (nonatomic, strong) UIColor *backgroundTintColor; // Default is black
@property (nonatomic, strong) UIColor *tintColor; // Default is white
@property (nonatomic) CGFloat ringWidth; // Default is 5

@end
