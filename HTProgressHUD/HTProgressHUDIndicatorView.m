//
//  HTProgressHUDIndicatorView.m
//  HTProgressHUD
//
//  Created by 최건우 on 13. 6. 30..
//

#import "HTProgressHUDIndicatorView.h"
#import "HTProgressHUDPieIndicatorView.h"
#import "HTProgressHUDRingIndicatorView.h"

@implementation HTProgressHUDIndicatorView

#pragma mark - Class methods

+ (HTProgressHUDIndicatorView *)indicatorViewWithType:(HTProgressHUDIndicatorType)type
{
    switch (type) {
        case HTProgressHUDIndicatorTypeActivityIndicator:{
            UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            [activityIndicatorView startAnimating];
            return [[self alloc] initWithCustomView:activityIndicatorView];
        }
        case HTProgressHUDIndicatorTypePie:{
            return [[HTProgressHUDPieIndicatorView alloc] init];
        }
        case HTProgressHUDIndicatorTypeRing:{
            return [[HTProgressHUDRingIndicatorView alloc] init];
        }
    }
}

#pragma mark - Initializers

- (instancetype)init
{
    return [self initWithFrame:CGRectMake(0.0f, 0.0f, 50.0f, 50.0f)];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (instancetype)initWithCustomView:(UIView *)view
{
    self = [self initWithFrame:CGRectMake(0.0f, 0.0f, view.frame.size.width, view.frame.size.height)];
    if (self) {
        [self addSubview:view];
        view.frame = [self bounds];
    }
    return self;
}

#pragma mark - Public methods

#pragma mark - Getters and Setters

- (void)setProgress:(float)progress
{
    _progress = progress;
    [self performSelectorOnMainThread:@selector(setNeedsDisplay) withObject:nil waitUntilDone:NO];
}

@end
