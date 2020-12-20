//
//  DatePickerUtils.m
//  日期选择器
//
//  Created by 秦传龙 on 2020/12/19.
//  Copyright © 2020 mengxianjin. All rights reserved.
//

#import "DatePickerUtils.h"

@implementation DatePickerUtils

+ (NSArray *)getYearList:(NSUInteger)since1970Distance {
    if (since1970Distance <= 0) {
        since1970Distance = 200;
    }
    NSMutableArray *yearList = [NSMutableArray new];
    for (int i = 0; i < since1970Distance; i++) {
        [yearList addObject:[NSString stringWithFormat:@"%04d年", i + 1970]];
    }
    return yearList;
}

+ (NSArray *)getYearList {
    return [self getYearList:200];
}

+ (NSArray *)getMonthDataList {
    NSMutableArray *monthList = [NSMutableArray new];
    for (int i = 0; i < 12; i++) {
        [monthList addObject:[NSString stringWithFormat:@"%02d月", i + 1]];
    }
    return monthList;
}

+ (NSArray *)getHoursDataList {
    NSMutableArray *monthList = [NSMutableArray new];
    for (int i = 0; i < 24; i++) {
        [monthList addObject:[NSString stringWithFormat:@"%02d时", i]];
    }
    return monthList;
}

+ (NSArray *)getMinMinList {
    NSMutableArray *monthList = [NSMutableArray new];
    for (int i = 0; i < 60; i++) {
        [monthList addObject:[NSString stringWithFormat:@"%02d分", i]];
    }
    return monthList;
}

+ (NSArray *)getSecondsMinList {
    NSMutableArray *monthList = [NSMutableArray new];
    for (int i = 0; i < 60; i++) {
        [monthList addObject:[NSString stringWithFormat:@"%02d秒", i]];
    }
    return monthList;
}

+ (NSInteger)monthDayWithYear:(NSInteger) year month:(NSInteger) month {
    if (month > 12) {
        month = 12;
    } else if (month < 1) {
        month = 1;
    }
    NSString *dateStr = [NSString stringWithFormat:@"%ld-%ld-01 00:00:00",year,month];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [format dateFromString:dateStr];
    // 当前日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return range.length;
}

+ (NSArray *)getDayDataList:(NSInteger)year month:(NSInteger)month {
    NSInteger count = [self monthDayWithYear:year month:month];
    NSMutableArray *dayList = [NSMutableArray new];
    for (int i = 0; i < count; i++) {
        [dayList addObject:[NSString stringWithFormat:@"%02d日", i + 1]];
    }
    return dayList;
}


+ (NSInteger)getYearWithDate:(NSDate *)date {
    if (!date) {
        date = [NSDate date];
    }
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy"];
    return [[dateformatter stringFromDate:date] integerValue];
}
+ (NSInteger)getMonthWithDate:(NSDate *)date {
    if (!date) {
        date = [NSDate date];
    }
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"MM"];
    return [[dateformatter stringFromDate:date] integerValue];
}
+ (NSInteger)getDayWithDate:(NSDate *)date {
    if (!date) {
        date = [NSDate date];
    }
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"dd"];
    return [[dateformatter stringFromDate:date] integerValue];
}
+ (NSInteger)getHoursWithDate:(NSDate *)date {
    if (!date) {
        date = [NSDate date];
    }
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"HH"];
    return [[dateformatter stringFromDate:date] integerValue];
}
+ (NSInteger)getMinutisWithDate:(NSDate *)date {
    if (!date) {
        date = [NSDate date];
    }
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"mm"];
    return [[dateformatter stringFromDate:date] integerValue];
}
+ (NSInteger)getSecondsWithDate:(NSDate *)date {
    if (!date) {
        date = [NSDate date];
    }
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"ss"];
    return [[dateformatter stringFromDate:date] integerValue];
}

@end
