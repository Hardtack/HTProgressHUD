//
//  HTProgressHUD.m
//  HTProgressHUD
//
//  Created by 최건우 on 13. 6. 30..
//  Copyright (c) 2013년 Hardtack. All rights reserved.
//

#import "HTProgressHUD.h"
#import <QuartzCore/QuartzCore.h>
#import <dispatch/dispatch.h>
#import "HTProgressHUDAnimation.h"
#import "HTProgressHUDFadeAnimation.h"
#import "HTProgressHUDIndicatorView.h"

@interface HTProgressHUD ()

@property (nonatomic, weak) UIView *targetView;
@property (nonatomic) BOOL onShowingAnimation; // You cannot cancel showing animation
@property (nonatomic) BOOL shouldHideWithAnimation; // Flag for hiding

+ (NSOperationQueue *)operationQueue;

@end

@implementation HTProgressHUD

#pragma mark - Class methods

+ (NSOperationQueue *)operationQueue {
    static dispatch_once_t onceToken;
    static NSOperationQueue *queue;
    dispatch_once(&onceToken, ^{
        queue = [[NSOperationQueue alloc] init];
    });
    return queue;
}

#pragma mark - Private methods

#pragma mark Layout

- (CGRect)updatePositionForHUDFrame:(CGRect)frame {
    CGRect viewBounds = [self bounds];
    CGPoint center = CGPointMake(viewBounds.origin.x + floorf(viewBounds.size.width / 2),
                                 viewBounds.origin.y + floorf(viewBounds.size.height / 2));
    switch (self.position) {
        case HTProgressHUDPositionTopLeft:
            frame.origin.x = self.marginInsets.left;
            frame.origin.y = self.marginInsets.top;
            break;
        case HTProgressHUDPositionTopCenter:
            frame.origin.x = center.x - floorf(frame.size.width / 2);
            frame.origin.y = self.marginInsets.top;
            break;
        case HTProgressHUDPositionTopRight:
            frame.origin.x = viewBounds.size.width - self.marginInsets.right;
            frame.origin.y = self.marginInsets.top;
            break;
            
        case HTProgressHUDPositionCenterLeft:
            frame.origin.x = self.marginInsets.left;
            frame.origin.y = center.y - floorf(frame.size.height / 2);
            break;
        case HTProgressHUDPositionCenter:
            frame.origin.x = center.x - floorf(frame.size.width / 2);
            frame.origin.y = center.y - floorf(frame.size.height / 2);
            break;
        case HTProgressHUDPositionCenterRight:
            frame.origin.x = viewBounds.size.width - self.marginInsets.right;
            frame.origin.y = center.y - floorf(frame.size.height / 2);
            break;
            
        case HTProgressHUDPositionBottomLeft:
            frame.origin.x = self.marginInsets.left;
            frame.origin.y = viewBounds.size.height - self.marginInsets.bottom;
            break;
        case HTProgressHUDPositionBottomCenter:
            frame.origin.x = center.x - floorf(frame.size.width / 2);
            frame.origin.y = viewBounds.size.height - self.marginInsets.bottom;
            break;
        case HTProgressHUDPositionBottomRight:
            frame.origin.x = viewBounds.size.width - self.marginInsets.right;
            frame.origin.y = viewBounds.size.height - self.marginInsets.bottom;
            break;
    }
    return frame;
}

- (void)updatePosition {
    CGRect frame = [self updatePositionForHUDFrame:self.hudView.frame];
    switch (self.position) {
        case HTProgressHUDPositionTopLeft:
            self.hudView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
            break;
        case HTProgressHUDPositionTopCenter:
            self.hudView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
            break;
        case HTProgressHUDPositionTopRight:
            self.hudView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin;
            break;
            
        case HTProgressHUDPositionCenterLeft:
            self.hudView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
            break;
        case HTProgressHUDPositionCenter:
            self.hudView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
            break;
        case HTProgressHUDPositionCenterRight:
            self.hudView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin;
            break;
            
        case HTProgressHUDPositionBottomLeft:
            self.hudView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleRightMargin;
            break;
        case HTProgressHUDPositionBottomCenter:
            self.hudView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
            break;
        case HTProgressHUDPositionBottomRight:
            self.hudView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin;
            break;
    }
    self.hudView.frame = frame;
}

