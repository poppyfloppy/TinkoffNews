//
//  MasterServiceProtocol.h
//  TinkoffNews
//
//  Created by Valeriy on 02/04/2017.
//  Copyright © 2017 Valeriy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MasterServiceProtocol <NSObject>

- (void)updateNewsWithCallback:(void (^)(NSArray *, NSError *))callback;
- (void)getNewsWithCallback:(void (^)(NSArray *, NSError *))callback;

@end
