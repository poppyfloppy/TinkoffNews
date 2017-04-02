//
//  DetailServiceProtcol.h
//  TinkoffNews
//
//  Created by Valeriy on 02/04/2017.
//  Copyright © 2017 Valeriy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsEntity.h"

@protocol DetailServiceProtocol <NSObject>

- (void)getNewsContentWithNewsId:(NSString *)newsId andCallback:(void (^)(NewsEntity *, NSError *))callback;

@end
