//
//  NSDate+Add.h
//  Sword
//
//  Created by msj on 2017/4/5.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Add)
@property (assign ,nonatomic ,readonly) NSInteger year;
@property (assign ,nonatomic ,readonly) NSInteger month;
@property (assign ,nonatomic ,readonly) NSInteger day;
@property (assign ,nonatomic ,readonly) NSInteger hour;
@property (assign ,nonatomic ,readonly) NSInteger minute;
@property (assign ,nonatomic ,readonly) NSInteger second;
@property (assign ,nonatomic ,readonly) NSInteger nanosecond;
@property (assign ,nonatomic ,readonly) NSInteger weekday;
@property (assign ,nonatomic ,readonly) NSInteger weekdayOrdinal;
@property (assign ,nonatomic ,readonly) NSInteger weekOfMonth;
@property (assign ,nonatomic ,readonly) NSInteger weekOfYear;
@property (assign ,nonatomic ,readonly) NSInteger yearForWeekOfYear;
@property (assign ,nonatomic ,readonly) NSInteger quarter;
@property (assign ,nonatomic ,readonly) BOOL isLeapMonth;
@property (assign ,nonatomic ,readonly) BOOL isLeapYear;
@property (assign ,nonatomic ,readonly) BOOL isToday;
@property (assign ,nonatomic ,readonly) BOOL isYesterday;

- (nullable NSDate *)dateByAddingYears:(NSInteger)years;
- (nullable NSDate *)dateByAddingMonths:(NSInteger)months;
- (nullable NSDate *)dateByAddingWeeks:(NSInteger)weeks;
- (nullable NSDate *)dateByAddingDays:(NSInteger)days;
- (nullable NSDate *)dateByAddingHours:(NSInteger)hours;
- (nullable NSDate *)dateByAddingMinutes:(NSInteger)minutes;
- (nullable NSDate *)dateByAddingSeconds:(NSInteger)seconds;
@end
