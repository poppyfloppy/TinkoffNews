//
//  StringUtils.h
//  TinkoffNews
//
//  Created by Valeriy on 01/04/2017.
//  Copyright © 2017 Valeriy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface StringUtils : NSObject

+ (NSAttributedString *)attributedStringWithHtmlString:(NSString *)string size:(NSUInteger)size weight:(CGFloat)weight;
+ (NSString *)stringFromDate:(NSDate *)date;

@end
