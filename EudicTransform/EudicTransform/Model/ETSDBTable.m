//
//  ETSDBTable.m
//  EudicTransform
//
//  Created by stone win on 8/30/14.
//  Copyright (c) 2014 stone win. All rights reserved.
//

#import "ETSDBTable.h"

@implementation ETSDBTable

@end

@implementation ETSDBMasterTable

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p; name: %@; rootPage: %d>", NSStringFromClass([self class]), self, self.name, self.rootPage];
}

@end
