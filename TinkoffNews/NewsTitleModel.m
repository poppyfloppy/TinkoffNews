//
//  NewsTitleModel.m
//  TinkoffNews
//
//  Created by Valeriy on 02/04/2017.
//  Copyright © 2017 Valeriy. All rights reserved.
//

#import "NewsTitleModel.h"

@implementation NewsTitleModel

@dynamic newsId;
@dynamic text;
@dynamic publicationDate;

+ (instancetype)instanceWith:(NSString *)newsId text:(NSString *)text publicationDate:(NSDate *)publicationDate andContext:(NSManagedObjectContext *)context {
    NewsTitleModel *newsTitleModel = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([NewsTitleModel class]) inManagedObjectContext:context];
    newsTitleModel.newsId = newsId;
    newsTitleModel.text = text;
    newsTitleModel.publicationDate = publicationDate;
    
    return newsTitleModel;
}

@end
