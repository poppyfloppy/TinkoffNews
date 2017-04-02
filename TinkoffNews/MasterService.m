//
//  MasterService.m
//  TinkoffNews
//
//  Created by Valeriy on 02/04/2017.
//  Copyright © 2017 Valeriy. All rights reserved.
//

#import "MasterService.h"

@implementation MasterService

- (instancetype)init {
    if (self = [super init]) {
        self.newsService = [NewsService new];
    }
    
    return self;
}

#pragma mark methods
- (void)getNewsWithCallback:(void (^)(NSArray *, NSError *))callback {
    [self.newsService getNewsWithCallback:callback];
}

- (void)updateNewsWithCallback:(void (^)(NSArray *, NSError *))callback {
    [self.newsService updateNewsWithCallback:callback];
}

@end