- (void)updateHUD {
    // Indicator size
    CGRect indicatorFrame = self.indicatorView.frame;
    indicatorFrame.origin.y = self.hudView.bounds.origin.y + self.paddingInsets.top;
    
    
    // Label size
    [self.textLabel sizeToFit];
    CGRect labelFrame = self.textLabel.frame;
    labelFrame.origin.y = indicatorFrame.origin.y + indicatorFrame.size.height;
    if (!CGRectIsEmpty(labelFrame)) {
        labelFrame.origin.y += 10;
    }
    
    // HUD size
    CGRect frame = CGRectZero;
    frame.size.width += self.paddingInsets.left + MAX(self.indicatorView.frame.size.width, labelFrame.size.width) + self.paddingInsets.right;
    frame.size.height += labelFrame.origin.y + labelFrame.size.height + self.paddingInsets.bottom;
    frame = [self updatePositionForHUDFrame:frame];
    
    
    CGPoint center = CGPointMake(floorf(frame.size.width / 2),
                                 floorf(frame.size.height / 2));
    indicatorFrame.origin.x = center.x - floorf(indicatorFrame.size.width / 2);
    labelFrame.origin.x = center.x - floorf(labelFrame.size.width / 2);
    
    self.indicatorView.frame = indicatorFrame;
    self.textLabel.frame = labelFrame;
    self.hudView.frame = frame;
}

- (void)updateViews {
    if (self.animateWhenLayoutChanged && !self.hidden) {
        if (![[NSThread currentThread] isMainThread]) {
            [self performSelectorOnMainThread:@selector(updateViews) withObject:nil waitUntilDone:NO];
            return;
        }
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        [UIView animateWithDuration:self.layoutAnimationDuration
                         animations:^{
                             [self updateHUD];
                         }
                         completion:^(BOOL finished) {
                             [self updatePosition];
                             if ([self.delegate respondsToSelector:@selector(progressHUDDidChange:)]) {
                                 [self.delegate progressHUDDidChange:self];
                             }
                         }];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setNeedsLayout];
            if ([self.delegate respondsToSelector:@selector(progressHUDDidChange:)]) {
                [self.delegate progressHUDDidChange:self];
            }
        });
    }
}

#pragma mark - Initializers

- (id)init {
    return [self initWithFrame:CGRectMake(0, 0, 100, 100)];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Self-Configurations
        self.hidden = YES;
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        
        // HUD View
        self.hudView = [[UIView alloc] init];
        self.hudView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.7];
        self.hudView.opaque = NO;
        self.hudView.layer.cornerRadius = 10.0f;
        self.hudView.layer.masksToBounds = YES;
        self.hudView.layer.rasterizationScale = [[UIScreen mainScreen] scale];
        self.hudView.layer.shouldRasterize = YES;
        [self addSubview:self.hudView];
        
        // Text Label
        self.textLabel = [[UILabel alloc] init];
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.opaque = NO;
        self.textLabel.textColor = [UIColor whiteColor];
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.textLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        self.textLabel.numberOfLines = 1;
        [self.hudView addSubview:self.textLabel];
        
        // Appearance Options
        self.indicatorView = [HTProgressHUDIndicatorView indicatorViewWithType:HTProgressHUDIndicatorTypeActivityIndicator];
        
        // Hierachy Options
        self.animation = [HTProgressHUDFadeAnimation animation];
        self.addToViewOnShow = YES;
        self.removeFromSuperviewOnHide = YES;
        
        // Layout
        self.paddingInsets = UIEdgeInsetsMake(20, 20, 20, 20);
        self.marginInsets = UIEdgeInsetsZero;
        self.position = HTProgressHUDPositionCenter;
        
        // Animation
        self.layoutAnimationDuration = 0.1;
        self.animateWhenLayoutChanged = YES;
        
        // Data
        self.progress = 0;
        self.onShowingAnimation = NO;
        
        // Auto-layout
        if (NSClassFromString(@"NSLayoutConstraint")) {
            [self setTranslatesAutoresizingMaskIntoConstraints:YES];
            [self.hudView setTranslatesAutoresizingMaskIntoConstraints:YES];
        }
    }
    return self;
}

