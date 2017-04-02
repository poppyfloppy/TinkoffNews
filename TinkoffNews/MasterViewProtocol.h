//
//  MasterViewProtocol.h
//  TinkoffNews
//
//  Created by Valeriy on 01/04/2017.
//  Copyright © 2017 Valeriy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MasterViewProtocol <NSObject>

- (void)showLoading;
- (void)hideLoading;
- (void)showError;
- (void)updateData:(NSArray *)dataArray;
- (void)toDetail:(NSString *)newsId;

@end
