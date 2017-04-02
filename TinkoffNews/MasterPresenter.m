//
//  MasterViewModel.m
//  TinkoffNews
//
//  Created by Valeriy on 01/04/2017.
//  Copyright © 2017 Valeriy. All rights reserved.
//

#import "MasterPresenter.h"
#import "NewsTitleProtocol.h"
#import "StringUtils.h"

@interface ProcessOperation : NSOperation {
    
}

@property (nonatomic, copy) NSArray *array;
@property (nonatomic, copy) void (^callback)(NSArray *);

@end

@implementation ProcessOperation

- (void)main {
    @autoreleasepool {
        NSMutableArray *viewDataArray = [NSMutableArray arrayWithCapacity:self.array.count];
        for (int i = 0; i < self.array.count; ++i) {
            if ([self isCancelled]) {
                return;
            }
            id<NewsTitleProtocol> newsTitleEntity = self.array[i];
            MasterViewData *masterViewData = [MasterViewData new];
            masterViewData.date = [StringUtils stringFromDate:newsTitleEntity.publicationDate];
            masterViewData.title = [StringUtils attributedStringWithHtmlString:newsTitleEntity.text size:16.0 weight:UIFontWeightRegular];
            [viewDataArray addObject:masterViewData];
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.callback(viewDataArray);
        });
    }
}

@end

@interface MasterPresenter () {
    NSArray *data;
    NSOperationQueue *operationQueue;
}

@end

@implementation MasterPresenter

- (instancetype)init {
    if (self = [super init]) {
        operationQueue = [NSOperationQueue new];
    }
    
    return self;
}

- (void)getNews {
    [self.view showLoading];
    [self.model getNewsWithCallback:^(NSArray *array, NSError *error) {
        if (error) {
            [self.view hideLoading];
            [self.view showError];
        } else {
            data = array;
            [self proccessToViewData:array andCallback:^(NSArray *proccessedArray) {
                [self.view hideLoading];
                [self.view updateData:proccessedArray];
            }];
        }
    }];
}

- (void)updateNews {
    [self.model updateNewsWithCallback:^(NSArray *array, NSError *error) {
        if (error) {
            [self.view hideLoading];
            [self.view showError];
        } else {
            data = array;
            [self proccessToViewData:array andCallback:^(NSArray *proccessedArray) {
                [self.view hideLoading];
                [self.view updateData:proccessedArray];
            }];
        }
    }];
}

- (void)proccessToViewData:(NSArray *)array andCallback:(void(^)(NSArray *))callback {
    //Отменяем предыдущие операции обработки (если они доступны)
    [operationQueue cancelAllOperations];
    ProcessOperation *processOperation = [ProcessOperation new];
    [processOperation setArray:array];
    [processOperation setCallback:callback];
    [operationQueue addOperation:processOperation];
}

- (void)didSelectAtIndex:(NSInteger)index {
    NSString *newsId = ((id<NewsTitleProtocol>)data[index]).newsId;
    [self.view toDetail:newsId];
}

@end
