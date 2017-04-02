//
//  NewsTitleEntity.h
//  TinkoffNews
//
//  Created by Valeriy on 02/04/2017.
//  Copyright © 2017 Valeriy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsTitleEntity : NSObject

@property (nonatomic, strong) NSString *newsId;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSDate *publicationDate;

- (instancetype)initWith:(NSString *)newsId text:(NSString *)text andPublicationDate:(long)ms;

@end
