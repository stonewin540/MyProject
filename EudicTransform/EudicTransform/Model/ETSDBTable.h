//
//  ETSDBTable.h
//  EudicTransform
//
//  Created by stone win on 8/30/14.
//  Copyright (c) 2014 stone win. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 映射supermemo中的表
 */
@interface ETSDBTable : NSObject

@end

/**
 对sqlite_master下表成员的映射的特例
 */
@interface ETSDBMasterTable : ETSDBTable

@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *tableName;
@property (nonatomic, assign) NSInteger rootPage;
@property (nonatomic, copy) NSString *sql;

@end
