//
//  MasterViewModel.m
//  TinkoffNews
//
//  Created by Valeriy on 31/03/2017.
//  Copyright © 2017 Valeriy. All rights reserved.
//

#import "MasterViewModel.h"
#import "NewsInteractor.h"
#import "PayloadModel.h"
#import "StringUtils.h"
#import <UIKit/UIKit.h>

@interface MasterViewModel () {
    NSMutableDictionary *textsForIndexPath;
}

@end

@implementation MasterViewModel

- (instancetype)init {
    if (self = [super init]) {
        textsForIndexPath = [NSMutableDictionary new];
        self.dataArray = [NSArray new];
    }
    
    return self;
}

- (void)updateData {
    NewsInteractor *newsInteractor = [NewsInteractor new];
    [newsInteractor getNewsWithCallback:^(NSArray *array) {
        [self willChangeValueForKey:@"dataArray"];
        _dataArray = array;
        [self didChangeValueForKey:@"dataArray"];
    }];
}

- (NSInteger)numberOfSections {
    return 1;
}

- (NSInteger)numberOfItemsInSection:(NSInteger)section {
    return [self.dataArray count];
}

- (NSAttributedString *)titleAtIndexPath:(NSIndexPath *)indexPath {
    if (textsForIndexPath[indexPath]) {
        return textsForIndexPath[indexPath];
    } else {
        PayloadModel *payload = self.dataArray[indexPath.row];
        NSAttributedString *title = [StringUtils attributedStringWithHtmlString:payload.text size:16.0 weight:UIFontWeightRegular];
        textsForIndexPath[@"indexPath"] = title;
        return title;
    }
}

- (NSString *)dateAtIndexPath:(NSIndexPath *)indexPath {
    PayloadModel *payload = self.dataArray[indexPath.row];
    return [StringUtils stringFromDate:payload.publicationDate];
}

@end
