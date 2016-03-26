//
//  EnquaryTableViewCell.m
//  PCJS-ERP
//
//  Created by Chetu India on 25/03/16.
//  Copyright © 2016 Chetu. All rights reserved.
//

#import "EnquaryTableViewCell.h"

@implementation EnquaryTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.textFieldEntries.layer.cornerRadius = 5.0;
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, self.textFieldEntries.frame.size.height)];
    leftView.backgroundColor = self.textFieldEntries.backgroundColor;
    self.textFieldEntries.leftView = leftView;
    self.textFieldEntries.leftViewMode = UITextFieldViewModeAlways;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
