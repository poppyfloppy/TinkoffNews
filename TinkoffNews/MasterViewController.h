//
//  MasterViewController.h
//  TinkoffNews
//
//  Created by Valeriy on 01/04/2017.
//  Copyright © 2017 Valeriy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MasterViewProtocol.h"
#import "MasterPresenterProtocol.h"

@interface MasterViewController : UITableViewController <MasterViewProtocol>

@property (nonatomic, strong) id<MasterPresenterProtocol> presenter;


@end

