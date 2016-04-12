//
//  MADSelectTableViewController.m
//  News
//
//  Created by Mariia Cherniuk on 11.04.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import "MADSelectTableViewController.h"
#import "MADMasterTableViewController.h"

@interface MADSelectTableViewController ()

@property (strong, nonatomic, readwrite) NSArray *categories;

@end

@implementation MADSelectTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _categories = @[@"Football", @"Boxing", @"Tennis", @"Motorsport"];
    
//    UITapGestureRecognizer *tapToDismiss = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
//    [self.view addGestureRecognizer:tapToDismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private

- (void)close {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
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

}

@end
