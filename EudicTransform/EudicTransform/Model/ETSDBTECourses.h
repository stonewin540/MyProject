//
//  ETSDBTableCourses.h
//  EudicTransform
//
//  Created by stone win on 8/30/14.
//  Copyright (c) 2014 stone win. All rights reserved.
//

#import "ETSDBTableElement.h"

extern NSString *const ETSDBTECoursesId;
extern NSString *const ETSDBTECoursesGuid;
extern NSString *const ETSDBTECoursesVersion;
extern NSString *const ETSDBTECoursesTitle;

extern NSString *const ETSDBTECoursesLangSource;
extern NSString *const ETSDBTECoursesLangeTaught;
extern NSString *const ETSDBTECoursesLangTranslations;
extern NSString *const ETSDBTECoursesType;

extern NSString *const ETSDBTECoursesPath;
extern NSString *const ETSDBTECoursesAuthor;
extern NSString *const ETSDBTECoursesRightsOwner;
extern NSString *const ETSDBTECoursesTranslators;

extern NSString *const ETSDBTECoursesBoxLink;
extern NSString *const ETSDBTECoursesCreated;
extern NSString *const ETSDBTECoursesModified;
extern NSString *const ETSDBTECoursesDefItemsPerDay;

extern NSString *const ETSDBTECoursesDefTemplateId;
extern NSString *const ETSDBTECoursesSubscribed;
extern NSString *const ETSDBTECoursesItemsPerDay;
extern NSString *const ETSDBTECoursesToday;

extern NSString *const ETSDBTECoursesTodayDone;
extern NSString *const ETSDBTECoursesLastPageNum;
extern NSString *const ETSDBTECoursesRequestedFi;
extern NSString *const ETSDBTECoursesOptRec;

extern NSString *const ETSDBTECoursesTotalPages;
extern NSString *const ETSDBTECoursesInactivePages;
extern NSString *const ETSDBTECoursesExercisePages;
extern NSString *const ETSDBTECoursesPagesDone;

extern NSString *const ETSDBTECoursesLastSynchro;
extern NSString *const ETSDBTECoursesLastFreeDaysUpdate;
extern NSString *const ETSDBTECoursesLastServerUpdate;
extern NSString *const ETSDBTECoursesFlags;

extern NSString *const ETSDBTECoursesMenuOrder;
extern NSString *const ETSDBTECoursesFontSize;
extern NSString *const ETSDBTECoursesFontSizeQuestion;
extern NSString *const ETSDBTECoursesFontSizeAnswer;

extern NSString *const ETSDBTECoursesProductId;

/**
 对应Courses表的一个特例
 */
@interface ETSDBTECourses : ETSDBTableElement

@property (nonatomic, assign) NSInteger CoursesId;
@property (nonatomic, copy) NSString *Guid;
@property (nonatomic, assign) NSInteger Version;
@property (nonatomic, copy) NSString *Title;

@property (nonatomic, assign) NSInteger LangSource;
@property (nonatomic, assign) NSInteger LangTaught;
@property (nonatomic, assign) NSInteger LangTranslations;
@property (nonatomic, assign) NSInteger Type;

@property (nonatomic, copy) NSString *Path;
@property (nonatomic, copy) NSString *Author;
@property (nonatomic, copy) NSString *RightsOwner;
@property (nonatomic, copy) NSString *Translators;

@property (nonatomic, copy) NSString *BoxLink;
@property (nonatomic, assign) NSInteger Created;
@property (nonatomic, assign) NSInteger Modified;
@property (nonatomic, assign) NSInteger DefItemsPerDay;

@property (nonatomic, assign) NSInteger DefTemplateId;
@property (nonatomic, assign) NSInteger Subscribed;
@property (nonatomic, assign) NSInteger ItemsPerDay;
@property (nonatomic, assign) NSInteger Today;

@property (nonatomic, assign) NSInteger TodayDone;
@property (nonatomic, assign) NSInteger LastPageNum;
@property (nonatomic, assign) CGFloat RequestedFi;
//@property (nonatomic, assign) void *OptRec;
@property (nonatomic, strong) NSData *OptRec;

@property (nonatomic, assign) NSInteger TotalPages;
@property (nonatomic, assign) NSInteger InactivePages;
@property (nonatomic, assign) NSInteger ExercisePages;
@property (nonatomic, assign) NSInteger PagesDone;

@property (nonatomic, assign) NSInteger LastSynchro;
@property (nonatomic, assign) NSInteger LastFreeDaysUpdate;
@property (nonatomic, assign) NSInteger LastServerUpdate;
@property (nonatomic, assign) NSInteger Flags;

@property (nonatomic, assign) NSInteger MenuOrder;
@property (nonatomic, assign) NSInteger FontSize;
@property (nonatomic, assign) NSInteger FontSizeQuestion;
@property (nonatomic, assign) NSInteger FontSizeAnswer;

@property (nonatomic, assign) NSInteger ProductId;

@end
