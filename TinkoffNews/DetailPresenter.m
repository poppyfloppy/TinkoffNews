//
//  DetailViewModel.m
//  TinkoffNews
//
//  Created by Valeriy on 01/04/2017.
//  Copyright © 2017 Valeriy. All rights reserved.
//

#import "DetailPresenter.h"
#import "StringUtils.h"
#import "DetailViewData.h"

@implementation DetailPresenter

- (void)getContentNews {
    [self.view showLoading];
    [self.model getNewsContentWithNewsId:self.newsId andCallback:^(id<NewsProtocol> newsEntity, NSError *error) {
        if (error) {
            [self.view hideLoading];
            [self.view showError];
        } else {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                DetailViewData *detailViewData = [DetailViewData new];
                detailViewData.date = [StringUtils stringFromDate:newsEntity.creationDate];
                detailViewData.title = [StringUtils attributedStringWithHtmlString:newsEntity.text size:18.0 weight:UIFontWeightBold];
                detailViewData.content = [StringUtils attributedStringWithHtmlStringAndImages:newsEntity.content size:15.0 weight:UIFontWeightRegular];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.view hideLoading];
                    [self.view updateNewsContent:detailViewData];
                });
            });
        }
    }];
}

@end
