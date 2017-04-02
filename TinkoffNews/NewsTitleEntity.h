//
//  NewsTitleEntity.h
//  TinkoffNews
//
//  Created by Valeriy on 02/04/2017.
//  Copyright © 2017 Valeriy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsTitleProtocol.h"

@interface NewsTitleEntity : NSObject<NewsTitleProtocol>

- (instancetype)initWith:(NSString *)newsId text:(NSString *)text andPublicationDate:(long)ms;

@end
