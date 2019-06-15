//
//  HYClassroomCustomView.m
//  Panda
//
//  Created by lish on 2019/5/30.
//  Copyright © 2019 panda. All rights reserved.
//

#import "HYClassroomCustomView.h"
@interface HYClassroomCustomView()

@property (nonatomic,strong) UIImageView *icon;
@property (nonatomic,strong) UILabel *nameLabel;

@end
@implementation HYClassroomCustomView

- (instancetype)initWithIcon:(NSString *)icon name:(NSString *)name {
    self = [super init];
    if (self) {
        [self initUI];
        self.icon.image = [UIImage imageNamed:icon];
        self.nameLabel.text = name;
        self.userInteractionEnabled = YES;
        @weakify(self);
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
            
            @strongify(self);
            if (self.handle) {
                self.handle(self);
            }
            
        }];
        
        [self addGestureRecognizer:tap];
    }
    return self;
}
- (void)initUI {
    [self addSubview:self.icon];
    [self addSubview:self.nameLabel];
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(kAdaptedHeight(50));
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(kAdaptedHeight(20));
        
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.icon.mas_bottom).offset(kAdaptedHeight(20));
        make.centerX.equalTo(self);
    }];
}
- (UIImageView *)icon {
    if (!_icon) {
        _icon = [[UIImageView alloc]init];
    }
    return _icon;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = COLOR_JJ_TEXT_MAIN;
        _nameLabel.font = kSystemFontSize(16);
        
    }
    return _nameLabel;
}

@end
