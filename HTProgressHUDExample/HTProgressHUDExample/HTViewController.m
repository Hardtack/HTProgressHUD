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

#pragma mark - Private methods

- (void)simple {
    HTProgressHUD *HUD = [[HTProgressHUD alloc] init];
    [HUD showInView:self.view];
    [HUD hideAfterDelay:3];
}

- (void)withText {
    HTProgressHUD *HUD = [[HTProgressHUD alloc] init];
    HUD.text = @"Loading...";
    [HUD.indicatorView removeFromSuperview];
    [HUD showInView:self.view];
    
    [HUD hideAfterDelay:3];
}

- (void)progress {
    HTProgressHUD *HUD = [[HTProgressHUD alloc] init];
    HUD.indicatorView = [HTProgressHUDIndicatorView indicatorViewWithType:HTProgressHUDIndicatorTypePie];
    HUD.text = @"Uploading...";
    [HUD showWithAnimation:YES inView:self.view whileExecutingBlock:^{
        float r = 0.01;
        for (int i = 0; i <= 1 / 0.01; i++) {
            HUD.progress = i * r;
            [NSThread sleepForTimeInterval:r];
        }
    }];
}

- (void)zoomAnimationWithRing {
    HTProgressHUD *HUD = [[HTProgressHUD alloc] init];
    HUD.indicatorView = [HTProgressHUDIndicatorView indicatorViewWithType:HTProgressHUDIndicatorTypeRing];
    HUD.animation = [HTProgressHUDFadeZoomAnimation animation];
    HUD.text = @"Downloading...";
    [HUD showWithAnimation:YES inView:self.view whileExecutingBlock:^{
        float r = 0.01;
        for (int i = 0; i <= 1 / 0.01; i++) {
            HUD.progress = i * r;
            [NSThread sleepForTimeInterval:r];
        }
    }];
}

-(void)textOnly{
    HTProgressHUD *HUD = [[HTProgressHUD alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    HUD.text = @"Hello World...............";
    HUD.indicatorView = [[HTProgressHUDIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [HUD showInView:self.view];
    
    [HUD hideAfterDelay:3];
}

#pragma mark - Public mehtods

#pragma mark - Overrides

#pragma mark UIViewController overrides

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

#pragma mark - Table view data source methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Simple Demo";
            break;
        case 1:
            cell.textLabel.text = @"Text";
            break;
        case 2:
            cell.textLabel.text = @"Pie Progress";
            break;
        case 3:
            cell.textLabel.text = @"Zoom & Ring";
            break;
        case 4:
            cell.textLabel.text = @"Text Only";
    }
    return cell;
}

#pragma mark - Table view delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            [self simple];
            break;
        case 1:
            [self withText];
            break;
        case 2:
            [self progress];
            break;
        case 3:
            [self zoomAnimationWithRing];
            break;
        case 4:
            [self textOnly];
            break;
    }
}

@end
