//
//  NewsInteractor.m
//  TinkoffNews
//
//  Created by Valeriy on 29/03/2017.
//  Copyright © 2017 Valeriy. All rights reserved.
//

#import "NewsInteractor.h"
#import "PayloadModel.h"

#define BASE_URL @"https://api.tinkoff.ru/v1/"

@implementation NewsInteractor

- (void)getNewsWithCallback:(void (^)(NSArray *))callback {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@news", BASE_URL]];
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
          if (!error) {
              NSMutableDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
              if ([jsonObject[@"resultCode"] isEqualToString:@"OK"]) {
                  NSArray *payloadsDicts = jsonObject[@"payload"];
                  NSMutableArray *array = [NSMutableArray arrayWithCapacity:[payloadsDicts count]];
                  for (int i = 0; i < [payloadsDicts count]; ++i) {
                      NSDictionary *payloadDict = payloadsDicts[i];
                      long ms = [payloadDict[@"publicationDate"][@"milliseconds"] longValue];
                      [array addObject:[[PayloadModel alloc] initWith:payloadDict[@"id"] text:payloadDict[@"text"] andPublicationDate:ms]];
                  }
                  callback(array);
              } else {
                  callback(nil);
              }
          } else {
              callback(nil);
          }
    }] resume];
}

- (void)getNewsContentWithId:(NSString *)payloadId andCallback:(void (^)())callback {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@news_content?id=%@", BASE_URL, payloadId]];
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            NSMutableDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            NSLog(@"%@", jsonObject);
            callback(jsonObject);
        } else {
//            callback();
        }
    }] resume];
}

@end
