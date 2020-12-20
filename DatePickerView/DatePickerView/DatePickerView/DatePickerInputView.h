//
//  DatePickerInputView.h
//  DatePickerView
//
//  Created by 秦传龙 on 2020/12/20.
//  Copyright © 2020 mengxianjin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatePickerValue.h"

NS_ASSUME_NONNULL_BEGIN

@interface DatePickerInputView : UIView

@property (nonatomic, assign) DatePickerViewMode pickerViewModel; // 默认年月日
@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSDate *defaultDate; // 当前日期
@property (nonatomic, strong) NSDate *minDate; // default 1970-01-01 00:00:00  该字段暂不可用
@property (nonatomic, strong) NSDate *maxDate; // 该字段暂不可用

@property (nonatomic, copy) NSString *dateFormatter;
@property (nonatomic, copy) void (^onSubmitCallback)(NSString *dateText, NSDate *date, NSInteger timestamp);
@property (nonatomic, copy) void (^onCancelCallback)(NSString *dateText, NSDate *date, NSInteger timestamp);


@end

NS_ASSUME_NONNULL_END
