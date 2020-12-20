//
//  ViewController.m
//  日期选择器
//
//  Created by siqiyang on 16/3/15.
//  Copyright © 2016年 mengxianjin. All rights reserved.
//

#import "ViewController.h"
#import "CLUIDatePickerView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textFiled;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DatePickerInputView *datePickerView = [[DatePickerInputView alloc] init];
    datePickerView.pickerViewModel = DatePickerViewModeDateTime;
    datePickerView.title = @"请选择日期";
    datePickerView.defaultDate = [NSDate dateWithTimeIntervalSinceNow:24 * 60 *60 * 31];
    datePickerView.dateFormatter = @"yyyy-MM-dd HH:mm:ss";
    datePickerView.onSubmitCallback = ^(NSString * _Nonnull dateText, NSDate * _Nonnull date, NSInteger timeStamp) {
        NSLog(@"%@ - %@ - %ld", dateText, date, timeStamp);
    };
    self.textFiled.inputView = datePickerView;
}



- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    DatePickerView *datePickerView = [[DatePickerView alloc] init];
    datePickerView.pickerViewModel = DatePickerViewModeYear;
    datePickerView.title = @"请选择日期";
    datePickerView.dateFormatter = @"yyyy-MM-dd HH:mm:ss";
    datePickerView.defaultDate = [NSDate dateWithTimeIntervalSinceNow:24 * 60 *60 * 31];
    datePickerView.onSubmitCallback = ^(NSString * _Nonnull dateText, NSDate * _Nonnull date, NSInteger timeStamp) {
        NSLog(@"%@ - %@ - %ld", dateText, date, timeStamp );
    };
    [datePickerView show];
}


@end
