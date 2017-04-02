//
//  MasterViewController.m
//  TinkoffNews
//
//  Created by Valeriy on 01/04/2017.
//  Copyright © 2017 Valeriy. All rights reserved.
//

#import "MasterViewController.h"
#import "MasterTableViewCell.h"
#import "MasterViewData.h"

#import "DetailViewController.h"
#import "DetailPresenter.h"
#import "DetailService.h"

#define PAYLOAD_CELL @"payload_cell"

@interface MasterViewController () {
    UIActivityIndicatorView *bottomActivityIndicatorView;
}

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    [self initRefreshControl];
    [self.presenter getNews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark init
- (void)initTableView {
    [self.tableView setAlwaysBounceVertical:YES];
    [self.tableView registerNib:[UINib nibWithNibName:@"MasterTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:PAYLOAD_CELL];
    self.tableView.estimatedRowHeight = 50.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)initRefreshControl {
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor colorWithRed:254 / 255.0 green:214 / 255.0 blue:49 / 255.0 alpha:1.0];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self action:@selector(pullToRefresh:) forControlEvents:UIControlEventValueChanged];
}

- (void)pullToRefresh:(id)sender {
    [self.presenter updateNews];
}

#pragma mark ViewProtocol
- (void)updateData:(NSArray *)dataArray {
    _dataArray = dataArray;
    [self.tableView reloadData];
}

- (void)showLoading {
    if (!bottomActivityIndicatorView) {
        bottomActivityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        bottomActivityIndicatorView.frame = CGRectMake(0, 0, self.view.frame.size.width, 40.0);
    }
    [bottomActivityIndicatorView startAnimating];
    self.tableView.tableFooterView = bottomActivityIndicatorView;
}

- (void)hideLoading {
    if ([bottomActivityIndicatorView isAnimating]) {
        [bottomActivityIndicatorView stopAnimating];
        [bottomActivityIndicatorView setHidden:YES];
        self.tableView.tableFooterView = nil;
    }
    if ([self.refreshControl isRefreshing]) {
        [self.refreshControl endRefreshing];
    }
}

- (void)showError {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Ooops! Something went wrong. Will try later." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)toDetail:(NSString *)newsId {
    NSDictionary *dict = [NSDictionary dictionaryWithObject:newsId forKey:@"newsId"];
    [self performSegueWithIdentifier:@"showDetail" sender:dict];
}

#pragma mark - Segues
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        DetailViewController *view = (DetailViewController *)[segue destinationViewController];
        DetailPresenter *presenter = [DetailPresenter new];
        DetailService *model = [DetailService new];
        presenter.view = view;
        presenter.model = model;
        presenter.newsId = sender[@"newsId"];
        view.presenter = presenter;
    }
}

#pragma mark - Table View
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PAYLOAD_CELL forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    MasterViewData *masterViewData = self.dataArray[indexPath.row];
    ((MasterTableViewCell *)cell).payloadLabel.attributedText = masterViewData.title;
    ((MasterTableViewCell *)cell).dateLabel.text = masterViewData.date;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.presenter didSelectAtIndex:indexPath.row];
}

@end
