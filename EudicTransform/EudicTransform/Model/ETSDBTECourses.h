//
//  ETSDBTableCourses.h
//  EudicTransform
//
//  Created by stone win on 8/30/14.
//  Copyright (c) 2014 stone win. All rights reserved.
//

#import "ETSDBTableElement.h"

static NSString *const kId = @"Id";
static NSString *const kGuid = @"Guid";
static NSString *const kVersion = @"Version";
static NSString *const kTitle = @"Title";

static NSString *const kLangSource = @"LangSource";
static NSString *const kLangeTaught = @"LangTaught";
static NSString *const kLangTranslations = @"LangTranslations";
//static NSString *const kType = @"Type";

static NSString *const kPath = @"Path";
static NSString *const kAuthor = @"Author";
static NSString *const kRightsOwner = @"RightsOwner";
static NSString *const kTranslators = @"Translators";

static NSString *const kBoxLink = @"BoxLink";
static NSString *const kCreated = @"Created";
//static NSString *const kModified = @"Modified";
static NSString *const kDefItemsPerDay = @"DefItemsPerDay";

static NSString *const kDefTemplateId = @"DefTemplateId";
static NSString *const kSubscribed = @"Subscribed";
static NSString *const kItemsPerDay = @"ItemsPerDay";
static NSString *const kToday = @"Today";

static NSString *const kTodayDone = @"TodayDone";
static NSString *const kLastPageNum = @"LastPageNum";
static NSString *const kRequestedFi = @"RequestedFi";
static NSString *const kOptRec = @"OptRec";

static NSString *const kTotalPages = @"TotalPages";
static NSString *const kInactivePages = @"InactivePages";
static NSString *const kExercisePages = @"ExercisePages";
static NSString *const kPagesDone = @"PagesDone";

static NSString *const kLastSynchro = @"LastSynchro";
static NSString *const kLastFreeDaysUpdate = @"LastFreeDaysUpdate";
static NSString *const kLastServerUpdate = @"LastServerUpdate";
//static NSString *const kFlags = @"Flags";

static NSString *const kMenuOrder = @"MenuOrder";
static NSString *const kFontSize = @"FontSize";
static NSString *const kFontSizeQuestion = @"FontSizeQuestion";
static NSString *const kFontSizeAnswer = @"FontSizeAnswer";

static NSString *const kProductId = @"ProductId";

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
