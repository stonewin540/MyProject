//
//  ETSDBTable.m
//  EudicTransform
//
//  Created by stone win on 8/24/14.
//  Copyright (c) 2014 stone win. All rights reserved.
//

#import "ETSDBTableElement.h"

@implementation ETSDBTableElement

@end

@implementation ETSDBTEItems

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p; pageNum: %d; prevNum: %d; name: %@; modified: %lld; question: %@>", NSStringFromClass([self class]), self, self.PageNum, self.PrevNum, self.Name, self.Modified, self.Question];
}

@end
