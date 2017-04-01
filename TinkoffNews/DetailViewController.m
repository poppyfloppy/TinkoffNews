//
//  PayloadViewController.m
//  TinkoffNews
//
//  Created by Valeriy on 30/03/2017.
//  Copyright © 2017 Valeriy. All rights reserved.
//

#import "DetailViewController.h"
#import "NewsInteractor.h"

@interface DetailViewController () {
    __weak IBOutlet UILabel *titleLabel;
    __weak IBOutlet UILabel *dateLabel;
    __weak IBOutlet UILabel *contentLabel;
}

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NewsInteractor *newsInteractor = [NewsInteractor new];
    [newsInteractor getNewsContentWithId:@"7944" andCallback:^(NSDictionary *dict) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSError *err = nil;
            titleLabel.attributedText = [[NSAttributedString alloc]
                                         initWithData: [dict[@"payload"][@"title"][@"text"] dataUsingEncoding:NSUTF16StringEncoding]
                                         options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSFontAttributeName : [UIFont boldSystemFontOfSize:17] }
                                         documentAttributes: nil
                                         error: &err];
            NSLog(@"body label: %f", contentLabel.preferredMaxLayoutWidth);
            NSAttributedString *attrString= [[NSAttributedString alloc]
                                             initWithData: [dict[@"payload"][@"content"] dataUsingEncoding:NSUTF16StringEncoding]
                                             options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSFontAttributeName : [UIFont systemFontOfSize:15] }
                                             documentAttributes: nil
                                             error: &err];
            contentLabel.attributedText = attrString;
        });
    }];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    contentLabel.preferredMaxLayoutWidth = contentLabel.frame.size.width;
    [self.view layoutIfNeeded];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
