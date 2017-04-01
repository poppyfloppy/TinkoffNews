//
//  NewsInteractor.h
//  TinkoffNews
//
//  Created by Valeriy on 29/03/2017.
//  Copyright © 2017 Valeriy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsInteractor : NSObject

- (void)getNewsWithCallback:(void (^)(NSArray *))callback;
- (void)getNewsContentWithId:(NSString *)payloadId andCallback:(void (^)(NSDictionary *))callback;

@end
