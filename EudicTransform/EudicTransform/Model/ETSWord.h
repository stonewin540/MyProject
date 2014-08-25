//
//  ETSWord.h
//  EudicTransform
//
//  Created by stone win on 8/23/14.
//  Copyright (c) 2014 stone win. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 对欧陆词典单词的映射
 */
@interface ETSWord : NSObject

@property (nonatomic, copy) NSString *wordId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phoneticUK;
@property (nonatomic, copy) NSString *phoneticUS;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *remark;

@end
