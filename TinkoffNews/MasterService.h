//
//  MasterService.h
//  TinkoffNews
//
//  Created by Valeriy on 02/04/2017.
//  Copyright © 2017 Valeriy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MasterServiceProtocol.h"
#import "NewsService.h"

@interface MasterService : NSObject <MasterServiceProtocol>

@property (nonatomic, strong) NewsService *newsService;

@end
