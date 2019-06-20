//
//  HYClassroomCustomView.m
//  Panda
//
//  Created by lish on 2019/5/30.
//  Copyright © 2019 panda. All rights reserved.
//

#import "HYClassroomCustomView.h"
#import "HYClassroomModel.h"
@interface HYClassroomCustomView()

@property (nonatomic,strong) UIImageView *icon;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UIView *bg;

@property (nonatomic,strong) UIButton *deleteBtn;
@end
@implementation HYClassroomCustomView

- (instancetype)initWithModel:(HYClassroomModel *)model {
    self = [super init];
    if (self) {
        [self initUI];
       
        if (!model.img.isNotBlank && model.imgData) {
            self.icon.image = [UIImage imageWithData:model.imgData];
        }else{
             self.icon.image = [UIImage imageNamed:model.img];
        }
        self.nameLabel.text = model.name;
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
    [self addSubview:self.bg];
    [self addSubview:self.deleteBtn];
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(kAdaptedHeight(50));
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(kAdaptedHeight(20));
        
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.icon.mas_bottom).offset(kAdaptedHeight(20));
        make.centerX.equalTo(self);
    }];
    [self.bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.icon);
        make.bottom.equalTo(self.nameLabel.mas_bottom);
    }];
    
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).offset(-10);
        make.top.equalTo(self.icon.mas_top).offset(-20);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
    
}
- (UIView *)bg {
    if (!_bg) {
        _bg = [[UIView alloc]init];
        
    }
    return _bg;
}
- (void)tapDeleteBtn {
    
    
    if (self.deleteHandle) {
        self.deleteHandle(self);
    }
    
}


- (UIButton *)deleteBtn {
    if (!_deleteBtn) {
        _deleteBtn = [UIButton  buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setImage:[UIImage imageNamed:@"2424_CrosCol"] forState:0];
        [_deleteBtn addTarget:self action:@selector(tapDeleteBtn ) forControlEvents:UIControlEventTouchUpInside];
        _deleteBtn.hidden = YES;
    }
    return _deleteBtn;
}

- (UIImageView *)icon {
    if (!_icon) {
        _icon = [[UIImageView alloc]init];
        _icon.layer.cornerRadius = kAdaptedHeight(50)/2;
        _icon.layer.masksToBounds = YES;
        
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
- (void)setIsSelected:(BOOL)isSelected {
    
    _isSelected = isSelected;
    
    _deleteBtn.hidden = !_deleteBtn.hidden;
    
    
}
- (void)tapSelected {
    
     _deleteBtn.hidden = !_deleteBtn.hidden;
}
@end
