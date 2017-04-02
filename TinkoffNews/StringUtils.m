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

//В некоторых новостях попадаются картинки намного больше ширины экрана
+ (NSAttributedString *)attributedStringWithHtmlStringAndImages:(NSString *)string size:(NSUInteger)size weight:(CGFloat)weight {
    NSAttributedString *attributedString = [StringUtils attributedStringWithHtmlString:string size:size weight:weight];
    [attributedString enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, attributedString.length) options:0 usingBlock:^(id value, NSRange range, BOOL *stop) {
        if (![value isKindOfClass:[NSTextAttachment class]]) {
            return;
        }
        NSTextAttachment *attachment = (NSTextAttachment *)value;
        UIImage *image = nil;
        if ([attachment image]) {
            image = [attachment image];
        } else {
            image = [attachment imageForBounds:[attachment bounds] textContainer:nil characterIndex:range.location];
        }
        CGSize size = image.size;
        if (size.width > [UIScreen mainScreen].bounds.size.width - 50) {
            float ratio = image.size.width / ([UIScreen mainScreen].bounds.size.width - 50);
            float height = image.size.height / ratio;
            size = CGSizeMake([UIScreen mainScreen].bounds.size.width - 50, height);
            attachment.bounds = CGRectMake(0, 0, size.width, size.height);
        }
    }];
    
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