#pragma mark - Public methods

#pragma mark Showing methods

- (void)showInView:(UIView *)view {
    [self showInView:view animated:YES];
}

- (void)showInView:(UIView *)view animated:(BOOL)animated {
    [self showInRect:[view bounds] inView:view animated:animated];
}

- (void)showInRect:(CGRect)rect inView:(UIView *)view {
    [self showInRect:rect inView:view animated:YES];
}

- (void)showInRect:(CGRect)rect inView:(UIView *)view animated:(BOOL)animated {
    if (![[NSThread currentThread] isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showInRect:rect inView:view animated:animated];
        });
        return;
    }
    self.targetView = view;
    
    self.frame = rect;
    if (self.addToViewOnShow) {
        [view addSubview:self];
    }
    if ([self.delegate respondsToSelector:@selector(progressHUD:willBeShownInView:)]) {
        [self.delegate progressHUD:self willBeShownInView:view];
    }
    
    if (self.disableUserInteractionOfSuperview) {
        self.targetView.userInteractionEnabled = NO;
    }
    
    self.hidden = NO;
    self.shouldHideWithAnimation = NO;
    if (animated) {
        self.onShowingAnimation = YES;
        self.animation.performingHUD = self;
        self.animation.animationType = HTProgressHUDAnimationTypeShowing;
        [self.animation setUpShowingAnimation:self];
        [self.animation performShowingAnimation:self];
    } else {
        if ([self.delegate respondsToSelector:@selector(progressHUD:wasShownInView:)]){
            [self.delegate progressHUD:self wasShownInView:view];
        }
        if (self.afterShowingBlock) {
            self.afterShowingBlock();
        }
    }
}

#pragma mark Showing with thread methods

- (void)showInView:(UIView *)view whileExecuting:(SEL)method onTarget:(id)target withObject:(id)object animated:(BOOL)animated {
    [self showInRect:[view bounds] inView:view whileExecuting:method onTarget:target withObject:object animated:animated];
}
- (void)showInRect:(CGRect)rect inView:(UIView *)view whileExecuting:(SEL)method onTarget:(id)target withObject:(id)object animated:(BOOL)animated {
    NSMethodSignature *signature = [[target class] instanceMethodSignatureForSelector:method];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:target];
    [invocation setSelector:method];
    if ([signature numberOfArguments] > 2) {
        [invocation setArgument:&object atIndex:2];
    }
    [invocation retainArguments];
    [self showInRect:rect inView:view whileExecutingInvocation:invocation animated:animated];
}

- (void)showInView:(UIView *)view whileExecutingInvocation:(NSInvocation *)invocation animated:(BOOL)animated {
    [self showInRect:[view bounds] inView:view whileExecutingInvocation:invocation animated:animated];
}

- (void)showInRect:(CGRect)rect inView:(UIView *)view whileExecutingInvocation:(NSInvocation *)invocation animated:(BOOL)animated {
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithInvocation:invocation];
    [operation setCompletionBlock:^{
        [self hideWithAnimation:animated];
    }];
    [[[self class] operationQueue] addOperation:operation];
    [self showInRect:rect inView:view animated:animated];
}


- (void)showWithAnimation:(BOOL)animated inView:(UIView *)view whileExecutingBlock:(dispatch_block_t)block {
    [self showWithAnimation:animated inRect:[view bounds] inView:view whileExecutingBlock:block];
}

- (void)showWithAnimation:(BOOL)animated inRect:(CGRect)rect inView:(UIView *)view whileExecutingBlock:(dispatch_block_t)block {
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:block];
    [operation setCompletionBlock:^{
        [self hideWithAnimation:animated];
    }];
    [[[self class] operationQueue] addOperation:operation];
    [self showInRect:rect inView:view animated:animated];
}

#pragma mark Hiding methods


- (void)hide {
    [self hideWithAnimation:YES];
}

