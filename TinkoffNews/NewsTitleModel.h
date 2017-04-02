//
//  NewsTitleModel.h
//  TinkoffNews
//
//  Created by Valeriy on 02/04/2017.
//  Copyright © 2017 Valeriy. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "NewsTitleProtocol.h"

@interface NewsTitleModel : NSManagedObject<NewsTitleProtocol>

+ (instancetype)instanceWith:(NSString *)newsId text:(NSString *)text publicationDate:(NSDate *)publicationDate andContext:(NSManagedObjectContext *)context;

@end
