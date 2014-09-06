//
//  ETSDBTableCourses.m
//  EudicTransform
//
//  Created by stone win on 8/30/14.
//  Copyright (c) 2014 stone win. All rights reserved.
//

#import "ETSDBTECourses.h"

NSString *const ETSDBTECoursesId = @"Id";
NSString *const ETSDBTECoursesGuid = @"Guid";
NSString *const ETSDBTECoursesVersion = @"Version";
NSString *const ETSDBTECoursesTitle = @"Title";

NSString *const ETSDBTECoursesLangSource = @"LangSource";
NSString *const ETSDBTECoursesLangeTaught = @"LangTaught";
NSString *const ETSDBTECoursesLangTranslations = @"LangTranslations";
NSString *const ETSDBTECoursesType = @"Type";

NSString *const ETSDBTECoursesPath = @"Path";
NSString *const ETSDBTECoursesAuthor = @"Author";
NSString *const ETSDBTECoursesRightsOwner = @"RightsOwner";
NSString *const ETSDBTECoursesTranslators = @"Translators";

NSString *const ETSDBTECoursesBoxLink = @"BoxLink";
NSString *const ETSDBTECoursesCreated = @"Created";
NSString *const ETSDBTECoursesModified = @"Modified";
NSString *const ETSDBTECoursesDefItemsPerDay = @"DefItemsPerDay";

NSString *const ETSDBTECoursesDefTemplateId = @"DefTemplateId";
NSString *const ETSDBTECoursesSubscribed = @"Subscribed";
NSString *const ETSDBTECoursesItemsPerDay = @"ItemsPerDay";
NSString *const ETSDBTECoursesToday = @"Today";

NSString *const ETSDBTECoursesTodayDone = @"TodayDone";
NSString *const ETSDBTECoursesLastPageNum = @"LastPageNum";
NSString *const ETSDBTECoursesRequestedFi = @"RequestedFi";
NSString *const ETSDBTECoursesOptRec = @"OptRec";

NSString *const ETSDBTECoursesTotalPages = @"TotalPages";
NSString *const ETSDBTECoursesInactivePages = @"InactivePages";
NSString *const ETSDBTECoursesExercisePages = @"ExercisePages";
NSString *const ETSDBTECoursesPagesDone = @"PagesDone";

NSString *const ETSDBTECoursesLastSynchro = @"LastSynchro";
NSString *const ETSDBTECoursesLastFreeDaysUpdate = @"LastFreeDaysUpdate";
NSString *const ETSDBTECoursesLastServerUpdate = @"LastServerUpdate";
NSString *const ETSDBTECoursesFlags = @"Flags";

NSString *const ETSDBTECoursesMenuOrder = @"MenuOrder";
NSString *const ETSDBTECoursesFontSize = @"FontSize";
NSString *const ETSDBTECoursesFontSizeQuestion = @"FontSizeQuestion";
NSString *const ETSDBTECoursesFontSizeAnswer = @"FontSizeAnswer";

NSString *const ETSDBTECoursesProductId = @"ProductId";

@implementation ETSDBTECourses

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p; CoursesId: %d; Title: %@>", NSStringFromClass([self class]), self, self.CoursesId, self.Title];
}

@end
