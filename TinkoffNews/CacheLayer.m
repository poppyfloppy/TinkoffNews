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

- (void)clearAll {
    NSAssert([NSThread mainThread], @"Not main thread");
    NSTimeInterval startTime = [[NSDate date] timeIntervalSince1970];
    [self clear:NSStringFromClass([NewsTitleModel class])];
    [self clear:NSStringFromClass([NewsModel class])];
    NSTimeInterval endTime = [[NSDate date] timeIntervalSince1970];
    NSLog(@"time clear: %f", endTime - startTime);
}

- (void)clear:(NSString *)class {
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:class];
    NSBatchDeleteRequest *delete = [[NSBatchDeleteRequest alloc] initWithFetchRequest:request];
    NSError *deleteError = nil;
    [[CoreDataStack defaultStack].persistentStoreCoordinator executeRequest:delete withContext:[CoreDataStack defaultStack].managedObjectContext error:&deleteError];
}

- (void)getNewsTitleWithCallback:(void (^)(NSArray *, NSError *))callback {
    NSAssert([NSThread mainThread], @"Not main thread");
    NSTimeInterval startTime = [[NSDate date] timeIntervalSince1970];
    NSError *error;
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([NewsTitleModel class])];
    NSSortDescriptor *dateSort = [[NSSortDescriptor alloc] initWithKey:@"publicationDate" ascending:NO];
    [request setSortDescriptors:@[dateSort]];
    NSArray *newsTitlesArray = [[CoreDataStack defaultStack].managedObjectContext executeFetchRequest:request error:&error];
    NSTimeInterval endTime = [[NSDate date] timeIntervalSince1970];
    NSLog(@"time fetch: %f", endTime - startTime);
    dispatch_async(dispatch_get_main_queue(), ^{
        callback(newsTitlesArray, error);
    });
}

- (void)getNewsContentWith:(NSString *)newsId andCallback:(void (^)(NewsModel *, NSError *))callback {
    NSAssert([NSThread mainThread], @"Not main thread");
    NSError *error;
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([NewsModel class])];
    request.predicate = [NSPredicate predicateWithFormat:@"newsId = %@", newsId];
    NSArray *newsArray = [[CoreDataStack defaultStack].managedObjectContext executeFetchRequest:request error:&error];
    dispatch_async(dispatch_get_main_queue(), ^{
        callback([newsArray lastObject], error);
    });
}

- (BOOL)addNewsTitles:(NSArray *)newsTitlesArray {
    NSAssert([NSThread mainThread], @"Not main thread");
    NSTimeInterval startTime = [[NSDate date] timeIntervalSince1970];
    for (NewsTitleEntity *newsTitleEntity in newsTitlesArray) {
        [NewsTitleModel instanceWith:newsTitleEntity.newsId text:newsTitleEntity.text publicationDate:newsTitleEntity.publicationDate andContext:[CoreDataStack defaultStack].managedObjectContext];
    }
    NSError *error = [[CoreDataStack defaultStack] saveContext];
    NSTimeInterval endTime = [[NSDate date] timeIntervalSince1970];
    NSLog(@"time add: %f", endTime - startTime);
    
    return !error;
}

- (BOOL)addNewsTitle:(NewsTitleEntity *)newsTitleEntity {
    [NewsTitleModel instanceWith:newsTitleEntity.newsId text:newsTitleEntity.text publicationDate:newsTitleEntity.publicationDate andContext:[CoreDataStack defaultStack].managedObjectContext];
    NSError *error = [[CoreDataStack defaultStack] saveContext];
    
    return !error;
}

- (BOOL)addNewsContent:(NewsEntity *)newsEntity {
    NSAssert([NSThread mainThread], @"Not main thread");
    NewsModel *newsModel = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([NewsModel class]) inManagedObjectContext:[CoreDataStack defaultStack].managedObjectContext];
    newsModel.newsId = newsEntity.newsId;
    newsModel.text = newsEntity.text;
    newsModel.content = newsEntity.content;
    newsModel.creationDate = newsEntity.creationDate;
    NSError *error = [[CoreDataStack defaultStack] saveContext];
    
    return !error;
}

@end
