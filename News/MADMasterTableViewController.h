//
//  MADMasterTableViewController.h
//  News
//
//  Created by Mariia Cherniuk on 19.03.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@class MADDetailViewController;

@interface MADMasterTableViewController : UITableViewController

@property (strong, nonatomic, readwrite) MADDetailViewController *detailVC;
@property (strong, nonatomic, readwrite) UINavigationController *detailNC;
@property (strong, nonatomic, readwrite) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic, readwrite) NSManagedObjectContext *managedObjectContext;

@end
