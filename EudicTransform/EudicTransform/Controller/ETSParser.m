//
//  ETSParser.m
//  EudicTransform
//
//  Created by stone win on 8/23/14.
//  Copyright (c) 2014 stone win. All rights reserved.
//

#import "ETSParser.h"
#import "ETSWord.h"
#import <pthread/pthread.h>
#import "HTMLParser.h"

@implementation NSRegularExpression (ETParser)

+ (NSRegularExpression *)regexWithPattern:(NSString *)pattern
{
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    if (nil == error)
    {
        return regex;
    }
    
    NSLog(@"%s create regex error:\n\t%@", __func__, error);
    return nil;
}

@end

@implementation NSString (ETSParser)

- (BOOL)isPatternString:(NSString *)pattern
{
    NSRegularExpression *regex = [NSRegularExpression regexWithPattern:pattern];
    if (nil != regex)
    {
        return [regex numberOfMatchesInString:self options:0 range:NSMakeRange(0, [self length])] > 0;
    }
    return NO;
}

- (BOOL)isNumeralString
{
    NSRegularExpression *regex = [NSRegularExpression regexWithPattern:@"\\D"];
    if (nil != regex)
    {
        return 0 == [regex numberOfMatchesInString:self options:0 range:NSMakeRange(0, [self length])];
    }
    return NO;
}

- (BOOL)isTagString
{
    return [self isPatternString:@"<.*?>"];
}

- (BOOL)isPhoneticUKString
{
    return [self isPatternString:@"<uk>.*</uk>"];
}

- (BOOL)isPhoneticUSString
{
    return [self isPatternString:@"<us>.*</us>"];
}

@end

@implementation ETSWord (ETSParser)

