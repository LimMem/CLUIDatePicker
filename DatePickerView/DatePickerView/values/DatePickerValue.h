//
//  DatePickerValue.h
//  DatePickerView
//
//  Created by 秦传龙 on 2020/12/20.
//  Copyright © 2020 mengxianjin. All rights reserved.
//

#ifndef DatePickerValue_h
#define DatePickerValue_h

//年 、年月、年月日、年月日时分秒、 、 年月日时
typedef NS_ENUM(NSInteger, DatePickerViewMode){
    DatePickerViewModeTime, //时、分、秒
    DatePickerViewModeYear, // 年
    DatePickerViewModeYearMonth, // 年月
    DatePickerViewModeDate, //年月日
    DatePickerViewModeDateTime, //年月日时分秒
    DatePickerViewModeDateHour // 年月日时
};


#endif /* DatePickerValue_h */
