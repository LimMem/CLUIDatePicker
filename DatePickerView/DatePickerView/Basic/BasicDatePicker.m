//
//  BasicDatePicker.m
//  日期选择器
//
//  Created by 秦传龙 on 2020/12/18.
//  Copyright © 2020 mengxianjin. All rights reserved.
//

#import "BasicDatePicker.h"
#import <Masonry/Masonry.h>
#import "BasicDatePickerCell.h"
#import "DatePickerUtils.h"

CGFloat cellHeight = 44;

@interface BasicDatePicker ()<UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) UIView *topMask;
@property (nonatomic, strong) UIView *bottomMask;


@property (nonatomic, strong) UIView *pickerView;
@property (nonatomic, strong) UITableView *yearTableView;
@property (nonatomic, copy) NSArray *yearDataSource;

@property (nonatomic, strong) UITableView *monthTableView;
@property (nonatomic, copy) NSArray *monthDataSource;

@property (nonatomic, strong) UITableView *dayTableView;
@property (nonatomic, copy) NSArray *dayDataSource;

@property (nonatomic, strong) UITableView *hoursTableView;
@property (nonatomic, copy) NSArray *hoursDataSource;

@property (nonatomic, strong) UITableView *minutesTableView;
@property (nonatomic, copy) NSArray *minutesDataSource;

@property (nonatomic, strong) UITableView *secondTableView;
@property (nonatomic, copy) NSArray *secondDataSource;


@property (nonatomic, strong) NSMutableArray *tableViewList;

@end

@implementation BasicDatePicker


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initDefaultData];
    }
    return self;
}

- (void)setPickerViewModel:(DatePickerViewMode)pickerViewModel {
    _pickerViewModel = pickerViewModel;
    [self initUI];
    [self tableViewContentOffsetY];
}

- (void)setDefaultDate:(NSDate *)defaultDate {
    _defaultDate = defaultDate;
    [self tableViewContentOffsetY];
}

- (void)_initDefaultData {
    self.minDate = [NSDate dateWithTimeIntervalSince1970:0];
    self.defaultDate = [NSDate date];
    self.pickerViewModel = DatePickerViewModeDate;

}

- (void)tableViewContentOffsetY {
    [self yearTableViewContentOffsetY];
    [self monthTableViewContentOffsetY];
    [self dayTableViewContentOffsetY];
    [self hoursTableViewContentOffsetY];
    [self minutisTableViewContentOffsetY];
    [self secondTableViewContentOffsetY];
    
}

- (void)yearTableViewContentOffsetY {
    if (self.pickerViewModel != DatePickerViewModeTime ) {
        NSInteger year = [DatePickerUtils getYearWithDate:self.defaultDate];
        NSInteger diffCount = year - 1970;
        [self.yearTableView setContentOffset:CGPointMake(0, diffCount * cellHeight - (CGRectGetHeight(self.frame) - cellHeight)/2) animated:YES];
    }
}
- (void)monthTableViewContentOffsetY {
    if (self.pickerViewModel == DatePickerViewModeYearMonth ||
        self.pickerViewModel == DatePickerViewModeDate ||
        self.pickerViewModel == DatePickerViewModeDateHour ||
        self.pickerViewModel == DatePickerViewModeYearMonth) {
        NSInteger month = [DatePickerUtils getMonthWithDate:self.defaultDate] - 1;
        [self.monthTableView setContentOffset:CGPointMake(0, month * cellHeight - (CGRectGetHeight(self.frame) - cellHeight)/2)];
    }

}
- (void)dayTableViewContentOffsetY {
    if (self.pickerViewModel == DatePickerViewModeDate ||
        self.pickerViewModel == DatePickerViewModeDateTime ||
        self.pickerViewModel == DatePickerViewModeDateTime) {
        NSInteger day = [DatePickerUtils getDayWithDate:self.defaultDate] - 1;
        [self.dayTableView setContentOffset:CGPointMake(0, day * cellHeight - (CGRectGetHeight(self.frame) - cellHeight)/2)];
    }
}
- (void)hoursTableViewContentOffsetY {
    if (self.pickerViewModel == DatePickerViewModeTime ||
        self.pickerViewModel == DatePickerViewModeDateTime ||
        self.pickerViewModel == DatePickerViewModeDateHour) {
        NSInteger hours = [DatePickerUtils getHoursWithDate:self.defaultDate];
        [self.hoursTableView setContentOffset:CGPointMake(0, hours * cellHeight - (CGRectGetHeight(self.frame) - cellHeight)/2)];
    }
}
- (void)minutisTableViewContentOffsetY {
    if (self.pickerViewModel == DatePickerViewModeTime ||
        self.pickerViewModel == DatePickerViewModeDateTime) {
        NSInteger min = [DatePickerUtils getMinutisWithDate:self.defaultDate];
        [self.minutesTableView setContentOffset:CGPointMake(0, min * cellHeight - (CGRectGetHeight(self.frame) - cellHeight)/2)];
    }
}
- (void)secondTableViewContentOffsetY {
    if (self.pickerViewModel == DatePickerViewModeTime ||
        self.pickerViewModel == DatePickerViewModeDateTime) {
        NSInteger second = [DatePickerUtils getSecondsWithDate:self.defaultDate] - 1;
        [self.secondTableView setContentOffset:CGPointMake(0, second * cellHeight - (CGRectGetHeight(self.frame) - cellHeight)/2)];
    }
}


