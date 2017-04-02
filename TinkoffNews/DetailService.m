//
//  DetailService.m
//  TinkoffNews
//
//  Created by Valeriy on 02/04/2017.
//  Copyright © 2017 Valeriy. All rights reserved.
//

#import "DetailService.h"

@implementation DetailService

- (instancetype)init {
    if (self = [super init]) {
        self.newsService = [NewsService new];
    }
    
    return self;
}

- (void)getNewsContentWithNewsId:(NSString *)newsId andCallback:(void (^)(id<NewsProtocol>, NSError *))callback {
    [self.newsService getNewsContentWithNewsId:newsId andCallback:callback];
}

@end
