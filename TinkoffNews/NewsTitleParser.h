//
//  NewsTitleParser.h
//  TinkoffNews
//
//  Created by Valeriy on 02/04/2017.
//  Copyright © 2017 Valeriy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsTitleEntity.h"

@interface NewsTitleParser : NSObject

- (NSArray *)parseAll:(NSArray *)array;
- (NewsTitleEntity *)parse:(NSDictionary *)dict;

@end
