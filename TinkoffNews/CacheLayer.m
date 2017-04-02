//
//  CacheLayer.m
//  TinkoffNews
//
//  Created by Valeriy on 02/04/2017.
//  Copyright © 2017 Valeriy. All rights reserved.
//

#import "CacheLayer.h"
#import "CoreDataStack.h"

@implementation CacheLayer

- (void)clear {
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([NewsTitleModel class])];
    NSBatchDeleteRequest *delete = [[NSBatchDeleteRequest alloc] initWithFetchRequest:request];
    NSError *deleteError = nil;
    [[CoreDataStack defaultStack].persistentStoreCoordinator executeRequest:delete withContext:[CoreDataStack defaultStack].managedObjectContext error:&deleteError];
}

- (void)getNewsTitleWithCallback:(void (^)(NSArray *, NSError *))callback {
    NSError *error;
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([NewsTitleModel class])];
    NSSortDescriptor *dateSort = [[NSSortDescriptor alloc] initWithKey:@"publicationDate" ascending:YES];
    [request setSortDescriptors:@[dateSort]];
    NSArray *newsTitlesArray = [[CoreDataStack defaultStack].managedObjectContext executeFetchRequest:request error:&error];
    dispatch_async(dispatch_get_main_queue(), ^{
        callback(newsTitlesArray, error);
    });
}

- (void)getNewsContentWith:(NSString *)newsId andCallback:(void (^)(NewsModel *, NSError *))callback {
    NSError *error;
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([NewsModel class])];
    request.predicate = [NSPredicate predicateWithFormat:@"newsId = %@", newsId];
    NSArray *newsArray = [[CoreDataStack defaultStack].managedObjectContext executeFetchRequest:request error:&error];
    dispatch_async(dispatch_get_main_queue(), ^{
        callback([newsArray lastObject], error);
    });
}

- (BOOL)addNewsTitles:(NSArray *)newsTitlesArray {
    for (NewsTitleEntity *newsTitleEntity in newsTitlesArray) {
        [self addNewsTitle:newsTitleEntity];
    }
    
    return YES;
}

- (BOOL)addNewsTitle:(NewsTitleEntity *)newsTitleEntity {
    NewsTitleModel *newsTitleModel = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([NewsTitleModel class]) inManagedObjectContext:[CoreDataStack defaultStack].managedObjectContext];
    newsTitleModel.newsId = newsTitleEntity.newsId;
    newsTitleModel.text = newsTitleEntity.text;
    newsTitleModel.publicationDate = newsTitleEntity.publicationDate;
    [[CoreDataStack defaultStack] saveContext];
    
    return YES;
}

- (BOOL)addNewsContent:(NewsEntity *)newsEntity {
    NewsModel *newsModel = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([NewsModel class]) inManagedObjectContext:[CoreDataStack defaultStack].managedObjectContext];
    newsModel.newsId = newsEntity.newsId;
    newsModel.text = newsEntity.text;
    newsModel.content = newsEntity.content;
    newsModel.creationDate = newsEntity.creationDate;
    [[CoreDataStack defaultStack] saveContext];
    
    return YES;
}

@end
