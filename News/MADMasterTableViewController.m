//
//  MADMasterTableViewController.m
//  News
//
//  Created by Mariia Cherniuk on 19.03.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import "MADMasterTableViewController.h"
#import "MADArticle.h"
#import "MADDownloader.h"
#import "MADDetailViewController.h"
#import "MADCustomTableViewCell.h"
#import "MADFilterTableViewController.h"
#import "MADAnimator.h"
#import "MADFilterTableViewControllerDelegate.h"

@interface MADMasterTableViewController () <NSFetchedResultsControllerDelegate, UIViewControllerTransitioningDelegate, MADFilterTableViewControllerDelegate>

@property (strong, nonatomic, readwrite) NSArray *articles;

@end

@implementation MADMasterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [MADDownloader loadDataWithComplitionBlock:^{
    }];
    [self configureNavigationItem];
    [self configureRefreshControl];
  
    self.view.backgroundColor = [UIColor whiteColor];
    _detailVC = [[MADDetailViewController alloc] init];
    _detailNC = [[UINavigationController alloc] initWithRootViewController:_detailVC];
}

- (void)configureRefreshControl {
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor whiteColor];
    self.refreshControl.tintColor = [UIColor redColor];
    [self.refreshControl addTarget:self
                            action:@selector(refreshControlRequest)
                  forControlEvents:UIControlEventValueChanged];
}

- (void)configureNavigationItem {
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:nil
                                                                            action:nil];
    
    UIImage *image = [UIImage imageNamed:@"humburgerButton"];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(humburgerButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    button.adjustsImageWhenHighlighted = NO;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"skySports"]];
}

- (void)refreshControlRequest {
    [MADDownloader loadDataWithComplitionBlock:^{
        [self.refreshControl endRefreshing];
    }];
}

- (IBAction)humburgerButtonPressed:(UIButton *)sender {
    MADFilterTableViewController *toViewController = [[MADFilterTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:toViewController];
    
    toViewController.filterDelegat = self;
    navigationController.transitioningDelegate = self;
    navigationController.modalPresentationStyle = UIModalPresentationCustom;
    
    [self presentViewController:navigationController animated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.fetchedResultsController.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = self.fetchedResultsController.sections[section];

    return sectionInfo.numberOfObjects;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MADCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil) {
        cell = [[MADCustomTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                             reuseIdentifier:@"Cell"];
    }
    
    MADArticle *cellObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.headlineLabel.text = [NSString stringWithFormat:@"%@", [[cellObject.title substringFromIndex:1] uppercaseString]];
    cell.categoryLabel.text = [NSString stringWithFormat:@"%@", [cellObject.category uppercaseString]];

    if (cellObject.image == nil) {
        [MADDownloader loadImageWithURL:cellObject.imageURL complitionBlock:^(NSData *image) {
            cellObject.image = image;
        }];
        cell.articleCellImageView.image = [UIImage imageNamed:@"noImage.png"];
    } else {
        cell.articleCellImageView.image = [UIImage imageWithData:cellObject.image];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MADArticle *article = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    _detailVC.detailItem = article;
    [self.splitViewController showDetailViewController:_detailNC sender:nil];
    _detailVC.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
    _detailVC.navigationItem.leftItemsSupplementBackButton = YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"MADArticle" inManagedObjectContext:self.managedObjectContext];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
    
    [fetchRequest setEntity:entity];
    [fetchRequest setFetchBatchSize:20];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc]
                                                             initWithFetchRequest:fetchRequest
                                                             managedObjectContext:self.managedObjectContext
                                                               sectionNameKeyPath:nil
                                                                        cacheName:nil];
    aFetchedResultsController.delegate = self;
    _fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![_fetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    
    return _fetchedResultsController;
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeMove:
            [self.tableView deleteRowsAtIndexPaths:[NSArray
                                               arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray
                                               arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeMove:
            NSLog(@"A table item was moved");
            break;
            
        case NSFetchedResultsChangeUpdate:
            NSLog(@"A table item was updated");
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
    [self.tableView endUpdates];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    MADAnimator *animator = [[MADAnimator alloc] init];
    
    animator.presenting = YES;
    
    return animator;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    MADAnimator *animator = [[MADAnimator alloc] init];
    
    animator.presenting = NO;
    
    return animator;
}

#pragma mark - MADFilterTableViewControllerDelegate

- (void)configureTabelViewWithOption:(NSString *)option {
//    configure fetchedResultsController
    NSPredicate *predicate = nil;
    
    if (![option isEqualToString:@"News"]) {
        predicate = [NSPredicate predicateWithFormat:@"category = %@", [option lowercaseString]];
        self.navigationItem.title = [option uppercaseString];
        self.navigationItem.titleView = nil;
    } else {
        self.navigationItem.titleView = [[UIImageView alloc] initWithImage:
                                         [UIImage imageNamed:@"skySports"]];
    }
    self.fetchedResultsController.fetchRequest.predicate = predicate;
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    
//    at the top of the list
    [self.tableView reloadData];
    [self.tableView setContentOffset:CGPointMake(0.f, -([UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.frame.size.height)) animated:YES];
}

@end
