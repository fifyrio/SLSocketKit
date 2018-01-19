//
//  SLShareLocationUserCell.m
//  SLSocketKitDemo
//
//  Created by wuw on 2018/1/16.
//  Copyright © 2018年 Will. All rights reserved.
//

#import "SLShareLocationUserCell.h"

@interface SLShareLocationUserCell()
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarView;

@end

@implementation SLShareLocationUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(SLLocationModel *)model{
    _model = model;
    _usernameLabel.text = model.userName;
}

@end
