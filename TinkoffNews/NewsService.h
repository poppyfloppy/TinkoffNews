//
//  NewsService.h
//  TinkoffNews
//
//  Created by Valeriy on 01/04/2017.
//  Copyright © 2017 Valeriy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CacheLayer.h"
#import "WebLayer.h"
#import "NewsProtocol.h"
#import "NewsTitleEntity.h"
#import "NewsParser.h"
#import "NewsTitleParser.h"

@interface NewsService : NSObject {
    
}

@property (nonatomic, strong) CacheLayer *cacheLayer;
@property (nonatomic, strong) WebLayer *webLayer;
@property (nonatomic, strong) NewsParser *newsParser;
@property (nonatomic, strong) NewsTitleParser *newsTitleParser;

- (void)updateNewsWithCallback:(void (^)(NSArray *, NSError *))callback;
- (void)getNewsWithCallback:(void (^)(NSArray *, NSError *))callback;
- (void)getNewsContentWithNewsId:(NSString *)newsId andCallback:(void (^)(id<NewsProtocol>, NSError *))callback;


@end
