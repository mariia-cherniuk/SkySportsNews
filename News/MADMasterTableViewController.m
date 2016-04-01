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

@interface MADMasterTableViewController ()

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
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self loadArticles];
//    [[UINavigationBar appearance] setBarTintColor:[UIColor redColor]];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _articles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    MADArticle *cellObject = (MADArticle *)[_articles objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", cellObject.headline];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont systemFontOfSize:14.f];
    cell.textLabel.textColor = [UIColor blackColor];
    
    CGFloat width = [cellObject.multimedia[@"width"] floatValue];
    CGFloat height = [cellObject.multimedia[@"height"] floatValue];
    cell.imageView.frame = CGRectMake(0, 0, width, height);
    
    if (!cellObject.image) {
        [MADDownloader loadImageWithURL:[[NSURL alloc] initWithString:cellObject.multimedia[@"src"]] completionBlock:^(UIImage *image) {
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            cellObject.image = image;
        }];
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

- (void)loadArticles {
    [MADDownloader loadDataWithCompletionBlock:^(NSArray *articles) {
        _articles = articles;
        [self.tableView reloadData];
    }];
}

- (IBAction)refresh:(UIButton *)sender {
    
}

@end