- (void)setWordHTMLStrings:(NSArray *)wordHTMLStrings
{
    static NSString *const kUKTag = @"uk";
    static NSString *const kUSTag = @"us";
    static NSString *const kENTag = @"en";
    
    for (NSString *wordString in wordHTMLStrings)
    {
        if (![wordString isKindOfClass:[NSString class]])
        {
            continue;
        }
        
        if ([wordString isNumeralString])
        {
            self.wordId = wordString;
        }
        else if (![wordString isTagString])
        {
            self.name = wordString;
        }
        else
        {
            NSArray *UKContent = [ETSParser truncatedContentsFromHTMLString:wordString betweenTag:kUKTag];
            if (1 == [UKContent count])
            {
                self.phoneticUK = [UKContent lastObject];
            }
            if (nil == self.phoneticUK)
            {
                UKContent = [ETSParser truncatedContentsFromHTMLString:wordString betweenTag:kENTag];
                if (1 == [UKContent count])
                {
                    self.phoneticUK = [UKContent lastObject];
                }
            }
            NSArray *USContent = [ETSParser truncatedContentsFromHTMLString:wordString betweenTag:kUSTag];
            if (1 == [USContent count])
            {
                self.phoneticUS = [USContent lastObject];
            }
            
            // desc
            NSArray *OLContents = [ETSParser truncatedContentsFromHTMLString:wordString betweenPattern:@"<[/]*ol>"];
            if ([OLContents count] > 0)
            {
                // fetch my comment
                NSRegularExpression *regex = [NSRegularExpression regexWithPattern:@"<ol>"];
                NSArray *OLMatches = [regex matchesInString:wordString options:0 range:NSMakeRange(0, [wordString length])];
                if ([OLMatches count] > 0)
                {
                    NSRange firstRange = [OLMatches[0] range];
                    NSString *myCommentString = [wordString substringToIndex:firstRange.location];
                    if ([myCommentString length] > 0)
                    {
                        NSRegularExpression *regex = [NSRegularExpression regexWithPattern:@"<.*?>"];
                        NSArray *tagMatches = [regex matchesInString:myCommentString options:0 range:NSMakeRange(0, [myCommentString length])];
                        if ([tagMatches count] > 0)
                        {
                            firstRange = [tagMatches[0] range];
                            NSString *replaced = [myCommentString substringToIndex:firstRange.location];
                            self.remark = replaced;
                        }
                    }
                }
                
                for (NSString *LIString in OLContents)
                {
                    NSArray *LIContents = [ETSParser truncatedContentsFromHTMLString:LIString betweenPattern:@"<[/]*li>"];
                    NSMutableString *mutableString = [NSMutableString string];
                    for (NSString *description in LIContents)
                    {
                        NSRegularExpression *regex = [NSRegularExpression regexWithPattern:@"<.*?>"];
                        NSString *replaced = [regex stringByReplacingMatchesInString:description options:0 range:NSMakeRange(0, [description length]) withTemplate:@""];
                        [mutableString appendFormat:@"%@\n", replaced];
                    }
                    self.desc = [mutableString copy];
                }
            }
            else
            {
                NSRegularExpression *regex = [NSRegularExpression regexWithPattern:@"<i>"];
                NSArray *matches = [regex matchesInString:wordString options:0 range:NSMakeRange(0, [wordString length])];
                if ([matches count] > 0)
                {
                    // fetch my comment
                    NSRegularExpression *regex = [NSRegularExpression regexWithPattern:@"<[/]*en>|<[/]*uk>|<[/]*us>"];
                    NSArray *phoneticMatches = [regex matchesInString:wordString options:0 range:NSMakeRange(0, [wordString length])];
                    if ([phoneticMatches count] > 0)
                    {
                        NSRange firstRange = [phoneticMatches[0] range];
                        NSString *myCommentString = [wordString substringToIndex:firstRange.location];
                        if ([myCommentString length] > 0)
                        {
                            NSRegularExpression *regex = [NSRegularExpression regexWithPattern:@"<.*?>"];
                            NSString *replaced = [regex stringByReplacingMatchesInString:myCommentString options:0 range:NSMakeRange(0, [myCommentString length]) withTemplate:@""];
                            self.remark = replaced;
                        }
                    }
                    
                    NSMutableString *mutableString = [NSMutableString string];
                    NSString *substring = [wordString substringFromIndex:[matches[0] range].location];
                    NSArray *components = [substring componentsSeparatedByString:@"<i>"];
                    for (NSString *componet in components)
                    {
                        NSRegularExpression *regex = [NSRegularExpression regexWithPattern:@"<.*?>"];
                        NSString *replaced = [regex stringByReplacingMatchesInString:componet options:0 range:NSMakeRange(0, [componet length]) withTemplate:@""];
                        [mutableString appendFormat:@"%@\n", replaced];
                    }
                    self.desc = [mutableString copy];
                }
                else
                {
                    NSArray *DIVContents = [ETSParser truncatedContentsFromHTMLString:wordString betweenPattern:@"<[/]*div.*?>"];
                    if ([DIVContents count] > 0)
                    {
                        // fetch my comment
                        NSRegularExpression *regex = [NSRegularExpression regexWithPattern:@"<[/]*en>|<[/]*uk>|<[/]*us>"];
                        NSArray *phoneticMatches = [regex matchesInString:wordString options:0 range:NSMakeRange(0, [wordString length])];
                        if ([phoneticMatches count] > 0)
                        {
                            NSRange firstRange = [phoneticMatches[0] range];
                            NSString *myCommentString = [wordString substringToIndex:firstRange.location];
                            if ([myCommentString length] > 0)
                            {
                                NSRegularExpression *regex = [NSRegularExpression regexWithPattern:@"<.*?>"];
                                NSString *replaced = [regex stringByReplacingMatchesInString:myCommentString options:0 range:NSMakeRange(0, [myCommentString length]) withTemplate:@""];
                                self.remark = replaced;
                            }
                        }
                        
                        NSMutableString *mutableString = [NSMutableString string];
                        for (NSString *description in DIVContents)
                        {
                            NSRegularExpression *regex = [NSRegularExpression regexWithPattern:@"<.*?>"];
                            NSString *replaced = [regex stringByReplacingMatchesInString:description options:0 range:NSMakeRange(0, [description length]) withTemplate:@""];
                            [mutableString appendFormat:@"%@\n", replaced];
                        }
                        self.desc = [mutableString copy];
                    }
                    else
                    {
                        {
                            // fetch my comment
                            NSRegularExpression *regex = [NSRegularExpression regexWithPattern:@"<[/]*en>|<[/]*uk>|<[/]*us>"];
                            NSArray *phoneticMatches = [regex matchesInString:wordString options:0 range:NSMakeRange(0, [wordString length])];
                            if ([phoneticMatches count] > 0)
                            {
                                NSRange firstRange = [phoneticMatches[0] range];
                                NSString *myCommentString = [wordString substringToIndex:firstRange.location];
                                if ([myCommentString length] > 0)
                                {
                                    NSRegularExpression *regex = [NSRegularExpression regexWithPattern:@"<.*?>"];
                                    NSString *replaced = [regex stringByReplacingMatchesInString:myCommentString options:0 range:NSMakeRange(0, [myCommentString length]) withTemplate:@""];
                                    self.remark = replaced;
                                }
                            }
                        }
                        
                        NSRegularExpression *regex = [NSRegularExpression regexWithPattern:@"<br.*?>"];
                        NSArray *matches = [regex matchesInString:wordString options:0 range:NSMakeRange(0, [wordString length])];
                        if ([matches count] > 0)
                        {
                            NSRange range = [[matches lastObject] range];
                            NSString *substring = [wordString substringFromIndex:range.location + range.length];
                            self.desc = substring;
                        }
                        else
                        {
                            NSAssert(nil == matches, @"new condition need check!");
                        }
                    }
                }
            }
        }
    }
}

