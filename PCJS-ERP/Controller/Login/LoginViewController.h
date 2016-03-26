//
//  LoginViewController.h
//  PCJS-ERP
//
//  Created by Pardeep Kumar on 26/03/2016.
//  Copyright © 2016 Chetu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
    
#pragma makr -  Widget elements declaration.
    IBOutlet __weak UIButton *buttonLogin;
    IBOutlet __weak UITableView *tableViewAuthField;
    
    BOOL isValidate;
}

#pragma mark -  property declaration of Instance variable.
@property (nonatomic, retain) NSMutableArray *loginPlaceHolderArray;
@property (nonatomic, retain) NSMutableArray *loginFieldArray;
@property (nonatomic, retain) NSMutableDictionary *loginRequestDictionary;


#pragma mark -  IBAction target methods declarations.
- (IBAction)loginButtonTapped:(id)sender;


@end
