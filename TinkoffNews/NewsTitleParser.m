//
//  NewsTitleParser.m
//  TinkoffNews
//
//  Created by Valeriy on 02/04/2017.
//  Copyright © 2017 Valeriy. All rights reserved.
//

#import "NewsTitleParser.h"

@implementation NewsTitleParser

- (NSArray *)parseAll:(NSArray *)array {
    NSMutableArray *newsArray = [NSMutableArray arrayWithCapacity:array.count];
    for (int i = 0; i < [array count]; ++i) {
        [newsArray addObject:[self parse:array[i]]];
    }
    
    return [newsArray copy];
}

- (NewsTitleEntity *)parse:(NSDictionary *)dict {
    long ms = [dict[@"publicationDate"][@"milliseconds"] longValue];
    NewsTitleEntity *newsTitleEntity = [[NewsTitleEntity alloc] initWith:dict[@"id"] text:dict[@"text"] andPublicationDate:ms];
    
    return newsTitleEntity;
}

@end
