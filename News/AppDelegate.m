//
//  AppDelegate.m
//  News
//
//  Created by Mariia Cherniuk on 18.03.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import "AppDelegate.h"
#import "MADMasterTableViewController.h"
#import "MADDetailViewController.h"
#import "MADCoreDataStack.h"

@interface AppDelegate () <UISplitViewControllerDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    UISplitViewController *splitVC = [[UISplitViewController alloc] init];
    MADMasterTableViewController *masterVC = [[MADMasterTableViewController alloc] init];
    MADDetailViewController *detailVC = [[MADDetailViewController alloc] init];
    UINavigationController *masterNC = [[UINavigationController alloc] initWithRootViewController:masterVC];

    splitVC.viewControllers = @[masterNC];
    masterVC.detailVC = detailVC;
    splitVC.view.backgroundColor = [UIColor whiteColor];
    splitVC.delegate = self;

    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [_window makeKeyAndVisible];
    _window.rootViewController = splitVC;
    
    masterVC.managedObjectContext = [[MADCoreDataStack sharedCoreDataStack] managedObjectContext];
    
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    NSManagedObjectContext *context = [[MADCoreDataStack sharedCoreDataStack] managedObjectContext];
    NSError *error = nil;
    
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
}

#pragma mark - Split view

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
    if ([secondaryViewController isKindOfClass:[UINavigationController class]] && [[(UINavigationController *)secondaryViewController topViewController] isKindOfClass:[MADDetailViewController class]] && ([(MADDetailViewController *)[(UINavigationController *)secondaryViewController topViewController] detailItem] == nil)) {
        // Return YES to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
        return YES;
    } else {
        return NO;
    }
}

@end
