//
//  HTViewController.m
//  HTProgressHUDExample
//
//  Created by 최건우 on 13. 6. 30..
//  Copyright (c) 2013년 Hardtack. All rights reserved.
//

#import "HTViewController.h"
#import "HTProgressHUD.h"
#import "HTProgressHUDFadeZoomAnimation.h"
#import "HTProgressHUDIndicatorView.h"

@interface HTViewController ()

@end

@implementation HTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    __block HTProgressHUD *progressHUD = [[HTProgressHUD alloc] init];
    progressHUD.animation = [HTProgressHUDFadeZoomAnimation animation];
    progressHUD.indicatorView = [HTProgressHUDIndicatorView indicatorViewWithType:HTProgressHUDIndicatorTypePie];
    progressHUD.text = @"Loading...";
    
    [progressHUD showWithAnimation:YES inView:self.view whileExecutingBlock:^{
        float r = 0.01;
        for (int i = 0; i <= 1 / r; i++) {
            [NSThread sleepForTimeInterval:r];
            progressHUD.progress = i * r;
            if (progressHUD.progress > 0.5) {
                progressHUD.text = @"Almost done";
            }
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
