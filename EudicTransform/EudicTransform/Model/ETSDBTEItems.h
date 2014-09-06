//
//  ETSDBTEItems.h
//  EudicTransform
//
//  Created by stone win on 9/6/14.
//  Copyright (c) 2014 stone win. All rights reserved.
//

#import "ETSDBTableElement.h"

extern NSString *const ETSDBTEItemsCourseId;
extern NSString *const ETSDBTEItemsPageNum;
extern NSString *const ETSDBTEItemsParentNum;
extern NSString *const ETSDBTEItemsPrevNum;
extern NSString *const ETSDBTEItemsTemplateId;
extern NSString *const ETSDBTEItemsType;
extern NSString *const ETSDBTEItemsDisabled;
extern NSString *const ETSDBTEItemsKeywords;
extern NSString *const ETSDBTEItemsPartOfSpeech;
extern NSString *const ETSDBTEItemsFrequency;
extern NSString *const ETSDBTEItemsName;
extern NSString *const ETSDBTEItemsModified;
extern NSString *const ETSDBTEItemsChapterTitle;
extern NSString *const ETSDBTEItemsLessonTitle;
extern NSString *const ETSDBTEItemsCommand;
extern NSString *const ETSDBTEItemsQuestion;
extern NSString *const ETSDBTEItemsAnswer;
extern NSString *const ETSDBTEItemsQuestionAudio;
extern NSString *const ETSDBTEItemsAnswerAudio;
extern NSString *const ETSDBTEItemsExamPoints;
extern NSString *const ETSDBTEItemsGfx1Id;
extern NSString *const ETSDBTEItemsGfx1GroupId;
extern NSString *const ETSDBTEItemsGfx1Shuffle;
extern NSString *const ETSDBTEItemsGfx2Id;
extern NSString *const ETSDBTEItemsGfx2GroupId;
extern NSString *const ETSDBTEItemsGfx2Shuffle;
extern NSString *const ETSDBTEItemsGfx3Id;
extern NSString *const ETSDBTEItemsGfx3GroupId;
extern NSString *const ETSDBTEItemsGfx3Shuffle;
extern NSString *const ETSDBTEItemsQueueOrder;
extern NSString *const ETSDBTEItemsStatus;
extern NSString *const ETSDBTEItemsLastRepetition;
extern NSString *const ETSDBTEItemsNextRepetition;
extern NSString *const ETSDBTEItemsAFactor;
extern NSString *const ETSDBTEItemsEstimatedFI;
extern NSString *const ETSDBTEItemsExpectedFI;
extern NSString *const ETSDBTEItemsFirstGrade;
extern NSString *const ETSDBTEItemsFlags;
extern NSString *const ETSDBTEItemsGrades;
extern NSString *const ETSDBTEItemsLapses;
extern NSString *const ETSDBTEItemsNewInterval;
extern NSString *const ETSDBTEItemsNormalizedGrade;
extern NSString *const ETSDBTEItemsRepetitions;
extern NSString *const ETSDBTEItemsRepetitionsCategory;
extern NSString *const ETSDBTEItemsUFactor;
extern NSString *const ETSDBTEItemsUsedInterval;
extern NSString *const ETSDBTEItemsOrigNewInterval;

/**
 对应Items表的一个特例
 */
@interface ETSDBTEItems : ETSDBTableElement

@property (nonatomic, assign) NSInteger CourseId;
@property (nonatomic, assign) NSInteger PageNum;
@property (nonatomic, assign) NSInteger ParentNum;
@property (nonatomic, assign) NSInteger PrevNum;
@property (nonatomic, assign) NSInteger TemplateId;
@property (nonatomic, assign) NSInteger Type;
@property (nonatomic, assign) BOOL Disabled;
@property (nonatomic, copy) NSString *Keywords;
@property (nonatomic, copy) NSString *PartOfSpeech;
@property (nonatomic, assign) NSInteger Frequency;
@property (nonatomic, copy) NSString *Name;
@property (nonatomic, assign) long long Modified;
@property (nonatomic, copy) NSString *ChapterTitle;
@property (nonatomic, copy) NSString *LessonTitle;
@property (nonatomic, copy) NSString *Command;
@property (nonatomic, copy) NSString *Question;
@property (nonatomic, copy) NSString *Answer;
@property (nonatomic, assign) BOOL QuestionAudio;
@property (nonatomic, assign) BOOL AnswerAudio;
@property (nonatomic, assign) NSInteger ExamPoints;
@property (nonatomic, assign) NSInteger Gfx1Id;
@property (nonatomic, assign) NSInteger Gfx1GroupId;
@property (nonatomic, assign) BOOL Gfx1Shuffle;
@property (nonatomic, assign) NSInteger Gfx2Id;
@property (nonatomic, assign) NSInteger Gfx2GroupId;
@property (nonatomic, assign) BOOL Gfx2Shuffle;
@property (nonatomic, assign) NSInteger Gfx3Id;
@property (nonatomic, assign) NSInteger Gfx3GroupId;
@property (nonatomic, assign) BOOL Gfx3Shuffle;
@property (nonatomic, assign) NSInteger QueueOrder;
@property (nonatomic, assign) NSInteger Status;
@property (nonatomic, assign) NSInteger LastRepetition;
@property (nonatomic, assign) NSInteger NextRepetition;
@property (nonatomic, assign) CGFloat AFactor;
@property (nonatomic, assign) CGFloat EstimatedFI;
@property (nonatomic, assign) CGFloat ExpectedFI;
@property (nonatomic, assign) NSInteger FirstGrade;
@property (nonatomic, assign) NSInteger Flags;
@property (nonatomic, assign) NSInteger Grades;
@property (nonatomic, assign) NSInteger Lapses;
@property (nonatomic, assign) NSInteger NewInterval;
@property (nonatomic, assign) CGFloat NormalizedGrade;
@property (nonatomic, assign) NSInteger Repetitions;
@property (nonatomic, assign) NSInteger RepetitionsCategory;
@property (nonatomic, assign) CGFloat UFactor;
@property (nonatomic, assign) NSInteger UsedInterval;
@property (nonatomic, assign) NSInteger OrigNewInterval;

@end
