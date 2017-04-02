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
    [self.model getNewsContentWithNewsId:self.newsId andCallback:^(NewsEntity *newsEntity, NSError *error) {
        [self.view hideLoading];
        if (error) {
            [self.view showError];
        } else {
            DetailViewData *detailViewData = [DetailViewData new];
            detailViewData.date = [StringUtils stringFromDate:newsEntity.creationDate];
            detailViewData.title = [StringUtils attributedStringWithHtmlString:newsEntity.text size:18.0 weight:UIFontWeightBold];
            detailViewData.content = [StringUtils attributedStringWithHtmlString:newsEntity.content size:15.0 weight:UIFontWeightRegular];
            [self.view updateNewsContent:detailViewData];
        }
    }];
}

@end
