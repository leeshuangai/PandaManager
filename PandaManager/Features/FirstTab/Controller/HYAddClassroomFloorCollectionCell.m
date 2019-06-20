//
//  HYAddClassroomFloorCollectionCell.m
//  PandaManager
//
//  Created by lish on 2019/6/19.
//  Copyright © 2019 develop. All rights reserved.
//

#import "HYAddClassroomFloorCollectionCell.h"

@implementation HYAddClassroomFloorCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)tapAddBtn:(id)sender {
    if (self.tapAddHandle) {
        self.tapAddHandle();
    }
    
    
}

@end
