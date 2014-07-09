//
//  HTProgressHUD.h
//  HTProgressHUD
//
//  Created by 최건우 on 13. 6. 30..
//

#import <UIKit/UIKit.h>

@class HTProgressHUDAnimation;

/**
 * Positions for HTProgressHUD
 */
typedef enum {
    HTProgressHUDPositionTopLeft,
    HTProgressHUDPositionTopCenter,
    HTProgressHUDPositionTopRight,
    HTProgressHUDPositionCenterLeft,
    HTProgressHUDPositionCenter,
    HTProgressHUDPositionCenterRight,
    HTProgressHUDPositionBottomLeft,
    HTProgressHUDPositionBottomCenter,
    HTProgressHUDPositionBottomRight,
} HTProgressHUDPosition;

@class HTProgressHUD;
@class HTProgressHUDIndicatorView;

/**
 * Protocol for UIView that handles changing of HUD's progress value.
 * You can customize progress animation by implementing this protocol.
 */
@protocol HTProgressHUDProgressHandling <NSObject>
@required
- (void)progressHUD:(HTProgressHUD *)progressHUD didChangeProgressValue:(float)progress;

@end

/**
 * General-purpose delegate for HTProgressHUD.  
 */
@protocol HTProgressHUDDelegate <NSObject>

@optional
- (void)progressHUD:(HTProgressHUD *)progressHUD willBeShownInView:(UIView *)view;
- (void)progressHUD:(HTProgressHUD *)progressHUD wasShownInView:(UIView *)view;
- (void)progressHUDDidChange:(HTProgressHUD *)progressHUD;
- (void)progressHUD:(HTProgressHUD *)progressHUD willBeHiddenFromView:(UIView *)view;
- (void)progressHUD:(HTProgressHUD *)progressHUD wasHiddenInView:(UIView *)view;

@end

@interface HTProgressHUD : UIView

// View's materials
@property (nonatomic, strong) UIView *hudView; // Actual HUD view.
@property (nonatomic, strong) UILabel *textLabel; // Default text label.

// View Appearance Options
@property (nonatomic, strong) HTProgressHUDIndicatorView *indicatorView; // Default is indicator view with UIActivityIndicatorView

// View Hierachy Options
@property (nonatomic) BOOL addToViewOnShow; // Default is YES;
@property (nonatomic) BOOL removeFromSuperviewOnHide; // Default is YES;

// Layout Options
@property (nonatomic) UIEdgeInsets paddingInsets;
@property (nonatomic) UIEdgeInsets marginInsets;
@property (nonatomic) HTProgressHUDPosition position; // Default is HTProgressHUDPositionCenter

// Animation Options
@property (nonatomic, strong) HTProgressHUDAnimation *animation; // Default is fade animation
@property (nonatomic) NSTimeInterval layoutAnimationDuration; // Default is 0.3
@property (nonatomic, getter=shouldAnimateWhenLayoutChanged) BOOL animateWhenLayoutChanged; //Default is YES

// Data
@property (nonatomic) float progress;
@property (nonatomic, strong) NSString *text;

// Delegates
@property (nonatomic, weak) id<HTProgressHUDDelegate> delegate;

// Blocks
@property (nonatomic, copy) dispatch_block_t afterShowingBlock;
@property (nonatomic, copy) dispatch_block_t afterHidingBlock;

/* Initializers */
- (instancetype)init;
- (instancetype)initWithFrame:(CGRect)frame;

/* Progress HUD showing methods.
   "Above view" means that the HUD will be added to the superview of `view`
   as a subview above `view` */
- (void)showInView:(UIView *)view; // Animated
- (void)showInView:(UIView *)view animated:(BOOL)animated;
- (void)showAboveView:(UIView *)view; // Animated
- (void)showAboveView:(UIView *)view animated:(BOOL)animated;
- (void)showInRect:(CGRect)rect inView:(UIView *)view; // Animated
- (void)showInRect:(CGRect)rect inView:(UIView *)view animated:(BOOL)animated;

// Selector based
- (void)showInView:(UIView *)view whileExecuting:(SEL)method onTarget:(id)target withObject:(id)object animated:(BOOL)animated;
- (void)showAboveView:(UIView *)view whileExecuting:(SEL)method onTarget:(id)target withObject:(id)object animated:(BOOL)animated;
- (void)showInRect:(CGRect)rect inView:(UIView *)view whileExecuting:(SEL)method onTarget:(id)target withObject:(id)object animated:(BOOL)animated;

// Invocation based
- (void)showInView:(UIView *)view whileExecutingInvocation:(NSInvocation *)invocation animated:(BOOL)animated;
- (void)showAboveView:(UIView *)view whileExecutingInvocation:(NSInvocation *)invocation animated:(BOOL)animated;
- (void)showInRect:(CGRect)rect inView:(UIView *)view whileExecutingInvocation:(NSInvocation *)invocation animated:(BOOL)animated;

// Block based
- (void)showWithAnimation:(BOOL)animated inView:(UIView *)view whileExecutingBlock:(dispatch_block_t)block;
- (void)showWithAnimation:(BOOL)animated aboveView:(UIView *)view whileExecutingBlock:(dispatch_block_t)block;
- (void)showWithAnimation:(BOOL)animated inRect:(CGRect)rect inView:(UIView *)view whileExecutingBlock:(dispatch_block_t)block;

/* Progress HUD hiding methods */
- (void)hide; // Animated
- (void)hideWithAnimation:(BOOL)animated;
- (void)hideAfterDelay:(NSTimeInterval)delay; // Animated
- (void)hideAfterDelay:(NSTimeInterval)delay animated:(BOOL)animated;

@end
