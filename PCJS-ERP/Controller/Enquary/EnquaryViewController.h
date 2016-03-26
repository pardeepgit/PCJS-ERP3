//
//  EnquaryViewController.h
//  PCJS-ERP
//
//  Created by Chetu India on 25/03/16.
//  Copyright © 2016 Chetu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EnquaryViewController : UIViewController <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>
{
    
#pragma makr -  Widget elements declaration.
    IBOutlet __weak UIButton *buttonBack;
    IBOutlet __weak UITableView *tableViewEnquary;
    IBOutlet __weak UITableView *tableViewDropDown;
    
}

#pragma mark -  property declaration of Instance variable.
@property (nonatomic, retain) NSMutableArray *enquaryPlaceHolderArray;
@property (nonatomic, retain) NSMutableArray *enquaryArray;
@property (nonatomic, retain) NSMutableDictionary *enquaryDictionary;

@property (nonatomic, retain) NSMutableArray *dropDownArray;

#pragma mark -  IBAction target methods declarations.
- (IBAction)backButtonTapped:(id)sender;

@end
















































