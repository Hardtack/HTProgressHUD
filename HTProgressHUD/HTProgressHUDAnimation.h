//
//  HTProgressHUDAnimation.h
//  HTProgressHUD
//
//  Created by 최건우 on 13. 6. 30..
//

#import <Foundation/Foundation.h>
#import "HTProgressHUD.h"

typedef enum {
    HTProgressHUDAnimationTypeShowing,
    HTProgressHUDAnimationTypeHiding,
} HTProgressHUDAnimationType;
@interface HTProgressHUDAnimation : NSObject

@property (nonatomic) HTProgressHUDAnimationType animationType;
@property (nonatomic, strong) HTProgressHUD *performingHUD; // DO NOT Use this variable. It's internal use only.

// Override points for showing animation.
- (void)setUpShowingAnimation:(HTProgressHUD *)progressHUD;
- (void)performShowingAnimation:(HTProgressHUD *)progressHUD;
- (void)tearDownShowingAnimation:(HTProgressHUD *)progressHUD;

// Override points for hidinging animation.
- (void)setUpHidingAnimation:(HTProgressHUD *)progressHUD;
- (void)performHidingAnimation:(HTProgressHUD *)progressHUD;
- (void)tearDownHidingAnimation:(HTProgressHUD *)progressHUD;

// You must Call after animation finished
- (void)finishAnimation;

// Convinience initializer
+ (instancetype)animation;

@end
