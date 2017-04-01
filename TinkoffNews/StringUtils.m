//
//  StringUtils.m
//  TinkoffNews
//
//  Created by Valeriy on 01/04/2017.
//  Copyright © 2017 Valeriy. All rights reserved.
//

#import "StringUtils.h"

@implementation StringUtils

+ (NSAttributedString *)attributedStringWithHtmlString:(NSString *)string size:(NSUInteger)size weight:(CGFloat)weight {
    NSError *error = nil;
     NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithData:[string dataUsingEncoding:NSUTF16StringEncoding] options: @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error: &error];
    [attributedString addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:size weight:weight]} range:NSMakeRange(0, attributedString.length)];
    
    return attributedString;
}

+ (NSString *)stringFromDate:(NSDate *)date {
    static dispatch_once_t predicate;
    static NSDateFormatter *dateFormatter;
    dispatch_once(&predicate, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"d MMM YYYY"];
    });
    return [dateFormatter stringFromDate:date];
}

@end
