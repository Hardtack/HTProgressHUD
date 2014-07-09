//
//  HTProgressHUDFadeZoomAnimation.h
//  HTProgressHUD
//
//  Created by 최건우 on 13. 6. 30..
//

#import "HTProgressHUDAnimation.h"

@interface HTProgressHUDFadeZoomAnimation : HTProgressHUDAnimation

@property (nonatomic) NSTimeInterval zoomInDuaration; // Default is 0.15
@property (nonatomic) NSTimeInterval zoomOutDuaration; // Default is 0.15
@property (nonatomic) CGSize zoomInScale; // Default is (1.1, 1.1)
@property (nonatomic) UIViewAnimationCurve zoomInCurve; // Default is UIViewAnimationCurveEaseIn
@property (nonatomic) UIViewAnimationCurve zoomOutCurve; // Default is UIViewAnimationCurveEaseOut

@end
