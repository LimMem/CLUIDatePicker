//
//  DatePickerView.m
//  CLUIKit
//
//  Created by 秦传龙 on 2020/12/17.
//  Copyright © 2020 秦传龙. All rights reserved.
//

#import "DatePickerView.h"
#import "DatePickerNavBarView.h"


@interface DatePickerView ()

@property (nonatomic, strong) DatePickerNavBarView *navBarView;
@property (nonatomic, strong) BasicDatePicker *datePicker;
@property (nonatomic, strong) UIView *bgView;

@end


@implementation DatePickerView

- (instancetype)init
{
    
    self = [super init];
    if (self) {
        self.dateFormatter = @"yyyy-MM-dd";
        [self initUI];
    }
    return self;
}

- (void)show {
    self.frame = [UIScreen mainScreen].bounds;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.bgView.transform = CGAffineTransformMakeTranslation(0, CGRectGetHeight(self.bgView.frame));
    
    [UIView animateWithDuration:0.2 animations:^{
        self.bgView.transform = CGAffineTransformIdentity;
    }];
}

- (void)close {
    [UIView animateWithDuration:0.2 animations:^{
        self.bgView.transform = CGAffineTransformMakeTranslation(0, CGRectGetHeight(self.bgView.frame));
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}


- (void)initUI {
    
    self.bgView = [[UIView alloc] init];
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.bgView];
    CGRect frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height * 0.6, [UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height * 0.4);
    self.bgView.frame = frame;
    
    __weak typeof(self) weakSelf = self;
    self.navBarView = [[DatePickerNavBarView alloc] initWithFrame:CGRectMake(0, 0, self.bgView.frame.size.width, 45)];
    [self.navBarView setOkeyBtnCallback:^(UIButton * _Nonnull btn) {
        [weakSelf close];
        if (weakSelf.onSubmitCallback) {
            weakSelf.onSubmitCallback([weakSelf getFormatterText], weakSelf.datePicker.date, [weakSelf.datePicker.date timeIntervalSince1970]*1000);
        }
    }];
    [self.navBarView setCancelBtnCallback:^(UIButton * _Nonnull btn) {
        [weakSelf close];
        if (weakSelf.onCancelCallback) {
            weakSelf.onCancelCallback([weakSelf getFormatterText], weakSelf.datePicker.date, [weakSelf.datePicker.date timeIntervalSince1970]*1000);
        }
    }];
    [self.bgView addSubview:self.navBarView];
    
    BasicDatePicker *datePicker = [[BasicDatePicker alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.navBarView.frame), CGRectGetWidth(self.bgView.frame), CGRectGetHeight(self.bgView.frame) - CGRectGetHeight(self.navBarView.frame))];
    self.datePicker = datePicker;
    datePicker.defaultDate = [NSDate date];
    [self.bgView addSubview:datePicker];
    
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


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    [self close];
}

@end