- (void)initUI {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.tableViewList removeAllObjects];
    switch (self.pickerViewModel) {
        case DatePickerViewModeYear:
            [self yearUI];
            break;
        case DatePickerViewModeYearMonth:
            [self yearMonthUI];
            break;
        case DatePickerViewModeDate:
            [self dateUI];
            break;
        case DatePickerViewModeDateHour:
            [self dateHoursUI];
            break;
        case DatePickerViewModeDateTime:
            [self dateTimeUI];
            break;
        case DatePickerViewModeTime:
            [self timeUI];
            break;
        default:
            break;
    }
    
    [self layoutUI];
    [self addMask];
}

- (void)yearUI {
    self.yearDataSource = [DatePickerUtils getYearList];
    [self addSubview:self.yearTableView];
    [self.tableViewList addObject:self.yearTableView];
}

- (void)yearMonthUI {
    self.yearDataSource = [DatePickerUtils getYearList];
    self.monthDataSource = [DatePickerUtils getMonthDataList];

    [self addSubview:self.yearTableView];
    [self addSubview:self.monthTableView];
    [self.tableViewList addObject:self.yearTableView];
    [self.tableViewList addObject:self.monthTableView];
}

- (void)dateUI {
    self.yearDataSource = [DatePickerUtils getYearList];
    self.monthDataSource = [DatePickerUtils getMonthDataList];
    self.dayDataSource = [DatePickerUtils getDayDataList:[DatePickerUtils getYearWithDate:self.defaultDate] month:[DatePickerUtils getMonthWithDate:self.defaultDate]];
    [self addSubview:self.yearTableView];
    [self addSubview:self.monthTableView];
    [self addSubview:self.dayTableView];
    [self.tableViewList addObject:self.yearTableView];
    [self.tableViewList addObject:self.monthTableView];
    [self.tableViewList addObject:self.dayTableView];

}

- (void)dateHoursUI {
    self.yearDataSource = [DatePickerUtils getYearList];
    self.monthDataSource = [DatePickerUtils getMonthDataList];
    self.dayDataSource = [DatePickerUtils getDayDataList:[DatePickerUtils getYearWithDate:self.defaultDate] month:[DatePickerUtils getMonthWithDate:self.defaultDate]];
    self.hoursDataSource = [DatePickerUtils getHoursDataList];
    [self addSubview:self.yearTableView];
    [self addSubview:self.monthTableView];
    [self addSubview:self.dayTableView];
    [self addSubview:self.hoursTableView];
    [self.tableViewList addObject:self.yearTableView];
    [self.tableViewList addObject:self.monthTableView];
    [self.tableViewList addObject:self.dayTableView];
    [self.tableViewList addObject:self.hoursTableView];
}

