//
//  DatePickerUtils.h
//  日期选择器
//
//  Created by 秦传龙 on 2020/12/19.
//  Copyright © 2020 mengxianjin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DatePickerUtils : NSObject

+ (NSArray *)getYearList:(NSUInteger)since1970Distance;
+ (NSArray *)getYearList;
+ (NSArray *)getMonthDataList;
+ (NSArray *)getDayDataList:(NSInteger)year month:(NSInteger)month;
+ (NSArray *)getHoursDataList;
+ (NSArray *)getMinMinList;
+ (NSArray *)getSecondsMinList;


+ (NSInteger)getYearWithDate:(NSDate *)date;
+ (NSInteger)getMonthWithDate:(NSDate *)date;
+ (NSInteger)getDayWithDate:(NSDate *)date;
+ (NSInteger)getHoursWithDate:(NSDate *)date;
+ (NSInteger)getMinutisWithDate:(NSDate *)date;
+ (NSInteger)getSecondsWithDate:(NSDate *)date;


@end

NS_ASSUME_NONNULL_END
