//
//  DetailViewModel.h
//  TinkoffNews
//
//  Created by Valeriy on 01/04/2017.
//  Copyright © 2017 Valeriy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DetailViewProtocol.h"
#import "DetailPresenterProtocol.h"
#import "DetailServiceProtocol.h"

@interface DetailPresenter : NSObject<DetailPresenterProtocol> {
    
}

@property (nonatomic, strong) NSString *newsId;
@property (nonatomic, weak) id<DetailViewProtocol> view;
@property (nonatomic, strong) id<DetailServiceProtocol> model;


@end
