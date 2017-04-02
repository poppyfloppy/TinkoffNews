//
//  MasterViewModel.h
//  TinkoffNews
//
//  Created by Valeriy on 31/03/2017.
//  Copyright © 2017 Valeriy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MasterViewProtocol.h"
#import "MasterPresenterProtocol.h"
#import "MasterServiceProtocol.h"
#import "MasterViewData.h"

@interface MasterPresenter : NSObject <MasterPresenterProtocol> {
    
}

@property (nonatomic, weak) id<MasterViewProtocol> view;
@property (nonatomic, strong) id<MasterServiceProtocol> model;

@end
