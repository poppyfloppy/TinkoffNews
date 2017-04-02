//
//  MasterPresenterProtocol.h
//  TinkoffNews
//
//  Created by Valeriy on 01/04/2017.
//  Copyright © 2017 Valeriy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MasterPresenterProtocol <NSObject>

- (void)updateNews;
- (void)getNews;
- (void)didSelectAtIndex:(NSInteger)index;

@end
