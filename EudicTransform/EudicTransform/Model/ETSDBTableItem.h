//
//  ETSDBTable.h
//  EudicTransform
//
//  Created by stone win on 8/24/14.
//  Copyright (c) 2014 stone win. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const kCourseId = @"CourseId";
static NSString *const kPageNum = @"PageNum";
static NSString *const kParentNum = @"ParentNum";
static NSString *const kPrevNum = @"PrevNum";
static NSString *const kTemplateId = @"TemplateId";
static NSString *const kType = @"Type";
static NSString *const kDisabled = @"Disabled";
static NSString *const kKeywords = @"Keywords";
static NSString *const kPartOfSpeech = @"PartOfSpeech";
static NSString *const kFrequency = @"Frequency";
static NSString *const kName = @"Name";
static NSString *const kModified = @"Modified";
static NSString *const kChapterTitle = @"ChapterTitle";
static NSString *const kLessonTitle = @"LessonTitle";
static NSString *const kCommand = @"Command";
static NSString *const kQuestion = @"Question";
static NSString *const kAnswer = @"Answer";
static NSString *const kQuestionAudio = @"QuestionAudio";
static NSString *const kAnswerAudio = @"AnswerAudio";
static NSString *const kExamPoints = @"ExamPoints";
static NSString *const kGfx1Id = @"Gfx1Id";
static NSString *const kGfx1GroupId = @"Gfx1GroupId";
static NSString *const kGfx1Shuffle = @"Gfx1Shuffle";
static NSString *const kGfx2Id = @"Gfx2Id";
static NSString *const kGfx2GroupId = @"Gfx2GroupId";
static NSString *const kGfx2Shuffle = @"Gfx2Shuffle";
static NSString *const kGfx3Id = @"Gfx3Id";
static NSString *const kGfx3GroupId = @"Gfx3GroupId";
static NSString *const kGfx3Shuffle = @"Gfx3Shuffle";
static NSString *const kQueueOrder = @"QueueOrder";
static NSString *const kStatus = @"Status";
static NSString *const kLastRepetition = @"LastRepetition";
static NSString *const kNextRepetition = @"NextRepetition";
static NSString *const kAFactor = @"AFactor";
static NSString *const kEstimatedFI = @"EstimatedFI";
static NSString *const kExpectedFI = @"ExpectedFI";
static NSString *const kFirstGrade = @"FirstGrade";
static NSString *const kFlags = @"Flags";
static NSString *const kGrades = @"Grades";
static NSString *const kLapses = @"Lapses";
static NSString *const kNewInterval = @"NewInterval";
static NSString *const kNormalizedGrade = @"NormalizedGrade";
static NSString *const kRepetitions = @"Repetitions";
static NSString *const kRepetitionsCategory = @"RepetitionsCategory";
static NSString *const kUFactor = @"UFactor";
static NSString *const kUsedInterval = @"UsedInterval";
static NSString *const kOrigNewInterval = @"OrigNewInterval";

/**
 映射supermemo的表对象
 */
@interface ETSDBTableItem : NSObject

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
