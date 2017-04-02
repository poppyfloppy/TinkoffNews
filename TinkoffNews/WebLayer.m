//
//  NewsInteractor.m
//  TinkoffNews
//
//  Created by Valeriy on 29/03/2017.
//  Copyright © 2017 Valeriy. All rights reserved.
//

#import "WebLayer.h"

#define BASE_URL @"https://api.tinkoff.ru/v1/"

@implementation WebLayer

- (void)getNewsWithCallback:(void (^)(NSArray *, NSError *))callback {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@news", BASE_URL]];
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            NSMutableDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            if ([jsonObject[@"resultCode"] isEqualToString:@"OK"]) {
                NSArray *payloadsDicts = jsonObject[@"payload"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    callback(payloadsDicts, nil);
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    callback(nil, [NSError new]);
                });
            }
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, error);
            });
        }
    }] resume];
}

- (void)getNewsContentWithId:(NSString *)payloadId andCallback:(void (^)(NSDictionary *, NSError *))callback {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@news_content?id=%@", BASE_URL, payloadId]];
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            NSMutableDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            if ([jsonObject[@"resultCode"] isEqualToString:@"OK"]) {
                NSDictionary *dict = jsonObject[@"payload"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    callback(dict, nil);
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    callback(nil, [NSError new]);
                });
            }
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, error);
            });
        }
    }] resume];
}

@end