- (void)dateTimeUI {
    self.yearDataSource = [DatePickerUtils getYearList];
    self.monthDataSource = [DatePickerUtils getMonthDataList];
    self.dayDataSource = [DatePickerUtils getDayDataList:[DatePickerUtils getYearWithDate:self.defaultDate] month:[DatePickerUtils getMonthWithDate:self.defaultDate]];
    self.hoursDataSource = [DatePickerUtils getHoursDataList];
    self.minutesDataSource = [DatePickerUtils getMinMinList];
    self.secondDataSource = [DatePickerUtils getSecondsMinList];
    
    
    [self addSubview:self.yearTableView];
    [self addSubview:self.monthTableView];
    [self addSubview:self.dayTableView];
    [self addSubview:self.hoursTableView];
    [self addSubview:self.minutesTableView];
    [self addSubview:self.secondTableView];
    [self.tableViewList addObject:self.yearTableView];
    [self.tableViewList addObject:self.monthTableView];
    [self.tableViewList addObject:self.dayTableView];
    [self.tableViewList addObject:self.hoursTableView];
    [self.tableViewList addObject:self.minutesTableView];
    [self.tableViewList addObject:self.secondTableView];
}

- (void)timeUI {
    self.hoursDataSource = [DatePickerUtils getHoursDataList];
    self.minutesDataSource = [DatePickerUtils getMinMinList];
    self.secondDataSource = [DatePickerUtils getSecondsMinList];
    
    [self addSubview:self.hoursTableView];
    [self addSubview:self.minutesTableView];
    [self addSubview:self.secondTableView];
    
    [self.tableViewList addObject:self.hoursTableView];
    [self.tableViewList addObject:self.minutesTableView];
    [self.tableViewList addObject:self.secondTableView];
}

- (void)addMask {
    self.topMask = [[UIView alloc] init];
    self.topMask.backgroundColor = [UIColor colorWithWhite:0 alpha:0.05];
    [self addSubview:self.topMask];
    
    self.bottomMask = [[UIView alloc] init];
    self.bottomMask.backgroundColor = [UIColor colorWithWhite:0 alpha:0.05];
    [self addSubview:self.bottomMask];
    
    [self.topMask mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
    }];
    
    [self.bottomMask mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(self.topMask);
        make.top.mas_equalTo(self.topMask.mas_bottom).offset(cellHeight);
    }];
    
}