- (void)hideWithAnimation:(BOOL)animated {
    if (![[NSThread currentThread] isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hideWithAnimation:animated];
        });
        return;
    }
    
    if (self.disableUserInteractionOfSuperview) {
        self.targetView.userInteractionEnabled = YES;
    }
    if (animated) {
        if (self.onShowingAnimation) {
            self.shouldHideWithAnimation = YES;
            return;
        }
        self.animation.performingHUD = self;
        self.animation.animationType = HTProgressHUDAnimationTypeHiding;
        [self.animation setUpHidingAnimation:self];
        [self.animation performHidingAnimation:self];
    } else {
        self.hidden = YES;
        if (self.removeFromSuperviewOnHide) {
            [self removeFromSuperview];
        }
        if ([self.delegate respondsToSelector:@selector(progressHUD:wasHiddenInView:)]) {
            [self.delegate progressHUD:self wasHiddenInView:self.targetView];
        }
        if (self.afterHidingBlock) {
            self.afterHidingBlock();
        }
    }
}

- (void)hideAfterDelay:(NSTimeInterval)delay {
    [self hideAfterDelay:delay animated:YES];
}

- (void)hideAfterDelay:(NSTimeInterval)delay animated:(BOOL)animated {
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:@selector(hideWithAnimation:)];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:self];
    [invocation setSelector:@selector(hideWithAnimation:)];
    [invocation setArgument:&animated atIndex:2];
    [invocation retainArguments];
    [NSTimer scheduledTimerWithTimeInterval:delay invocation:invocation repeats:NO];
}

#pragma mark Animation callback

- (void)animationDidFinishWithType:(HTProgressHUDAnimationType)animationType {
    self.onShowingAnimation = NO;
    switch (animationType) {
        case HTProgressHUDAnimationTypeShowing:
            [self.animation tearDownShowingAnimation:self];
            if ([self.delegate respondsToSelector:@selector(progressHUD:wasShownInView:)]) {
                [self.delegate progressHUD:self wasShownInView:self.targetView];
            }
            if (self.afterShowingBlock) {
                self.afterShowingBlock();
            }
            break;
        case HTProgressHUDAnimationTypeHiding:
            [self.animation tearDownHidingAnimation:self];
            if ([self.delegate respondsToSelector:@selector(progressHUD:willBeHiddenFromView:)]) {
                [self.delegate progressHUD:self willBeHiddenFromView:self.targetView];
            }
            self.hidden = YES;
            if (self.removeFromSuperviewOnHide) {
                [self removeFromSuperview];
            }
            if ([self.delegate respondsToSelector:@selector(progressHUD:wasHiddenInView:)]) {
                [self.delegate progressHUD:self wasHiddenInView:self.targetView];
            }
            if (self.afterHidingBlock) {
                self.afterHidingBlock();
            }
            break;
    }
}

#pragma mark - Getters and Setters

- (void)setPosition:(HTProgressHUDPosition)position {
    _position = position;
    [self updateViews];
}

- (void)setText:(NSString *)text {
    _text = text;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.textLabel.text = text;
        [self updateViews];
    });
}

- (void)setIndicatorView:(HTProgressHUDIndicatorView *)indicatorView {
    [_indicatorView removeFromSuperview];
    _indicatorView = indicatorView;
    [self.hudView addSubview:indicatorView];
    [self updateViews];
}

- (void)setMarginInsets:(UIEdgeInsets)marginInsets {
    _marginInsets = marginInsets;
    [self updateViews];
}

- (void)setPaddingInsets:(UIEdgeInsets)paddingInsets {
    _paddingInsets = paddingInsets;
    [self updateViews];
}

- (void)setProgress:(float)progress {
    _progress = progress;
    self.indicatorView.progress = progress;
    [self updateViews];
}

- (void)setOnShowingAnimation:(BOOL)onShowingAnimation {
    _onShowingAnimation = onShowingAnimation;
    if (!onShowingAnimation && self.shouldHideWithAnimation) {
        [self hideWithAnimation:YES];
        self.shouldHideWithAnimation = NO;
    }
}

#pragma mark - Overrides

#pragma mark UIView overrides

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateHUD];
    [self updatePosition];
}

@end
