//
//  MasterViewController.h
//  TinkoffNews
//
//  Created by Valeriy on 29/03/2017.
//  Copyright © 2017 Valeriy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "TinkoffNews+CoreDataModel.h"
#import "MasterViewModel.h"

@class DetailViewController;

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) MasterViewModel *viewModel;

@property (strong, nonatomic) DetailViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController<Event *> *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


@end

