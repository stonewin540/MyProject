//
//  ETSDBHelper.h
//  EudicTransform
//
//  Created by stone win on 8/24/14.
//  Copyright (c) 2014 stone win. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ETSDBTableItem;

@interface ETSDBHelper : NSObject

+ (instancetype)sharedInstance;
- (BOOL)open;
- (BOOL)close;
- (NSArray *)fetchItemsTable;
- (BOOL)appendWords:(NSArray *)words lastTableItem:(ETSDBTableItem *)tableItem;

@end
