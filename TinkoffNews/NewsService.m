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
    [self getNewsWithCallback:callback];
}

- (void)getNewsWithCallback:(void (^)(NSArray *, NSError *))callback {
    [self.cacheLayer getNewsTitleWithCallback:^(NSArray *array, NSError *error) {
        if (error) {
            callback(nil, error);
        } else {
            
        }
    }];
    
    [self.webLayer getNewsWithCallback:^(NSArray *array, NSError *error) {
        if (error) {
            callback(nil, error);
        } else {
            NSArray *newsTitleEntitiesArray = [self.newsTitleParser parseAll:array];
            [self.cacheLayer addNewsTitles:newsTitleEntitiesArray];
            callback(newsTitleEntitiesArray, nil);
        }
    }];
}

- (void)getNewsContentWithNewsId:(NSString *)newsId andCallback:(void (^)(NewsEntity *, NSError *))callback {
    [self.webLayer getNewsContentWithId:newsId andCallback:^(NSDictionary *dict, NSError *error) {
        if (error) {
            callback(nil, error);
        } else {
            callback([self.newsParser parse:dict], nil);
        }
    }];
}

@end
