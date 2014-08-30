//
//  ETSDBHelper.m
//  EudicTransform
//
//  Created by stone win on 8/24/14.
//  Copyright (c) 2014 stone win. All rights reserved.
//

#import "ETSDBHelper.h"
#import "sqlite3.h"
#import "ETSDBTableElement.h"
#import "ETSWord.h"
#import "ETSDBTable.h"

@implementation ETSDBTableElementItems (ETSDBHelper)

- (instancetype)initWithStatement:(sqlite3_stmt *)statement
{
    if (NULL == statement)
    {
        return nil;
    }
    
    self = [super init];
    if (self)
    {
        self.CourseId = sqlite3_column_int(statement, 0);
        self.PageNum = sqlite3_column_int(statement, 1);
        self.ParentNum = sqlite3_column_int(statement, 2);
        self.PrevNum = sqlite3_column_int(statement, 3);
        
        self.TemplateId = sqlite3_column_int(statement, 4);
        self.Type = sqlite3_column_int(statement, 5);
        self.Disabled = sqlite3_column_int(statement, 6);
        self.Keywords = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 7)];
        
        self.PartOfSpeech = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 8)];
        self.Frequency = sqlite3_column_int(statement, 9);
        self.Name = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 10)];
        self.Modified = sqlite3_column_int64(statement, 11);
        
        const char *chapterTitle = (const char *)sqlite3_column_text(statement, 12);
        if (NULL != chapterTitle)
        {
            self.ChapterTitle = [NSString stringWithUTF8String:chapterTitle];
        }
        self.LessonTitle = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 13)];
        self.Command = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 14)];
        self.Question = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 15)];
        
        const char *answer = (const char *)sqlite3_column_text(statement, 16);
        if (NULL != answer)
        {
            self.Answer = [NSString stringWithUTF8String:answer];
        }
        self.QuestionAudio = sqlite3_column_int(statement, 17);
        self.AnswerAudio = sqlite3_column_int(statement, 18);
        self.ExamPoints = sqlite3_column_int(statement, 19);
        
        self.Gfx1Id = sqlite3_column_int(statement, 20);
        self.Gfx1GroupId = sqlite3_column_int(statement, 21);
        self.Gfx1Shuffle = sqlite3_column_int(statement, 22);
        
        self.Gfx2Id = sqlite3_column_int(statement, 23);
        self.Gfx2GroupId = sqlite3_column_int(statement, 24);
        self.Gfx2Shuffle = sqlite3_column_int(statement, 25);
        
        self.Gfx3Id = sqlite3_column_int(statement, 26);
        self.Gfx3GroupId = sqlite3_column_int(statement, 27);
        self.Gfx3Shuffle = sqlite3_column_int(statement, 28);
        
        // as pageNum
        self.QueueOrder = sqlite3_column_int(statement, 29);
        self.Status = sqlite3_column_int(statement, 30);
        self.LastRepetition = sqlite3_column_int(statement, 31);
        self.NextRepetition = sqlite3_column_int(statement, 32);
        
        self.AFactor = sqlite3_column_double(statement, 33);
        self.EstimatedFI = sqlite3_column_double(statement, 34);
        self.ExpectedFI = sqlite3_column_double(statement, 35);
        self.FirstGrade = sqlite3_column_int(statement, 36);
        
        self.Flags = sqlite3_column_int(statement, 37);
        self.Grades = sqlite3_column_int(statement, 38);
        self.Lapses = sqlite3_column_int(statement, 39);
        self.NewInterval = sqlite3_column_int(statement, 40);
        
        self.NormalizedGrade = sqlite3_column_double(statement, 41);
        self.Repetitions = sqlite3_column_int(statement, 42);
        self.RepetitionsCategory = sqlite3_column_int(statement, 43);
        self.UFactor = sqlite3_column_double(statement, 44);
        
        self.UsedInterval = sqlite3_column_int(statement, 45);
        self.OrigNewInterval = sqlite3_column_int(statement, 46);
    }
    return self;
}

@end

@implementation ETSDBMasterTable (ETSDBHelper)

