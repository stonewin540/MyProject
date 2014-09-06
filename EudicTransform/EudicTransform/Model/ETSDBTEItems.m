//
//  ETSDBTEItems.m
//  EudicTransform
//
//  Created by stone win on 9/6/14.
//  Copyright (c) 2014 stone win. All rights reserved.
//

#import "ETSDBTEItems.h"

NSString *const ETSDBTEItemsCourseId = @"CourseId";
NSString *const ETSDBTEItemsPageNum = @"PageNum";
NSString *const ETSDBTEItemsParentNum = @"ParentNum";
NSString *const ETSDBTEItemsPrevNum = @"PrevNum";
NSString *const ETSDBTEItemsTemplateId = @"TemplateId";
NSString *const ETSDBTEItemsType = @"Type";
NSString *const ETSDBTEItemsDisabled = @"Disabled";
NSString *const ETSDBTEItemsKeywords = @"Keywords";
NSString *const ETSDBTEItemsPartOfSpeech = @"PartOfSpeech";
NSString *const ETSDBTEItemsFrequency = @"Frequency";
NSString *const ETSDBTEItemsName = @"Name";
NSString *const ETSDBTEItemsModified = @"Modified";
NSString *const ETSDBTEItemsChapterTitle = @"ChapterTitle";
NSString *const ETSDBTEItemsLessonTitle = @"LessonTitle";
NSString *const ETSDBTEItemsCommand = @"Command";
NSString *const ETSDBTEItemsQuestion = @"Question";
NSString *const ETSDBTEItemsAnswer = @"Answer";
NSString *const ETSDBTEItemsQuestionAudio = @"QuestionAudio";
NSString *const ETSDBTEItemsAnswerAudio = @"AnswerAudio";
NSString *const ETSDBTEItemsExamPoints = @"ExamPoints";
NSString *const ETSDBTEItemsGfx1Id = @"Gfx1Id";
NSString *const ETSDBTEItemsGfx1GroupId = @"Gfx1GroupId";
NSString *const ETSDBTEItemsGfx1Shuffle = @"Gfx1Shuffle";
NSString *const ETSDBTEItemsGfx2Id = @"Gfx2Id";
NSString *const ETSDBTEItemsGfx2GroupId = @"Gfx2GroupId";
NSString *const ETSDBTEItemsGfx2Shuffle = @"Gfx2Shuffle";
NSString *const ETSDBTEItemsGfx3Id = @"Gfx3Id";
NSString *const ETSDBTEItemsGfx3GroupId = @"Gfx3GroupId";
NSString *const ETSDBTEItemsGfx3Shuffle = @"Gfx3Shuffle";
NSString *const ETSDBTEItemsQueueOrder = @"QueueOrder";
NSString *const ETSDBTEItemsStatus = @"Status";
NSString *const ETSDBTEItemsLastRepetition = @"LastRepetition";
NSString *const ETSDBTEItemsNextRepetition = @"NextRepetition";
NSString *const ETSDBTEItemsAFactor = @"AFactor";
NSString *const ETSDBTEItemsEstimatedFI = @"EstimatedFI";
NSString *const ETSDBTEItemsExpectedFI = @"ExpectedFI";
NSString *const ETSDBTEItemsFirstGrade = @"FirstGrade";
NSString *const ETSDBTEItemsFlags = @"Flags";
NSString *const ETSDBTEItemsGrades = @"Grades";
NSString *const ETSDBTEItemsLapses = @"Lapses";
NSString *const ETSDBTEItemsNewInterval = @"NewInterval";
NSString *const ETSDBTEItemsNormalizedGrade = @"NormalizedGrade";
NSString *const ETSDBTEItemsRepetitions = @"Repetitions";
NSString *const ETSDBTEItemsRepetitionsCategory = @"RepetitionsCategory";
NSString *const ETSDBTEItemsUFactor = @"UFactor";
NSString *const ETSDBTEItemsUsedInterval = @"UsedInterval";
NSString *const ETSDBTEItemsOrigNewInterval = @"OrigNewInterval";

@implementation ETSDBTEItems

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p; pageNum: %d; prevNum: %d; name: %@; modified: %lld; question: %@>", NSStringFromClass([self class]), self, self.PageNum, self.PrevNum, self.Name, self.Modified, self.Question];
}

@end