@end

@interface ETSParser ()

@property (nonatomic, strong) NSArray *words;
@property (nonatomic, strong) HTMLParser *htmlParser;

@end

@implementation ETSParser
{
    pthread_mutex_t _lock;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        pthread_mutex_init(&_lock, NULL);
        NSError *error = nil;
        self.htmlParser = [[HTMLParser alloc] initWithString:[ETSParser eudicHTMLString] error:&error];
        if (nil != error)
        {
            self.htmlParser = nil;
            NSLog(@"%s init HTML parser error:\n\t%@", __func__, error);
        }
    }
    return self;
}

- (void)dealloc
{
    pthread_mutex_destroy(&_lock);
}

+ (instancetype)defaultParser
{
    static ETSParser *parser;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        parser = [[ETSParser alloc] init];
    });
    return parser;
}

- (void)searchIn:(HTMLNode *)node
{
    NSArray *children = [node children];
    NSUInteger childrenCount = [children count];
    if (childrenCount > 1)
    {
        for (HTMLNode *subnode in children)
        {
            [self searchIn:subnode];
        }
    }
    else
    {
        if (0 != childrenCount)
        {
            HTMLNode *node = [children lastObject];
            NSLog(@"contents: %@, all: %@, raw: %@", [node contents], [node allContents], [node rawContents]);
        }
    }
}

- (NSArray *)wordsFromHTMLString:(NSString *)htmlString
{
    pthread_mutex_lock(&_lock);
    if (0 == [self.words count])
    {
//        NSArray *wordStrings = [ETSParser wordStringsFromHTMLString:htmlString];
//        if (nil == wordStrings)
//        {
//            return nil;
//        }
//        
//        NSMutableArray *words = [NSMutableArray array];
//        
//        for (NSString *wordString in wordStrings)
//        {
//            NSArray *items = [ETSParser truncatedContentsFromHTMLString:wordString betweenPattern:@"<[/]*td.*?>"];
//            ETSWord *word = [[ETSWord alloc] init];
//            [word setWordHTMLStrings:items];
//            [words addObject:word];
//        }
//        
//        self.words = words;
        
        static NSString *const kTableTag = @"table";
        static NSString *const kTBodyTag = @"tbody";
        static NSString *const kTrTag = @"tr";
        static NSString *const kTdTag = @"td";
        
        HTMLNode *bodyNode = [self.htmlParser body];
        HTMLNode *tableNode = [bodyNode findChildTag:kTableTag];
        HTMLNode *tbodyNode = [tableNode findChildTag:kTBodyTag];
        NSArray *trNodes = [tbodyNode findChildTags:kTrTag];
        for (HTMLNode *node in trNodes)
        {
            NSArray *tdNodes = [node findChildTags:kTdTag];
            for (HTMLNode *subnode in tdNodes)
            {
                [self searchIn:subnode];
            }
        }
    }
    pthread_mutex_unlock(&_lock);
    
    return self.words;
}