- (void)layoutUI {
    
    if (self.tableViewList.count > 1) {
        [self.tableViewList mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(0);
        }];
        [self.tableViewList mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:10 tailSpacing:10];
    } else if(self.tableViewList.count == 1) {
        [self.tableViewList[0] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
}


- (UITableView *)yearTableView {
    if (!_yearTableView) {
        _yearTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _yearTableView.delegate = self;
        _yearTableView.dataSource = self;
        _yearTableView.tableFooterView = [UIView new];
        _yearTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _yearTableView.showsHorizontalScrollIndicator = NO;
        _yearTableView.showsVerticalScrollIndicator = NO;
        _yearTableView.contentInset = UIEdgeInsetsMake((CGRectGetHeight(self.frame) - cellHeight)/2, 0,  (CGRectGetHeight(self.frame) - cellHeight)/2, 0);
        [_yearTableView registerClass:[BasicDatePickerCell class] forCellReuseIdentifier:@"BasicDatePickerCell"];
    }
    return _yearTableView;
}

- (UITableView *)monthTableView {
    if (!_monthTableView) {
        _monthTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _monthTableView.delegate = self;
        _monthTableView.dataSource = self;
        _monthTableView.tableFooterView = [UIView new];
        _monthTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _monthTableView.showsVerticalScrollIndicator = NO;
        _monthTableView.contentInset =UIEdgeInsetsMake((CGRectGetHeight(self.frame) - cellHeight)/2, 0,  (CGRectGetHeight(self.frame) - cellHeight)/2, 0);
        [_monthTableView registerClass:[BasicDatePickerCell class] forCellReuseIdentifier:@"BasicDatePickerCell"];
    }
    return _monthTableView;
}

- (UITableView *)dayTableView {
    if (!_dayTableView) {
        _dayTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _dayTableView.delegate = self;
        _dayTableView.dataSource = self;
        _dayTableView.tableFooterView = [UIView new];
        _dayTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _dayTableView.showsVerticalScrollIndicator = NO;
        [_dayTableView registerClass:[BasicDatePickerCell class] forCellReuseIdentifier:@"BasicDatePickerCell"];
        _dayTableView.contentInset =UIEdgeInsetsMake((CGRectGetHeight(self.frame) - cellHeight)/2, 0, (CGRectGetHeight(self.frame) - cellHeight)/2, 0);
    }
    return _dayTableView;
}

- (UITableView *)hoursTableView {
    if (!_hoursTableView) {
        _hoursTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _hoursTableView.delegate = self;
        _hoursTableView.dataSource = self;
        _hoursTableView.tableFooterView = [UIView new];
        _hoursTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _hoursTableView.showsVerticalScrollIndicator = NO;
        [_hoursTableView registerClass:[BasicDatePickerCell class] forCellReuseIdentifier:@"BasicDatePickerCell"];
        _hoursTableView.contentInset =UIEdgeInsetsMake((CGRectGetHeight(self.frame) - cellHeight)/2, 0, (CGRectGetHeight(self.frame) - cellHeight)/2, 0);
    }
    return _hoursTableView;
}
- (UITableView *)minutesTableView {
    if (!_minutesTableView) {
        _minutesTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _minutesTableView.delegate = self;
        _minutesTableView.dataSource = self;
        _minutesTableView.tableFooterView = [UIView new];
        _minutesTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _minutesTableView.showsVerticalScrollIndicator = NO;
        [_minutesTableView registerClass:[BasicDatePickerCell class] forCellReuseIdentifier:@"BasicDatePickerCell"];
        _minutesTableView.contentInset =UIEdgeInsetsMake((CGRectGetHeight(self.frame) - cellHeight)/2, 0, (CGRectGetHeight(self.frame) - cellHeight)/2, 0);
    }
    return _minutesTableView;
}

- (UITableView *)secondTableView {
    if (!_secondTableView) {
        _secondTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _secondTableView.delegate = self;
        _secondTableView.dataSource = self;
        _secondTableView.tableFooterView = [UIView new];
        _secondTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _secondTableView.showsVerticalScrollIndicator = NO;
        [_secondTableView registerClass:[BasicDatePickerCell class] forCellReuseIdentifier:@"BasicDatePickerCell"];
        _secondTableView.contentInset =UIEdgeInsetsMake((CGRectGetHeight(self.frame) - cellHeight)/2, 0, (CGRectGetHeight(self.frame) - cellHeight)/2, 0);
    }
    return _secondTableView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.yearTableView) {
        return self.yearDataSource.count;
    } else if (tableView == self.monthTableView) {
        return self.monthDataSource.count;
    } else if (tableView == self.dayTableView) {
        return self.dayDataSource.count;
    } else if (tableView == self.hoursTableView) {
        return self.hoursDataSource.count;
    } else if (tableView == self.minutesTableView) {
        return self.minutesDataSource.count;
    } else if (tableView == self.secondTableView) {
        return self.secondDataSource.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BasicDatePickerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BasicDatePickerCell"];
    if (tableView == self.yearTableView) {
        cell.titleLabel.text = self.yearDataSource[indexPath.row];
    } else if (tableView == self.monthTableView) {
        cell.titleLabel.text = self.monthDataSource[indexPath.row];
    } else if (tableView == self.dayTableView) {
        cell.titleLabel.text =  self.dayDataSource[indexPath.row];
    } else if (tableView == self.hoursTableView) {
        cell.titleLabel.text =  self.hoursDataSource[indexPath.row];
    } else if (tableView == self.minutesTableView) {
        cell.titleLabel.text =  self.minutesDataSource[indexPath.row];
    } else if (tableView == self.secondTableView) {
        cell.titleLabel.text =  self.secondDataSource[indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    CATransform3D transform3D = CATransform3DIdentity;
    transform3D.m34 = -1.0/500; //此属性为透视效果，近大远小，稍后放个例子容易理解
    }

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return cellHeight;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self correctPosition:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self correctPosition:scrollView];
}

- (void)correctPosition:(UIScrollView *)scrollView {
    //    1、 滚动距离
    CGFloat offsetY = scrollView.contentOffset.y;
    
    //    2、视图中心Y轴以上的距离
    CGFloat centerOffsetY = CGRectGetHeight(scrollView.frame) / 2 + offsetY;
    //    3、计算cell的个数
    NSInteger cellCount = floor(centerOffsetY / cellHeight);
    
    // 4、cell整数个顶部距离的高度
    CGFloat cellCountTop = cellCount * cellHeight;
    
    CGFloat correctOffset = cellCount * cellHeight - scrollView.contentInset.top;
    // 临界点处理
    if ((scrollView == self.yearTableView && self.yearDataSource.count <= cellCount)
        || (scrollView == self.monthTableView && self.monthDataSource.count <= cellCount)
        || (scrollView == self.dayTableView && self.dayDataSource.count <= cellCount)
        || (scrollView == self.hoursTableView && self.hoursDataSource.count <= cellCount)
        || (scrollView == self.minutesTableView && self.minutesDataSource.count <= cellCount)
        || (scrollView == self.secondTableView && self.secondDataSource.count <= cellCount)) {
        correctOffset = (cellCount - 1) * cellHeight - scrollView.contentInset.top;
    }
    [scrollView setContentOffset:CGPointMake(0, correctOffset) animated:YES];
    if (self.pickerViewModel == DatePickerViewModeDate || self.pickerViewModel == DatePickerViewModeDateTime || self.pickerViewModel == DatePickerViewModeDateHour) {
        if (scrollView == self.yearTableView) {
            self.dayDataSource = [DatePickerUtils getDayDataList: [self getCount:correctOffset] + 1970 month:[self getCount:self.monthTableView.contentOffset.y] + 1];
            [self dayTableViewScrollFitPosition];

        } else if (scrollView == self.monthTableView) {
            self.dayDataSource = [DatePickerUtils getDayDataList: [self getCount:correctOffset] + 1970 month:[self getCount:self.monthTableView.contentOffset.y] + 1];
            [self dayTableViewScrollFitPosition];

        }
        [self.dayTableView reloadData];
    }
    
    
    // 检查最小日期和最大日期
    [self checkThreshold:scrollView correctCount:floor(correctOffset / cellHeight)];
    
}

- (void)checkThreshold:(UIScrollView *)scrollView correctCount:(NSInteger)correctCount {
    // 后期处理最小时间和最大日期
}

- (void)dayTableViewScrollFitPosition {
    NSInteger count = [self getCount:self.dayTableView.contentOffset.y];
    if (count >= self.dayDataSource.count) {
        [self.dayTableView setContentOffset:CGPointMake(0, (self.dayDataSource.count - 1) * cellHeight - (CGRectGetHeight(self.frame) - cellHeight)/2) animated:YES];
    }
}


- (NSMutableArray *)tableViewList {
    if (!_tableViewList) {
        _tableViewList = [NSMutableArray new];
    }
    return _tableViewList;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (view == self.topMask || view == self.bottomMask) {
        if (CGRectContainsPoint(self.yearTableView.frame, point)) {
            return self.yearTableView;
        } else if (CGRectContainsPoint(self.monthTableView.frame, point)) {
            return self.monthTableView;
        } else if (CGRectContainsPoint(self.dayTableView.frame, point)) {
            return self.dayTableView;
        } else if (CGRectContainsPoint(self.hoursTableView.frame, point)) {
            return self.hoursTableView;
        } else if (CGRectContainsPoint(self.minutesTableView.frame, point)) {
            return self.minutesTableView;
        } else if (CGRectContainsPoint(self.secondTableView.frame, point)) {
            return self.secondTableView;
        }
    }
    return view;
    
}

- (NSInteger)getCount:(CGFloat )offsetY {
    CGFloat centerOffsetY = CGRectGetHeight(self.frame) / 2 + offsetY;
    
    return centerOffsetY / cellHeight;
}

- (NSDate *)date {

    NSInteger year = [self getYear];
    NSInteger month = [self getMonth];
    NSInteger day = [self getDay];
    NSInteger hours = [self getHours];
    NSInteger min = [self getMin];
    NSInteger second = [self getSecond];
    
    NSString *dateFormtterText = @"yyyy";
    NSString *dateText = [NSString stringWithFormat:@"%04ld-%02ld-%02ld %02ld:%02ld:%02ld", (long)year, (long)month, (long)day, (long)hours, (long)min, (long)second];
    switch (self.pickerViewModel) {
        case DatePickerViewModeTime:
            dateFormtterText = @"HH:mm:ss";
            dateText = [NSString stringWithFormat:@"%02ld:%02ld:%02ld", (long)hours, (long)min, (long)second];
            break;
        case DatePickerViewModeDate:
            dateFormtterText = @"yyyy-MM-dd";
            dateText = [NSString stringWithFormat:@"%04ld-%02ld-%02ld", (long)year, (long)month, (long)day];
            break;
        case DatePickerViewModeDateHour:
            dateFormtterText = @"yyyy-MM-dd HH";
            dateText = [NSString stringWithFormat:@"%04ld-%02ld-%02ld %02ld", (long)year, (long)month, (long)day, (long)hours];
            break;
        case DatePickerViewModeDateTime:
            dateFormtterText = @"yyyy-MM-dd HH:mm";
            dateText = [NSString stringWithFormat:@"%04ld-%02ld-%02ld %02ld:%02ld", (long)year, (long)month, (long)day, (long)hours, (long)min];
            break;
        case DatePickerViewModeYear:
            dateFormtterText = @"yyyy";
            dateText = [NSString stringWithFormat:@"%04ld", (long)year];
            break;
        case DatePickerViewModeYearMonth:
            dateFormtterText = @"yyyy-MM";
            dateText = [NSString stringWithFormat:@"%04ld-%02ld", (long)year, (long)month];
            break;
        default:
            break;
    }
    
    NSDateFormatter *formatterDate = [[NSDateFormatter alloc] init];
    [formatterDate setDateFormat:dateFormtterText];
    return [formatterDate dateFromString:dateText];
}

- (NSInteger)getYear {
    NSInteger year = [self getCount:self.yearTableView.contentOffset.y] + 1970;;
    if (self.yearDataSource.count == 0) {
        year = 0;
    } else if (year > self.yearDataSource.count + 1970 - 1) {
        year = self.yearDataSource.count + 1970 - 1;
    } else if (year < 1970) {
        year = 1970;
    }
    return year;
}

- (NSInteger)getMonth {
    NSInteger month = [self getCount:self.monthTableView.contentOffset.y] + 1;
    if (self.monthDataSource.count == 0) {
        month = 0;
    } else if (month > 12) {
        month = self.monthDataSource.count;
    } else if (month < 1) {
        month = 1;
    }
    return month;
}

- (NSInteger)getDay {
    NSInteger day = [self getCount:self.dayTableView.contentOffset.y] + 1;
    if (self.dayDataSource.count == 0) {
        day = 0;
    } else if (day >= self.dayDataSource.count) {
        day = self.dayDataSource.count;
    } else if (day <= 1) {
        day = 1;
    }
    return day;
}

- (NSInteger)getHours {
    NSInteger hours = [self getCount:self.hoursTableView.contentOffset.y];
    if (self.hoursDataSource.count == 0) {
        hours = 0;
    } else if (hours >= self.hoursDataSource.count) {
        hours = self.hoursDataSource.count - 1;
    } else if (hours <= 1) {
        hours = 0;
    }
    return hours;
}

- (NSInteger)getMin {
    NSInteger min = [self getCount:self.minutesTableView.contentOffset.y];
    if (self.minutesDataSource.count == 0) {
        min = 0;
    } else if (min >= self.minutesDataSource.count) {
        min = self.minutesDataSource.count - 1;
    } else if (min <= 1) {
        min = 0;
    }
    return min;
}

- (NSInteger)getSecond {
    NSInteger second = [self getCount:self.secondTableView.contentOffset.y];
    if (self.secondDataSource.count == 0) {
        second = 0;
    } else if (second >= self.secondDataSource.count) {
        second = self.secondDataSource.count - 1;
    } else if (second <= 1) {
        second = 0;
    }
    return second;
}

@end
