//
//  HTProgressHUDRingIndicatorView.m
//  HTProgressHUD
//
//  Created by 최건우 on 13. 6. 30..
//

#import "HTProgressHUDRingIndicatorView.h"

@implementation HTProgressHUDRingIndicatorView

#pragma mark - Initializers

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tintColor = [UIColor whiteColor];
        self.backgroundTintColor = [UIColor blackColor];
        self.ringWidth = 5.0f;
    }
    return self;
}

#pragma mark - Public methods

#pragma mark - Overrides

#pragma mark UIView overrides

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGPoint center = CGPointMake(rect.origin.x + floorf(rect.size.height / 2.0f),
                                 rect.origin.y + floorf(rect.size.height / 2.0f));
    // Setup
    CGFloat lineWidth = self.ringWidth;
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Background
    CGContextSetStrokeColorWithColor(context, self.backgroundTintColor.CGColor);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, lineWidth);
    CGContextSetShouldAntialias(context, YES);
    CGContextStrokeEllipseInRect(context, CGRectMake(lineWidth, lineWidth, rect.size.width - lineWidth * 2.0f, rect.size.height - lineWidth * 2.0f));
    
    // Progress
    CGContextBeginPath(context);
    CGContextSetStrokeColorWithColor(context, self.tintColor.CGColor);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, lineWidth);
    CGFloat radius = floorf(MIN(rect.size.width, rect.size.height) / 2.0f) - lineWidth;
    CGFloat startAngle = -((float)M_PI / 2.0f);
    CGFloat endAngle = startAngle + 2.0f * M_PI * self.progress;
    CGContextAddArc(context,
                    center.x,
                    center.y,
                    radius,
                    startAngle,
                    endAngle,
                    0);
    CGContextStrokePath(context);
}

@end
