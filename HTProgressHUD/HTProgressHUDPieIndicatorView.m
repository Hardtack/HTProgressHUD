//
//  HTProgressHUDPieIndicatorView.m
//  HTProgressHUD
//
//  Created by 최건우 on 13. 6. 30..
//  Copyright (c) 2013년 Hardtack. All rights reserved.
//

#import "HTProgressHUDPieIndicatorView.h"

@implementation HTProgressHUDPieIndicatorView

#pragma mark - Initializers

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.tintColor = [UIColor whiteColor];
    }
    return self;
}

#pragma mark - Public methods

#pragma mark - Overrides

#pragma mark UIView overrides

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGPoint center = CGPointMake(rect.origin.x + floorf(rect.size.height / 2),
                                 rect.origin.y + floorf(rect.size.height / 2));
    // Setup
    CGFloat lineWidth = 2;
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Background
    CGContextSetStrokeColorWithColor(context, self.tintColor.CGColor);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, lineWidth);
    CGContextSetShouldAntialias(context, YES);
    CGContextStrokeEllipseInRect(context, CGRectMake(lineWidth, lineWidth, rect.size.width - lineWidth * 2, rect.size.height - lineWidth * 2));
    
    // Progress
    UIBezierPath *processPath = [UIBezierPath bezierPath];
    [processPath moveToPoint:center];
    [processPath addLineToPoint:CGPointMake(center.x, rect.origin.y)];
    CGFloat radius = floorf(MIN(rect.size.width, rect.size.height) / 2) - lineWidth;
    CGFloat startAngle = -((float)M_PI / 2);
    CGFloat endAngle = startAngle + 2 * M_PI * self.progress;
    [processPath addArcWithCenter:center
                           radius:radius
                       startAngle:startAngle
                         endAngle:endAngle
                        clockwise:YES];
    [processPath addLineToPoint:center];
    [self.tintColor set];
    [processPath fill];
}

@end
