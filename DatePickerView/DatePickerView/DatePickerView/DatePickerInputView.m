//
//  DatePickerInputView.m
//  DatePickerView
//
//  Created by 秦传龙 on 2020/12/20.
//  Copyright © 2020 mengxianjin. All rights reserved.
//

#import "DatePickerInputView.h"
#import "DatePickerNavBarView.h"
#import "BasicDatePicker.h"

@interface DatePickerInputView ()

@property (nonatomic, strong) DatePickerNavBarView *navBarView;
@property (nonatomic, strong) BasicDatePicker *datePicker;

@end


@implementation DatePickerInputView

- (instancetype)init
{
    CGRect frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height * 0.6, [UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height * 0.4);
    self = [super initWithFrame:frame];
    if (self) {
        self.dateFormatter = @"yyyy-MM-dd";
        self.backgroundColor = [UIColor whiteColor];
        [self initUI];
    }
    return self;
}


- (void)initUI {
    __weak typeof(self) weakSelf = self;
    self.navBarView = [[DatePickerNavBarView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 45)];
    [self.navBarView setOkeyBtnCallback:^(UIButton * _Nonnull btn) {
        [[UIApplication sharedApplication].keyWindow endEditing:YES];
        if (weakSelf.onSubmitCallback) {
            weakSelf.onSubmitCallback([weakSelf getFormatterText], weakSelf.datePicker.date, [weakSelf.datePicker.date timeIntervalSince1970]*1000);
        }
    }];
    [self.navBarView setCancelBtnCallback:^(UIButton * _Nonnull btn) {
        [[UIApplication sharedApplication].keyWindow endEditing:YES];
        if (weakSelf.onCancelCallback) {
            weakSelf.onCancelCallback([weakSelf getFormatterText], weakSelf.datePicker.date, [weakSelf.datePicker.date timeIntervalSince1970]*1000);
        }
    }];
    [self addSubview:self.navBarView];
    
    BasicDatePicker *datePicker = [[BasicDatePicker alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.navBarView.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - CGRectGetHeight(self.navBarView.frame))];
    self.datePicker = datePicker;
    datePicker.defaultDate = [NSDate date];
    [self addSubview:datePicker];
    
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.navBarView.title = title;
}

- (void)setDefaultDate:(NSDate *)defaultDate {
    _defaultDate = defaultDate;
    self.datePicker.defaultDate = defaultDate;
}

- (void)setMinDate:(NSDate *)minDate {
    _minDate = minDate;
    self.datePicker.minDate = minDate;
}

- (void)setMaxDate:(NSDate *)maxDate {
    _maxDate = maxDate;
    self.datePicker.maxDate = maxDate;
}

- (NSString *)getFormatterText {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:self.dateFormatter]; //设置日期格式
    return [dateFormatter stringFromDate:self.datePicker.date];
}

- (void)setPickerViewModel:(DatePickerViewMode)pickerViewModel {
    _pickerViewModel = pickerViewModel;
    self.datePicker.pickerViewModel = pickerViewModel;
}

@end

