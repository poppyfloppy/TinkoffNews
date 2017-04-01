//
//  MasterViewController.m
//  TinkoffNews
//
//  Created by Valeriy on 29/03/2017.
//  Copyright © 2017 Valeriy. All rights reserved.
//

#import "MasterViewController.h"
#import "MasterTableViewCell.h"
#import "DetailViewController.h"
#import "NewsInteractor.h"

#define PAYLOAD_CELL @"payload_cell"

@interface MasterViewController ()

@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    [self initRefreshControl];
//    [self.viewModel updateData];
    [self.viewModel addObserver:self forKeyPath:@"dataArray" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [self.viewModel removeObserver:self forKeyPath:@"dataArray"];
}

#pragma mark init
- (void)initTableView {
    [self.tableView setAlwaysBounceVertical:YES];
    [self.tableView registerNib:[UINib nibWithNibName:@"MasterTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:PAYLOAD_CELL];
    self.tableView.estimatedRowHeight = 44.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)initRefreshControl {
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor colorWithRed:254 / 255.0 green:214 / 255.0 blue:49 / 255.0 alpha:1.0];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self action:@selector(updateData:) forControlEvents:UIControlEventValueChanged];
}

- (void)updateData:(id)sender {
    [self.viewModel updateData];
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"dataArray"]) {
        if ([self.refreshControl isRefreshing]) {
            [self.refreshControl endRefreshing];
        }
        [self.tableView reloadData];
    }
}

#pragma mark - Segues
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        //NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        //DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
    }
}

#pragma mark - Table View
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.viewModel numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel numberOfItemsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PAYLOAD_CELL forIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self configureCell:cell atIndexPath:indexPath];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    ((MasterTableViewCell *)cell).payloadLabel.attributedText = [self.viewModel titleAtIndexPath:indexPath];
    ((MasterTableViewCell *)cell).dateLabel.text = [self.viewModel dateAtIndexPath:indexPath];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"showDetail" sender:tableView];
}

@end
