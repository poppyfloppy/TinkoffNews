//
//  DetailService.h
//  TinkoffNews
//
//  Created by Valeriy on 02/04/2017.
//  Copyright © 2017 Valeriy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DetailServiceProtocol.h"
#import "NewsService.h"

@interface DetailService : NSObject <DetailServiceProtocol>

@property (nonatomic, strong) NewsService *newsService;

@end
