//
//  ETSDBMasterTable.m
//  EudicTransform
//
//  Created by stone win on 9/6/14.
//  Copyright (c) 2014 stone win. All rights reserved.
//

#import "ETSDBTMaster.h"

@implementation ETSDBTMaster

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p; name: %@; rootPage: %d>", NSStringFromClass([self class]), self, self.name, self.rootPage];
}

@end
