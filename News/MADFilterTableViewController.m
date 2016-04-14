//
//  MADFilterTableViewController.m
//  News
//
//  Created by Mariia Cherniuk on 11.04.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import "MADFilterTableViewController.h"
#import "MADMasterTableViewController.h"

@interface MADFilterTableViewController ()

@property (strong, nonatomic, readwrite) NSArray *categories;

@end

@implementation MADFilterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    _categories = @[@"Football", @"Boxing", @"Tennis", @"Motorsport", @"News"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                   target:self
                                                                   action:@selector(closePressed)];
}

#pragma mark - Private

- (void)closePressed {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _categories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", _categories[indexPath.row]];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:22.0f];
    
    return cell;
}
 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_filterDelegat configureFetchedResultsControllerByValue:_categories[indexPath.row]];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
