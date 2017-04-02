//
//  NewsTitleEntity.m
//  TinkoffNews
//
//  Created by Valeriy on 02/04/2017.
//  Copyright © 2017 Valeriy. All rights reserved.
//

#import "NewsTitleEntity.h"

@implementation NewsTitleEntity

- (instancetype)init {
    return [self initWith:nil text:nil andPublicationDate:0];
}

- (instancetype)initWith:(NSString *)newsId text:(NSString *)text andPublicationDate:(long)ms {
    if (self = [super init]) {
        self.newsId = newsId;
        self.text = text;
        self.publicationDate = [NSDate dateWithTimeIntervalSince1970:(ms / 1000.0)];
    }
    
    return self;
}

@end
