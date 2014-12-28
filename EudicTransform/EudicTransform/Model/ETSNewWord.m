//
//  ETSNewWord.m
//  EudicTransform
//
//  Created by stone win on 12/27/14.
//  Copyright (c) 2014 stone win. All rights reserved.
//

#import "ETSNewWord.h"
#import "HTMLNode.h"

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

- (NSArray *)validChildren {
    return [self validChildrenWithConditionHandler:^BOOL(HTMLNode *child) {
        NSString *rawContents = [[child rawContents] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        return (rawContents.length > 0);
    }];
}

@end

@interface ETSNewWord ()

@property (nonatomic, strong) HTMLNode *node;
@property (nonatomic, strong) HTMLNode *contentNode;

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
        _word = [validChildren[1] allContents];
        _contentNode = validChildren[2];
        _content = [self.contentNode rawContents];
        
//        NSArray *subNodes = [_contentNode validChildrenWithConditionHandler:^BOOL(HTMLNode *child) {
//            NSString *allContents = [[child allContents] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//            if (allContents.length > 0)
//            {
//                return YES;
//            }
//            else
//            {
//                NSLog(@"%@", [child rawContents]);
//                return NO;
//            }
//        }];
//        NSLog(@"%d", subNodes.count);
//        for (HTMLNode *subnode in subNodes)
//        {
//            NSLog(@"%@ %@", [subnode allContents], [subnode rawContents]);
//        }
    }
    return self;
}

- (NSString *)serialNumber {
    NSString *serialNumber = [_serialNumber stringByReplacingOccurrencesOfString:@"No." withString:@""];
    return serialNumber;
}

- (NSString *)content {
//    NSString *content = [_content stringByReplacingOccurrencesOfString:@"\"" withString:@"'"];
//    return content;
    {
        NSString *content = nil;
        NSError *error = nil;
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\ *\\w+=.*?>" options:NSRegularExpressionCaseInsensitive|NSRegularExpressionDotMatchesLineSeparators error:&error];
        if (nil != error)
        {
            NSLog(@"%s create regex error:\n\t%@", __func__, error);
        }
        else
        {
            content = [regex stringByReplacingMatchesInString:_content options:0 range:NSMakeRange(0, _content.length) withTemplate:@">"];
            
            regex = [NSRegularExpression regularExpressionWithPattern:@"</*br>" options:NSRegularExpressionDotMatchesLineSeparators|NSRegularExpressionCaseInsensitive error:&error];
            content = [regex stringByReplacingMatchesInString:content options:0 range:NSMakeRange(0, content.length) withTemplate:@""];
        }
        return content;
    }
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p; No.%@ %@>", NSStringFromClass([self class]), self, self.serialNumber, self.word];
}

@end