- (instancetype)initWithStatement:(sqlite3_stmt *)statement
{
    if (NULL == statement)
    {
        return NULL;
    }
    
    self = [super init];
    if (self)
    {
        self.type = [NSString stringWithFormat:@"%s", sqlite3_column_text(statement, 0)];
        self.name = [NSString stringWithFormat:@"%s", sqlite3_column_text(statement, 1)];
        self.tableName = [NSString stringWithFormat:@"%s", sqlite3_column_text(statement, 2)];
        self.rootPage = sqlite3_column_int(statement, 3);
        self.sql = [NSString stringWithFormat:@"%s", sqlite3_column_text(statement, 4)];
    }
    return self;
}

@end

static NSString *const kDBName = @"supermemo.db";
static NSString *const kTableItems = @"Items";
static NSString *const kTableMaster = @"sqlite_master";
static NSString *const kTableCourses = @"Courses";

@interface ETSDBHelper ()

@property (nonatomic, assign) sqlite3 *db;

@end

@implementation ETSDBHelper

+ (instancetype)sharedInstance
{
    static ETSDBHelper *helper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[ETSDBHelper alloc] init];
    });
    return helper;
}

- (NSString *)DBPath
{
//    NSString *path = [[NSBundle mainBundle] pathForResource:kDBName ofType:@""];
//    return path;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [paths lastObject];
    return [cachePath stringByAppendingFormat:@"/%@", kDBName];
}

- (BOOL)open
{
    NSString *dbPath = [self DBPath];
    
    if ([dbPath length] > 0)
    {
        if (![[NSFileManager defaultManager] fileExistsAtPath:dbPath])
        {
            NSLog(@"%s open failed:\n\t暂时只支持已有数据库的修改，请导入\n\t%@\n\t到\n\t%@", __func__, kDBName, dbPath);
            return NO;
        }
        //打开数据库，这里的[path UTF8String]是将NSString转换为C字符串，因为SQLite3是采用可移植的C(而不是Objective-C)编写的，它不知道什么是NSString.
        else if (sqlite3_open([dbPath UTF8String], &_db) != SQLITE_OK)
        {
            NSLog(@"Error: open database failed.");
            return NO;
        }
    }
    else
    {
        return NO;
    }
    
    return YES;
}

- (BOOL)close
{
    return SQLITE_OK == sqlite3_close(_db);
}

