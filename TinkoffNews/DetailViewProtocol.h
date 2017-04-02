//
//  DetailViewProtocol.h
//  TinkoffNews
//
//  Created by Valeriy on 01/04/2017.
//  Copyright © 2017 Valeriy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DetailViewData.h"

@protocol DetailViewProtocol <NSObject>

- (void)updateNewsContent:(DetailViewData *)detailViewData;
- (void)showLoading;
- (void)hideLoading;
- (void)showError;

@end
