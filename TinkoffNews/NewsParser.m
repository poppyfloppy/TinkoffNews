//
//  NewsParser.m
//  TinkoffNews
//
//  Created by Valeriy on 02/04/2017.
//  Copyright © 2017 Valeriy. All rights reserved.
//

#import "NewsParser.h"

@implementation NewsParser

- (NewsEntity *)parse:(NSDictionary *)dict {
    long ms = [dict[@"creationDate"][@"milliseconds"] longValue];
    NewsEntity *newEntity = [[NewsEntity alloc] initWith:dict[@"title"][@"id"] text:dict[@"title"][@"text"] content:dict[@"content"] andCreationDate:ms];
    
    return newEntity;
}

@end
