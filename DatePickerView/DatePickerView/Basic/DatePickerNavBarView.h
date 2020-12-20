//
//  DatePickerNavBarView.h
//  CLUIKit
//
//  Created by 秦传龙 on 2020/12/17.
//  Copyright © 2020 秦传龙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DatePickerNavBarView : UIView

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) void (^cancelBtnCallback)(UIButton *btn);
@property (nonatomic, copy) void (^okeyBtnCallback)(UIButton *btn);

@end

NS_ASSUME_NONNULL_END
