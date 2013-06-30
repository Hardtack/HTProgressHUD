#HTProgressHUD

HTProgressHUD is an replacement for UIProgressHUD, the undocumented UI component in iOS.  
And it is also replacement for [MBProgressHUD](https://github.com/jdg/MBProgressHUD).  
MBProgressHUD is too old, and causes so many crashes.  
So I re-implemented it, with newer-APIs, more stability and more customizabilities.

##Requirements

*   UIKit.framework

*   Foundation.framework

*   CoreGraphic.framework

*   QuartzCore.framework


##Specifications

###Indicators

It has following built-in indicators.  

*   Indicator with `UIActivityIndicatorView`.  
    
    Indicator with large white `UIActivityIndicatorView`.  

*   Pie-chart like indicator.  
    
    Indicator that shows progress with pie-chart like component.  

*   Ring-shaped indicator.  
    
    Indicator that shows progress with ring shaped component.  

And you can also customize indicator by subclassing `HTProgressHUDIndicatorView`.  

###Animations

It has following built-in indicators.  

*   Fade animation.  

*   Fade with zoom animation.  

You can even customize animation by subclassing `HTProgressHUDAnimation`.  

##Usages

###Example

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

###Customization
   
    See the source of built-in animations and built-in indicators.
    These are also kind of customized animations/indocators.
