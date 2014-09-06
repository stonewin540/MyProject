//
//  ETSDBMasterTable.h
//  EudicTransform
//
//  Created by stone win on 9/6/14.
//  Copyright (c) 2014 stone win. All rights reserved.
//

#import "ETSDBTable.h"

/**
 对sqlite_master下表成员的映射的特例
 */
@interface ETSDBTMaster : ETSDBTable

@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *tableName;
@property (nonatomic, assign) NSInteger rootPage;
@property (nonatomic, copy) NSString *sql;

@end
