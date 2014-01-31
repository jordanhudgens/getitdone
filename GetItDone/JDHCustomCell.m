//
//  JDHCustomCell.m
//  GetItDone
//
//  Created by Jordan Hudgens on 1/30/14.
//  Copyright (c) 2014 Jordan Hudgens. All rights reserved.
//

#import "JDHCustomCell.h"

@implementation JDHCustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
