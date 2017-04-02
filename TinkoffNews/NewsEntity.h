//
//  NewsModel.h
//  TinkoffNews
//
//  Created by Valeriy on 30/03/2017.
//  Copyright © 2017 Valeriy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsProtocol.h"

@interface NewsEntity : NSObject<NewsProtocol>

- (instancetype)initWith:(NSString *)newsId text:(NSString *)text content:(NSString *)content andCreationDate:(long)ms;

@end
