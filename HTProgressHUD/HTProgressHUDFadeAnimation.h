//
//  HTProgressHUDFadeAnimation.h
//  HTProgressHUD
//
//  Created by 최건우 on 13. 6. 30..
//

#import "HTProgressHUDAnimation.h"

@interface HTProgressHUDFadeAnimation : HTProgressHUDAnimation

@property (nonatomic) NSTimeInterval duration; // Default is 0.3
@property (nonatomic) UIViewAnimationCurve curve; // Default is UIViewAnimationCurveEaseInOut

@end
