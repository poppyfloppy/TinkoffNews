//
//  PayloadViewController.h
//  TinkoffNews
//
//  Created by Valeriy on 01/04/2017.
//  Copyright © 2017 Valeriy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailPresenterProtocol.h"
#import "DetailViewProtocol.h"

@interface DetailViewController : UIViewController<DetailViewProtocol> {
    
}

@property (nonatomic, strong) id<DetailPresenterProtocol> presenter;

@end
