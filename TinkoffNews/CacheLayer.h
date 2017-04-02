//
//  CacheLayer.h
//  TinkoffNews
//
//  Created by Valeriy on 02/04/2017.
//  Copyright © 2017 Valeriy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsEntity.h"
#import "NewsTitleEntity.h"

@interface CacheLayer : NSObject

- (void)getNewsTitleWithCallback:(void (^)(NSArray *, NSError *))callback;
- (void)getNewsContentWith:(NSString *)newsId andCallback:(void (^)(NSArray *, NSError *))callback;

- (BOOL)addNewsTitles:(NSArray *)newsTitlesArray;
- (BOOL)addNewsTitle:(NewsTitleEntity *)newsTitleEntity;

- (BOOL)addNewsContent:(NewsEntity *)newsEntity;

@end
