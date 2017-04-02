//
//  NewsTitleProtocol.h
//  TinkoffNews
//
//  Created by Valeriy on 02/04/2017.
//  Copyright © 2017 Valeriy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NewsTitleProtocol <NSObject>

@property (nonatomic, strong) NSString *newsId;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSDate *publicationDate;

@end
