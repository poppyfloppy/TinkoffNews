//
//  NewsModel.h
//  TinkoffNews
//
//  Created by Valeriy on 30/03/2017.
//  Copyright © 2017 Valeriy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayloadModel : NSObject

@property (nonatomic, strong) NSString *payloadId;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSDate *publicationDate;

- (instancetype)initWith:(NSString *)payloadId text:(NSString *)text andPublicationDate:(long)ms;

@end
