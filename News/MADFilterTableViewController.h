//
//  MADFilterTableViewController.h
//  News
//
//  Created by Mariia Cherniuk on 11.04.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MADFilterTableViewControllerDelegate.h"

@interface MADFilterTableViewController : UITableViewController

@property (assign, nonatomic, readwrite) id <MADFilterTableViewControllerDelegate> filterDelegat;

@end
