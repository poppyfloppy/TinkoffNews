//
//  NewsModel.m
//  TinkoffNews
//
//  Created by Valeriy on 30/03/2017.
//  Copyright © 2017 Valeriy. All rights reserved.
//

#import "PayloadModel.h"

@implementation PayloadModel

- (instancetype)init {
    return [self initWith:nil text:nil andPublicationDate:0];
}

- (instancetype)initWith:(NSString *)payloadId text:(NSString *)text andPublicationDate:(long)ms {
    if (self = [super init]) {
        self.payloadId = payloadId;
        self.text = text;
        self.publicationDate = [NSDate dateWithTimeIntervalSince1970:(ms / 1000.0)];
    }
    
    return self;
}

@end
