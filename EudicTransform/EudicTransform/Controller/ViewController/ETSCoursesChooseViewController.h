//
//  ETSCoursesChooseViewController.h
//  EudicTransform
//
//  Created by stone win on 9/10/14.
//  Copyright (c) 2014 stone win. All rights reserved.
//

#import "ETSTableElementsBaseViewController.h"
@protocol ETSCoursesChooseViewControllerDelegate;
@class ETSDBTECourses;

@interface ETSCoursesChooseViewController : ETSTableElementsBaseViewController

@property (nonatomic, weak) id<ETSCoursesChooseViewControllerDelegate> delegate;

//- (instancetype)initWithCourses:(NSArray *)courses;
- (instancetype)initWithCourse:(ETSDBTECourses *)course;

@end

@protocol ETSCoursesChooseViewControllerDelegate <NSObject>

@optional
- (void)coursesChooseViewController:(ETSCoursesChooseViewController *)controller didSelectCourse:(ETSDBTECourses *)course;

@end
