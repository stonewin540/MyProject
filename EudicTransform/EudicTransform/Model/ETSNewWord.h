//
//  ETSNewWord.h
//  EudicTransform
//
//  Created by stone win on 12/27/14.
//  Copyright (c) 2014 stone win. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HTMLNode;

/**
 对欧陆词典单词的映射类，不过是新的
 
 因为经研究发现，supermemo支持HTML的显示，那为何还要费尽千辛万苦解析呢？而且解析经常造成内容不全
 */
@interface ETSNewWord : NSObject

@property (nonatomic, copy) NSString *serialNumber;
@property (nonatomic, copy) NSString *word;
@property (nonatomic, copy) NSString *content;

- (instancetype)initWithHtmlNode:(HTMLNode *)node;

@end
