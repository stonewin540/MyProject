//
//  ETSDBHelper.h
//  EudicTransform
//
//  Created by stone win on 8/24/14.
//  Copyright (c) 2014 stone win. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ETSDBTEItems;

extern NSString *const ETSDBHelperTableItemsName;
extern NSString *const ETSDBHelperTableCoursesName;

@interface ETSDBHelper : NSObject

+ (instancetype)sharedInstance;
- (BOOL)open;
- (BOOL)close;

@end

@interface ETSDBHelper (Table)

- (NSArray *)selectFromMaster;
- (NSArray *)selectFromItems;
- (NSArray *)selectFromCourses;
- (NSArray *)selectFromItemsWithCourseId:(NSInteger)courseId;

@end

@interface ETSDBHelper (Words)

- (BOOL)appendWords:(NSArray *)words lastTableItem:(ETSDBTEItems *)tableItem;

@end
