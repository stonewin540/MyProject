//
//  ETSWord.m
//  EudicTransform
//
//  Created by stone win on 8/23/14.
//  Copyright (c) 2014 stone win. All rights reserved.
//

#import "ETSWord.h"

@implementation ETSWord

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p; id: %@; name: %@; phonetic: <uk: %@ us: %@>>", NSStringFromClass([self class]), self, self.wordId, self.name, self.phoneticUK, self.phoneticUS];
}

@end
