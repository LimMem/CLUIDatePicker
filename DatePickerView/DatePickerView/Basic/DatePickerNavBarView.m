//
//  DatePickerNavBarView.m
//  CLUIKit
//
//  Created by 秦传龙 on 2020/12/17.
//  Copyright © 2020 秦传龙. All rights reserved.
//

#import "DatePickerNavBarView.h"

@interface DatePickerNavBarView ()

@property (nonatomic, strong) UIButton *okeyBtn;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UILabel *titleLabel;

@end


@implementation DatePickerNavBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.frame = CGRectMake(0, CGRectGetHeight(frame) - 1, CGRectGetWidth(self.frame), 1);
        layer.borderWidth = 1;
        layer.borderColor = [UIColor colorWithWhite:0.95 alpha:1].CGColor;
        layer.borderWidth = 1;
        [self.layer addSublayer:layer];
        
        CAShapeLayer *toplayer = [CAShapeLayer layer];
        toplayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), 1);
        toplayer.borderWidth = 1;
        toplayer.borderColor = [UIColor colorWithWhite:0.95 alpha:1].CGColor;
        toplayer.borderWidth = 1;
        [self.layer addSublayer:toplayer];
        
        self.backgroundColor = [UIColor colorWithWhite:0.98 alpha:1];
        [self initUI];
    }
    return self;
}

- (void)initUI {
    [self initCancelBtnUI];
    [self initOkeyBtnUI];
    [self initTitleLabelUI];
}

- (void)initOkeyBtnUI {
    
    self.okeyBtn = [[UIButton alloc] init];
    [self.okeyBtn setTitle:@"确定" forState:UIControlStateNormal];
    self.okeyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.okeyBtn setTitleColor:[UIColor colorWithRed:0/255.0 green:191/255.0 blue:131/255.0 alpha:1.0] forState:UIControlStateNormal];
    [self.okeyBtn addTarget:self action:@selector(okeyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.okeyBtn];
    
    self.okeyBtn.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.okeyBtn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self.okeyBtn attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.okeyBtn attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:-10];
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.okeyBtn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:50];
    [self addConstraints:@[topConstraint, bottomConstraint, rightConstraint, widthConstraint]];
}

- (void)initCancelBtnUI {
    self.cancelBtn = [[UIButton alloc] init];
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:[UIColor colorWithWhite:0.3 alpha:1] forState:UIControlStateNormal];
    self.cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.cancelBtn];
    
    self.cancelBtn.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.cancelBtn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self.cancelBtn attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.cancelBtn attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:15];
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.cancelBtn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:50];
    [self addConstraints:@[topConstraint, bottomConstraint, leftConstraint, widthConstraint]];
}

- (void)initTitleLabelUI {
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = [UIColor colorWithWhite:0 alpha:1];
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.titleLabel];
    
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *centerXConstraint = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    NSLayoutConstraint *centerYConstraint = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:200];
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    [self addConstraints:@[centerXConstraint, centerYConstraint, widthConstraint, topConstraint]];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

- (void)okeyBtnClick:(UIButton *)btn {
    if (self.okeyBtnCallback) {
        self.okeyBtnCallback(btn);
    }
}

- (void)cancelBtnClick:(UIButton *)btn {
    if (self.cancelBtnCallback) {
        self.cancelBtnCallback(btn);
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

@end
