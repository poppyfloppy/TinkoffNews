//
//  PayloadViewController.m
//  TinkoffNews
//
//  Created by Valeriy on 01/04/2017.
//  Copyright © 2017 Valeriy. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailViewData.h"

@interface DetailViewController () {
    __weak IBOutlet UILabel *titleLabel;
    __weak IBOutlet UILabel *dateLabel;
    __weak IBOutlet UITextView *contentTextView;
    __weak IBOutlet UIActivityIndicatorView *activityIndicator;
    __weak IBOutlet UIView *contentView;
}

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.presenter getContentNews];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    titleLabel.preferredMaxLayoutWidth = titleLabel.frame.size.width;
    [self.view layoutIfNeeded];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark view methods
- (void)updateNewsContent:(DetailViewData *)detailViewData {
    [contentView setHidden:NO];
    titleLabel.attributedText = detailViewData.title;
    dateLabel.text = detailViewData.date;
    contentTextView.attributedText = detailViewData.content;
}

- (void)showLoading {
    [activityIndicator startAnimating];
}

- (void)hideLoading {
    [activityIndicator stopAnimating];
}

- (void)showError {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Ooops! Something went wrong. Will try later." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
