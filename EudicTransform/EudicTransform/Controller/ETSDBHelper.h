//
//  ETSDBHelper.h
//  EudicTransform
//
//  Created by stone win on 8/24/14.
//  Copyright (c) 2014 stone win. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ETSDBTableElementItems;

@interface ETSDBHelper : NSObject

+ (instancetype)sharedInstance;
- (BOOL)open;
- (BOOL)close;

@end

@interface ETSDBHelper (Table)

- (NSArray *)selectFromMaster;
- (NSArray *)selectFromItems;
- (NSArray *)selectFromCourses;

@end

@interface ETSDBHelper (Words)

- (BOOL)appendWords:(NSArray *)words lastTableItem:(ETSDBTableElementItems *)tableItem;

@end
