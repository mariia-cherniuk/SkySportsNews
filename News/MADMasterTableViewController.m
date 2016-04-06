//
//  MADMasterTableViewController.m
//  News
//
//  Created by Mariia Cherniuk on 19.03.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import "MADMasterTableViewController.h"
#import "MADArticle.h"
#import "MADDetailViewController.h"
#import "MADDownloader.h"
#import "MADCustomTableViewCell.h"

@interface MADMasterTableViewController () <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic, readwrite) NSArray *articles;

@end

@implementation MADMasterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"New York Times";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:nil
                                                                            action:nil];
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh:)];
    self.navigationItem.rightBarButtonItem = refreshButton;
    
    self.view.backgroundColor = [UIColor whiteColor];
    _detailVC = [[MADDetailViewController alloc] init];
    _detailNC = [[UINavigationController alloc] initWithRootViewController:_detailVC];
    [self loadArticles];
//    [[UINavigationBar appearance] setBarTintColor:[UIColor redColor]];
}

- (void)loadArticles {
    [MADDownloader loadDataWithCompletionBlock:^(NSArray *articles) {
//        for (NSDictionary *article in articles) {
//            [MADDownloader loadImageWithURL:[[NSURL alloc] initWithString:article[@"multimedia"][@"src"]]];
//        }
    }];
}

- (IBAction)refresh:(UIButton *)sender {
    
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
        cell = [[MADCustomTableViewCell alloc] initWithStyle:
                UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    
    MADArticle *cellObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
//    MADArticle *cellObject = (MADArticle *)[_articles objectAtIndex:indexPath.row];

    cell.headline.text = [NSString stringWithFormat:@"%@", cellObject.headline];
    cell.author.text = [NSString stringWithFormat:@"%@", cellObject.author];
    cell.imageView.frame = cell.image.frame;
    
    if (!cellObject.image) {
//        [MADDownloader loadImageWithURL:[[NSURL alloc] initWithString:cellObject.multimedia[@"src"]] completionBlock:^(UIImage *image) {
//            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
//            cellObject.image = image;
//        }];
        cell.imageView.image = [UIImage imageNamed:@"placeholder.png"];
    } else {
        cell.imageView.image = cellObject.image;
    }
    
    NSLog(@"%@", cell.imageView.image);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MADArticle *article = _articles[indexPath.row];
    
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
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"MADArticle" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"updatedDate" ascending:YES];
    
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                                                managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Master"];
//    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    
    return _fetchedResultsController;
}

@end