- (void)asyncWordsFromHTMLString:(NSString *)htmlString completionBlock:(void (^)(NSArray *))completion
{
    ETSParser *__weak wself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSArray *word = [wself wordsFromHTMLString:htmlString];
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(word);
        });
    });
}

- (void)asyncLoadWords
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [self wordsFromHTMLString:[ETSParser eudicHTMLString]];
    });
}

@end

@implementation ETSParser (Helper)

+ (NSString *)eudicHTMLString
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"myWords" ofType:@"html"];
    if ([path length] > 0)
    {
        NSError *error = nil;
        NSString *string = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
        if (nil == error)
        {
            return string;
        }
    }
    
    return nil;
}

+ (NSArray *)truncatedContentsFromHTMLString:(NSString *)htmlString betweenPattern:(NSString *)pattern
{
    NSMutableArray *truncatedContents = nil;
    
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    if (nil != error)
    {
        NSLog(@"%s create regex error:\n\t%@", __func__, error);
    }
    else
    {
        NSUInteger htmlLength = [htmlString length];
        NSArray *matches = [regex matchesInString:htmlString options:0 range:NSMakeRange(0, htmlLength)];
        
        NSUInteger matchesCount = [matches count];
        NSAssert(0 == matchesCount % 2, @"%s matching %@ error!", __func__, pattern);
        truncatedContents = [NSMutableArray array];
        
        for (NSUInteger i = 1; i <= matchesCount / 2; i++)
        {
            NSUInteger index = (i * 2) - 1;
            NSAssert((index < matchesCount) && ((index - 1) >= 0), @"%s literal matches error!", __func__);
            NSTextCheckingResult *match0 = matches[index - 1];
            NSTextCheckingResult *match1 = matches[index];
            NSRange matchRange0 , matchRange1;
            matchRange0 = [match0 range];
            matchRange1 = [match1 range];
            
            NSRange range;
            range.location = matchRange0.location + matchRange0.length;
            range.length = htmlLength - range.location - (htmlLength - matchRange1.location);
            
            [truncatedContents addObject:[htmlString substringWithRange:range]];
        }
    }
    
    return truncatedContents;
}

+ (NSArray *)truncatedContentsFromHTMLString:(NSString *)htmlString betweenTag:(NSString *)tag
{
    return [ETSParser truncatedContentsFromHTMLString:htmlString betweenPattern:[NSString stringWithFormat:@"<.*?%@>", tag]];
}

+ (NSArray *)wordStringsFromHTMLString:(NSString *)htmlString
{
    static NSString *const kTBodyTag = @"tbody";
    static NSString *const kTrTag = @"tr";
    
    NSArray *wordStrings = nil;
    
    // 截取table body部分，单词数据都包含于此，此时的数组只能得到一个元素
    NSArray *tbodys = [ETSParser truncatedContentsFromHTMLString:htmlString betweenTag:kTBodyTag];
    if (nil != tbodys)
    {
        // 截取单个单词，此处获得的元素数应该与导出的单词数一致
        NSMutableArray *trs = [NSMutableArray array];
        for (NSString *tbody in tbodys)
        {
            NSArray *tr = [ETSParser truncatedContentsFromHTMLString:tbody betweenTag:kTrTag];
            if (nil != tr)
            {
                [trs addObjectsFromArray:tr];
            }
        }
        
        if ([trs count] > 0)
        {
            wordStrings = [trs copy];
        }
    }
    
    return wordStrings;
}

@end
