//
//  ETSNewWord.m
//  EudicTransform
//
//  Created by stone win on 12/27/14.
//  Copyright (c) 2014 stone win. All rights reserved.
//

#import "ETSNewWord.h"
#import "HTMLNode.h"

#define ETS_DEBUG(string, ...) NSLog(string@"\n\t%s, %s:%d", __VA_ARGS__, __func__, __FILE__, __LINE__)

@implementation HTMLNode (ETSNewWord)

- (NSArray *)validChildrenWithConditionHandler:(BOOL(^)(HTMLNode *child))handler {
    NSArray *children = [self children];
    if (nil == handler)
    {
        return children;
    }
    
    NSMutableArray *filteredChildren = [NSMutableArray array];
    
    for (HTMLNode *child in children)
    {
        BOOL isValid = handler(child);
        if (isValid)
        {
            [filteredChildren addObject:child];
        }
    }
    
    return [filteredChildren copy];
}

/**
 replace the node that contains whitespace or new line
 */
- (NSArray *)validChildren {
    return [self validChildrenWithConditionHandler:^BOOL(HTMLNode *child) {
        NSString *rawContents = [[child rawContents] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        return (rawContents.length > 0);
    }];
}

@end

@implementation NSString (ETSNewWord)

- (NSString *)stringByReplacingOccurrencesOfPattern:(NSString *)pattern withString:(NSString *)replacement {
    if (![pattern isKindOfClass:[NSString class]])
    {
        return self;
    }
    
    NSError *error = nil;
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive | NSRegularExpressionDotMatchesLineSeparators error:&error];
    if (!error)
    {
        NSString *replaced = [regex stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, self.length) withTemplate:replacement];
        return replaced;
    }
    else
    {
        ETS_DEBUG(@"create regex error: %@", error);
    }
    return nil;
}

@end

@interface ETSNewWord ()

@property (nonatomic, strong) HTMLNode *node;

@end

@implementation ETSNewWord

- (instancetype)initWithHtmlNode:(HTMLNode *)node {
    self = [super init];
    if (self)
    {
        _node = node;
        
        NSArray *validChildren = [node validChildren];
        NSAssert(3 == validChildren.count, @"Please refact about index!");
        
        _serialNumber = [validChildren[0] allContents];
        _serialNumber = [_serialNumber stringByReplacingOccurrencesOfString:@"No." withString:@""];
        _word = [validChildren[1] allContents];
        _content = [validChildren[2] rawContents];
        // replace <td class="export-td"> to <td> | <div class="exp"> to <div>
        _content = [_content stringByReplacingOccurrencesOfPattern:@"\\ *\\w+=.*?>" withString:@">"];
        // replace <br> | </br> to <br />
        _content = [_content stringByReplacingOccurrencesOfPattern:@"</*br>" withString:@"<br />"];
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p; No.%@ %@>", NSStringFromClass([self class]), self, self.serialNumber, self.word];
}

@end
