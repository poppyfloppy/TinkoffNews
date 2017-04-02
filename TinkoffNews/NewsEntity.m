//
//  NewsModel.m
//  TinkoffNews
//
//  Created by Valeriy on 30/03/2017.
//  Copyright © 2017 Valeriy. All rights reserved.
//

#import "NewsEntity.h"

@implementation NewsEntity

- (instancetype)initWith:(NSString *)newsId text:(NSString *)text content:(NSString *)content andCreationDate:(long)ms {
    if (self = [super init]) {
        self.newsId = newsId;
        self.text = text;
        self.content = content;
        self.creationDate = [NSDate dateWithTimeIntervalSince1970:(ms / 1000.0)];
    }
    
    return self;
}

@end
