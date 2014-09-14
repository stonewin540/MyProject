//
//  ETSMasterTableViewController.h
//  EudicTransform
//
//  Created by stone win on 8/30/14.
//  Copyright (c) 2014 stone win. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ETSBaseTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

// data
@property (nonatomic, strong) NSArray *data;

- (void)resortData;
- (void)prepareData;
- (void)reloadTableView;
- (void)reloadTableViewIfNeeded;
- (void)alertViewOfLoadingWithAsyncProcessBlock:(void(^)(void))processBlock completionBlock:(void(^)(void))completionBlock;

@end
