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
#import "MADSelectTableViewController.h"
#import "MADBlurAnimator.h"

@interface MADMasterTableViewController () <NSFetchedResultsControllerDelegate, UIViewControllerTransitioningDelegate>

@property (strong, nonatomic, readwrite) NSArray *articles;

@end

@implementation MADMasterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [MADDownloader loadData];
    [self configureNavigationItem];
    
    self.view.backgroundColor = [UIColor whiteColor];
    _detailVC = [[MADDetailViewController alloc] init];
    _detailNC = [[UINavigationController alloc] initWithRootViewController:_detailVC];
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


- (IBAction)humburgerButtonPressed:(UIButton *)sender {
    MADSelectTableViewController *toViewController = [[MADSelectTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:toViewController];
//    UIImage *image = [UIImage imageNamed:@"close"];
//    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
//    [button setBackgroundImage:image forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(closePressed:) forControlEvents:UIControlEventTouchUpInside];
//    button.adjustsImageWhenHighlighted = NO;
//    
//    navigationController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
//    
//    navigationController.view.backgroundColor = [UIColor redColor];
    toViewController.transitioningDelegate = self;
    toViewController.modalPresentationStyle = UIModalPresentationCustom;
    
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (IBAction)closePressed:(UIButton *)sender {
    NSLog(@"close");
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];

    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MADCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil) {
        cell = [[MADCustomTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                             reuseIdentifier:@"Cell"];
    }
    
    MADArticle *cellObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.headline.text = [NSString stringWithFormat:@"%@", [[cellObject.title substringFromIndex:1] uppercaseString]];
    cell.category.text = [NSString stringWithFormat:@"%@", [cellObject.category uppercaseString]];

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
    
    [fetchRequest setEntity:entity];
    [fetchRequest setFetchBatchSize:20];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
    
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc]
                                                             initWithFetchRequest:fetchRequest
                                                             managedObjectContext:self.managedObjectContext
                                                               sectionNameKeyPath:nil
                                                                        cacheName:@"Master"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
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
            [tableView deleteRowsAtIndexPaths:[NSArray
                                               arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray
                                               arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id )sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
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
    
    return [[MADBlurAnimator alloc] init];
}

//- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
//    
//    return [[MADBlurAnimator alloc] init];
//}
//

@end
