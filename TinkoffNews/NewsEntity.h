//
//  NewsModel.h
//  TinkoffNews
//
//  Created by Valeriy on 30/03/2017.
//  Copyright © 2017 Valeriy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsEntity : NSObject

@property (nonatomic, strong) NSString *newsId;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSDate *creationDate;
@property (nonatomic, strong) NSString *content;

- (instancetype)initWith:(NSString *)newsId text:(NSString *)text content:(NSString *)content andCreationDate:(long)ms;

@end
