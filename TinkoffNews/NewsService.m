//
//  NewsService.m
//  TinkoffNews
//
//  Created by Valeriy on 01/04/2017.
//  Copyright © 2017 Valeriy. All rights reserved.
//

#import "NewsService.h"

@implementation NewsService

- (instancetype)init {
    if (self = [super init]) {
        self.cacheLayer = [CacheLayer new];
        self.webLayer = [WebLayer new]; 
        self.newsParser = [NewsParser new];
        self.newsTitleParser = [NewsTitleParser new];
    }
    
    return self;
}

#pragma mark methods
- (void)updateNewsWithCallback:(void (^)(NSArray *, NSError *))callback {
    [self.cacheLayer clearAll];
    [self getNewsWithCallback:callback];
}

- (void)getNewsWithCallback:(void (^)(NSArray *, NSError *))callback {
    [self.cacheLayer getNewsTitleWithCallback:^(NSArray *array1, NSError *error1) {
        if (error1) {
            callback(nil, error1);
        } else if (array1.count > 0) {
            callback(array1, nil);
        } else {
            [self.webLayer getNewsWithCallback:^(NSArray *array2, NSError *error2) {
                if (error2) {
                    callback(nil, error2);
                } else {
                    NSArray *newsTitleEntitiesArray = [self.newsTitleParser parseAll:array2];
                    [self.cacheLayer addNewsTitles:newsTitleEntitiesArray];
                    callback(newsTitleEntitiesArray, nil);
                }
            }];
        }
    }];
}

- (void)getNewsContentWithNewsId:(NSString *)newsId andCallback:(void (^)(id<NewsProtocol>, NSError *))callback {
    [self.cacheLayer getNewsContentWith:newsId andCallback:^(NewsModel *newsModel, NSError *error1) {
        if (error1) {
            callback(nil, error1);
        } else if (newsModel) {
            callback(newsModel, nil);
        } else {
            [self.webLayer getNewsContentWithId:newsId andCallback:^(NSDictionary *dict, NSError *error2) {
                if (error2) {
                    callback(nil, error2);
                } else {
                    NewsEntity *newsEntity = [self.newsParser parse:dict];
                    [self.cacheLayer addNewsContent:newsEntity];
                    callback([self.newsParser parse:dict], nil);
                }
            }];
        }
    }];
}

@end
