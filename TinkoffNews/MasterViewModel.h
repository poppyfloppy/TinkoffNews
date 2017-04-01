//
//  MasterViewModel.h
//  TinkoffNews
//
//  Created by Valeriy on 31/03/2017.
//  Copyright © 2017 Valeriy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MasterViewModel : NSObject {
    
}

@property (nonatomic, strong) NSArray *dataArray;

- (void)updateData;
- (NSInteger)numberOfSections;
- (NSInteger)numberOfItemsInSection:(NSInteger)section;
- (NSAttributedString *)titleAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)dateAtIndexPath:(NSIndexPath *)indexPath;

@end
