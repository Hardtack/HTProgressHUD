//
//  HTViewController.h
//  HTProgressHUDExample
//
//  Created by 최건우 on 13. 6. 30..
//

#import <UIKit/UIKit.h>

@interface HTViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end
