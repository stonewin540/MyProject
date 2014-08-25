//
//  ETSParser.h
//  EudicTransform
//
//  Created by stone win on 8/23/14.
//  Copyright (c) 2014 stone win. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 对欧陆词典HTML对解析器
 */
@interface ETSParser : NSObject

+ (instancetype)defaultParser;
/**
 获取pattern之间的字符串
 
 @return 字符串数组
 @param htmlString 字符串形式的HTML数据
 @param pattern 正则表达式
 */
+ (NSArray *)truncatedContentsFromHTMLString:(NSString *)htmlString betweenPattern:(NSString *)pattern;
/**
 获取<tag></tag>之间的字符串
 
 @return 字符串数组
 @param htmlString 字符串形式的HTML数据
 @param tag 要截取内容的tag名
 */
+ (NSArray *)truncatedContentsFromHTMLString:(NSString *)htmlString betweenTag:(NSString *)tag;
- (NSArray *)wordStringsFromHTMLString:(NSString *)htmlString;
/**
 通过欧陆词典的HTML数据获得单词模型数组
 
 @return ETSWord模型数组，count应该与导出的单词数一致
 @param htmlString 字符串形式的HTML数据
 */
- (NSArray *)wordsFromHTMLString:(NSString *)htmlString;
/**
 通过欧陆词典的HTML数据获得单词模型数组
 
 异步操作
 
 @return ETSWord模型数组，count应该与导出的单词数一致
 @param htmlString 字符串形式的HTML数据
 @param completion 完成是的回调block
 */
- (void)asyncWordsFromHTMLString:(NSString *)htmlString completionBlock:(void (^)(NSArray *words))completion;

@end
