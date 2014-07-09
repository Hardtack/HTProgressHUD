//
//  HTProgressHUDFadeZoomAnimation.m
//  HTProgressHUD
//
//  Created by 최건우 on 13. 6. 30..
//

#import "HTProgressHUDFadeZoomAnimation.h"

@implementation HTProgressHUDFadeZoomAnimation

#pragma mark - Initializers

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.zoomInDuaration = 0.15;
        self.zoomOutDuaration = 0.15;
        self.zoomInCurve = UIViewAnimationCurveEaseIn;
        self.zoomOutCurve = UIViewAnimationCurveEaseOut;
        self.zoomInScale = CGSizeMake(1.1f, 1.1f);
    }
    return self;
}

#pragma mark - Public methods

#pragma mark - Overrides

#pragma mark HTProgressHUDAnimation overrides

#pragma mark  Showing animation

- (void)setUpShowingAnimation:(HTProgressHUD *)progressHUD
{
    progressHUD.alpha = 0.0f;
    progressHUD.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
}

- (void)performShowingAnimation:(HTProgressHUD *)progressHUD
{
    [UIView setAnimationCurve:self.zoomInCurve];
    [UIView animateWithDuration:self.zoomInDuaration
                     animations:^{
                         progressHUD.alpha = 0.5f;
                         progressHUD.transform = CGAffineTransformMakeScale(self.zoomInScale.width, self.zoomInScale.height);
                     }
                     completion:^(BOOL finished) {
                         [UIView setAnimationCurve:self.zoomOutCurve];
                         [UIView animateWithDuration:self.zoomOutDuaration animations:^{
                             progressHUD.alpha = 1.0f;
                             progressHUD.transform = CGAffineTransformIdentity;
                         } completion:^(BOOL finished) {
                             [self finishAnimation];
                         }];
                     }];
}

- (void)tearDownShowingAnimation:(HTProgressHUD *)progressHUD
{
}

#pragma mark  Hiding animation

- (void)setUpHidingAnimation:(HTProgressHUD *)progressHUD
{
}

- (void)performHidingAnimation:(HTProgressHUD *)progressHUD
{
    [UIView setAnimationCurve:self.zoomInCurve];
    [UIView animateWithDuration:self.zoomInDuaration
                     animations:^{
                         progressHUD.alpha = 0.5f;
                         progressHUD.transform = CGAffineTransformMakeScale(self.zoomInScale.width, self.zoomInScale.height);
                     }
                     completion:^(BOOL finished) {
                         [UIView setAnimationCurve:self.zoomOutCurve];
                         [UIView animateWithDuration:self.zoomOutDuaration animations:^{
                             progressHUD.alpha = 0.0f;
                             progressHUD.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
                         } completion:^(BOOL finished) {
                             [self finishAnimation];
                         }];
                     }];
}

- (void)tearDownHidingAnimation:(HTProgressHUD *)progressHUD
{
    progressHUD.alpha = 1.0f;
    progressHUD.transform = CGAffineTransformIdentity;
}
@end