- (BOOL)execSql:(NSString *)sql
{
    char *err = NULL;
    if (sqlite3_exec(_db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK)
    {
        NSAssert(NULL == err, @"%s error:\n\t%s", __func__, err);
        NSLog(@"execute SQL error:\n\t%s", err);
        return NO;
    }
    return YES;
}

@end

@implementation ETSDBHelper (Table)

- (sqlite3_stmt *)prepareSelectFromTable:(NSString *)tableName;
{
    sqlite3_stmt *statement = NULL;
    NSString *select = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE type='table'", tableName];
    
    const char *unused = NULL;
    int succeed = sqlite3_prepare_v2(_db, [select UTF8String], -1, &statement, &unused);
    if (SQLITE_OK != succeed)
    {
        NSLog(@"SELECT from %@ failed!", tableName);
        sqlite3_finalize(statement);
        return NULL;
    }
    
    return statement;
}

- (NSArray *)selectFromTable:(NSString *)tableName initializationBlock:(id (^)(sqlite3_stmt *statement))initBlock
{
    sqlite3_stmt *statement = [self prepareSelectFromTable:tableName];
    if (NULL == statement)
    {
        sqlite3_finalize(statement);
        NSLog(@"%s select failed!", __func__);
        return nil;
    }
    
    NSMutableArray *array = [NSMutableArray array];
    
    while (SQLITE_ROW == sqlite3_step(statement))
    {
        id object = initBlock(statement);
        if (nil != object)
        {
            [array addObject:object];
        }
    }
    sqlite3_finalize(statement);
    
    return [array copy];
}

- (NSArray *)selectFromMaster
{
    return [self selectFromTable:kTableMaster initializationBlock:^id(sqlite3_stmt *statement) {
        return [[ETSDBMasterTable alloc] initWithStatement:statement];
    }];
}

- (NSArray *)selectFromItems
{
    return [self selectFromTable:kTableItems initializationBlock:^id(sqlite3_stmt *statement) {
        return [[ETSDBTableElementItems alloc] initWithStatement:statement];
    }];
}

@end

@implementation ETSDBHelper (Words)

- (NSString *)answerOfWord:(ETSWord *)word
{
    if (![word isKindOfClass:[ETSWord class]])
    {
        return nil;
    }
    
    NSMutableString *answer = [NSMutableString string];
    
    //    if ([word.phoneticUK length] > 0)
    //    {
    //        [answer appendFormat:@"uk %@", word.phoneticUK];
    //    }
    //    if ([word.phoneticUS length] > 0)
    //    {
    //        [answer appendFormat:@" us %@", word.phoneticUS];
    //    }
    //    if ([word.remark length] > 0)
    //    {
    //        [answer appendFormat:@"\nremark: %@", word.remark];
    //    }
    //    if ([word.desc length] > 0)
    //    {
    //        [answer appendFormat:@"\n\n%@", word.desc];
    //    }
    // 很不行，supermemo不接受text plain排版，改用HTML吧～～
    if ([word.phoneticUK length] > 0)
    {
        [answer appendFormat:@"uk %@", word.phoneticUK];
    }
    if ([word.phoneticUS length] > 0)
    {
        [answer appendFormat:@" us %@", word.phoneticUS];
    }
    if ([word.remark length] > 0)
    {
        [answer appendFormat:@"<br></br>remark: %@", word.remark];
    }
    if ([word.desc length] > 0)
    {
        [answer appendFormat:@"<br></br>%@", word.desc];
    }
    
    
    return answer;
}

- (BOOL)insertWithLastPageNum:(NSInteger)pageNum word:(ETSWord *)word;
{
    NSMutableString *insert = [NSMutableString stringWithFormat:@"INSERT INTO %@ ", kTableItems];
    
    // keys
    [insert appendFormat:@"("];
    [insert appendFormat:@"%@, ", kCourseId];
    [insert appendFormat:@"%@, ", kPageNum];
    [insert appendFormat:@"%@, ", kParentNum];
    [insert appendFormat:@"%@, ", kPrevNum];
    
    [insert appendFormat:@"%@, ", kTemplateId];
    [insert appendFormat:@"%@, ", kType];
    [insert appendFormat:@"%@, ", kDisabled];
    [insert appendFormat:@"%@, ", kKeywords];
    
    [insert appendFormat:@"%@, ", kPartOfSpeech];
    [insert appendFormat:@"%@, ", kFrequency];
    [insert appendFormat:@"%@, ", kName];
    [insert appendFormat:@"%@, ", kModified];
    
    [insert appendFormat:@"%@, ", kChapterTitle];
    [insert appendFormat:@"%@, ", kLessonTitle];
    [insert appendFormat:@"%@, ", kCommand];
    [insert appendFormat:@"%@, ", kQuestion];
    
    [insert appendFormat:@"%@, ", kAnswer];
    [insert appendFormat:@"%@, ", kQuestionAudio];
    [insert appendFormat:@"%@, ", kAnswerAudio];
    [insert appendFormat:@"%@, ", kExamPoints];
    
    [insert appendFormat:@"%@, ", kGfx1Id];
    [insert appendFormat:@"%@, ", kGfx1GroupId];
    [insert appendFormat:@"%@, ", kGfx1Shuffle];
    
    [insert appendFormat:@"%@, ", kGfx2Id];
    [insert appendFormat:@"%@, ", kGfx2GroupId];
    [insert appendFormat:@"%@, ", kGfx2Shuffle];
    
    [insert appendFormat:@"%@, ", kGfx3Id];
    [insert appendFormat:@"%@, ", kGfx3GroupId];
    [insert appendFormat:@"%@, ", kGfx3Shuffle];
    
    [insert appendFormat:@"%@, ", kQueueOrder];
    [insert appendFormat:@"%@, ", kStatus];
    [insert appendFormat:@"%@, ", kLastRepetition];
    [insert appendFormat:@"%@, ", kNextRepetition];
    
    [insert appendFormat:@"%@, ", kAFactor];
    [insert appendFormat:@"%@, ", kEstimatedFI];
    [insert appendFormat:@"%@, ", kExpectedFI];
    [insert appendFormat:@"%@, ", kFirstGrade];
    
    [insert appendFormat:@"%@, ", kFlags];
    [insert appendFormat:@"%@, ", kGrades];
    [insert appendFormat:@"%@, ", kLapses];
    [insert appendFormat:@"%@, ", kNewInterval];
    
    [insert appendFormat:@"%@, ", kNormalizedGrade];
    [insert appendFormat:@"%@, ", kRepetitions];
    [insert appendFormat:@"%@, ", kRepetitionsCategory];
    [insert appendFormat:@"%@, ", kUFactor];
    
    [insert appendFormat:@"%@, ", kUsedInterval];
    [insert appendFormat:@"%@", kOrigNewInterval];
    
    [insert appendFormat:@") "];
    
    // values
    [insert appendFormat:@"VALUES ("];
    
    [insert appendFormat:@"1, "];// CourseId
    [insert appendFormat:@"%d, ", pageNum + 1];
    [insert appendFormat:@"0, "];
    [insert appendFormat:@"%d, ", MAX(pageNum, 0)];
    
    [insert appendFormat:@"0, "];// TemplateId
    [insert appendFormat:@"0, "];
    [insert appendFormat:@"0, "];
    [insert appendFormat:@"' ', "];
    
    [insert appendFormat:@"' ', "];// PartOfSpeech
    [insert appendFormat:@"0, "];
    [insert appendFormat:@"\"%@\", ", word.name];
    [insert appendFormat:@"0, "];
    
    [insert appendFormat:@"' ', "];// Chapter
    [insert appendFormat:@"' ', "];
    [insert appendFormat:@"' ', "];
    [insert appendFormat:@"\"%@\", ", word.name];
    
    [insert appendFormat:@"\"%@\", ", [self answerOfWord:word]];// Answer
    [insert appendFormat:@"0, "];
    [insert appendFormat:@"0, "];
    [insert appendFormat:@"1, "];
    
    [insert appendFormat:@"0, "];// Gfx1
    [insert appendFormat:@"0, "];
    [insert appendFormat:@"0, "];
    
    [insert appendFormat:@"0, "];// Gfx2
    [insert appendFormat:@"0, "];
    [insert appendFormat:@"0, "];
    
    [insert appendFormat:@"0, "];// Gfx3
    [insert appendFormat:@"0, "];
    [insert appendFormat:@"0, "];
    
    // as pageNum
    [insert appendFormat:@"%d, ", pageNum + 1];
    [insert appendFormat:@"0, "];
    [insert appendFormat:@"0, "];
    [insert appendFormat:@"0, "];
    
    [insert appendFormat:@"3.0, "];// AFactor
    [insert appendFormat:@"0.0, "];
    [insert appendFormat:@"0.0, "];
    [insert appendFormat:@"6, "];
    
    [insert appendFormat:@"0, "];// Flags
    [insert appendFormat:@"0, "];
    [insert appendFormat:@"0, "];
    [insert appendFormat:@"0, "];
    
    [insert appendFormat:@"0.0, "];// NormalizedGrade
    [insert appendFormat:@"0, "];
    [insert appendFormat:@"0, "];
    [insert appendFormat:@"0.0, "];
    
    [insert appendFormat:@"0, "];// UsedInterval
    [insert appendFormat:@"0"];
    
    [insert appendFormat:@")"];
    
    return [self execSql:[insert copy]];
}

- (BOOL)appendWords:(NSArray *)words lastTableItem:(ETSDBTableElementItems *)tableItem
{
    BOOL succeed = YES;
    
    NSInteger total = 0;
    NSInteger pageNum = tableItem.PageNum;
    NSUInteger count = [words count];
    for (NSUInteger i = 0; i < count; i++)
    {
        if (![self insertWithLastPageNum:pageNum++ word:words[i]])
        {
            succeed = NO;
            break;
        }
        else
        {
            total++;
            NSLog(@"%@ process %d th.", NSStringFromClass([self class]), total);
        }
    }
    
    NSLog(@"total transformed %d", total);
    return succeed;
}

@end
