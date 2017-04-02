//
//  MasterViewModel.m
//  TinkoffNews
//
//  Created by Valeriy on 01/04/2017.
//  Copyright © 2017 Valeriy. All rights reserved.
//

#import "MasterPresenter.h"
#import "NewsTitleEntity.h"
#import "StringUtils.h"

@interface MasterPresenter () {
    NSArray *data;
}

@end

@implementation MasterPresenter

- (void)getNews {
    [self.view showLoading];
    [self.model getNewsWithCallback:^(NSArray *array, NSError *error) {
        [self.view hideLoading];
        if (error) {
            [self.view showError];
        } else {
            data = array;
            [self.view updateData:[self proccessToViewData:array]];
        }
    }];
}

- (void)updateNews {
    [self.model updateNewsWithCallback:^(NSArray *array, NSError *error) {
        [self.view hideLoading];
        if (error) {
            [self.view showError];
        } else {
            data = array;
            [self.view updateData:[self proccessToViewData:array]];
        }
    }];
}

- (NSArray *)proccessToViewData:(NSArray *)array {
    NSMutableArray *viewDataArray = [NSMutableArray arrayWithCapacity:array.count];
    for (int i = 0; i < array.count; ++i) {
        NewsTitleEntity *newsTitleEntity = array[i];
        MasterViewData *masterViewData = [MasterViewData new];
        masterViewData.date = [StringUtils stringFromDate:newsTitleEntity.publicationDate];
        masterViewData.title = [StringUtils attributedStringWithHtmlString:newsTitleEntity.text size:16.0 weight:UIFontWeightRegular];
        [viewDataArray addObject:masterViewData];
    }

    return [viewDataArray copy];
}

- (void)didSelectAtIndex:(NSInteger)index {
    NSString *newsId = ((NewsTitleEntity *)data[index]).newsId;
    [self.view toDetail:newsId];
}

@end
