//
//  BasicDatePicker.h
//  日期选择器
//
//  Created by 秦传龙 on 2020/12/18.
//  Copyright © 2020 mengxianjin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatePickerValue.h"


NS_ASSUME_NONNULL_BEGIN

@interface BasicDatePicker : UIView

@property (nonatomic, assign) DatePickerViewMode pickerViewModel; // 默认年月日
@property (nonatomic, strong, readonly) NSDate *date;
@property (nonatomic, strong) NSDate *defaultDate; // 当前日期
@property (nonatomic, strong) NSDate *minDate; // default 1970-01-01 00:00:00
@property (nonatomic, strong) NSDate *maxDate; // default 当前日期 + 500年
@property (nonatomic, copy) NSString *dateFormatter;

@end

NS_ASSUME_NONNULL_END
