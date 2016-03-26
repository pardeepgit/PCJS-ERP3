//
//  DashBoardViewController.h
//  PCJS-ERP
//
//  Created by Chetu India on 25/03/16.
//  Copyright © 2016 Chetu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DashBoardViewController : UIViewController
{
    
#pragma makr -  Widget elements declaration.
    IBOutlet __weak UIButton *buttonLogOut;
    IBOutlet __weak UIButton *buttonCatalog;
    IBOutlet __weak UIButton *buttonEnquary;
}

#pragma mark -  IBAction target methods declarations.
- (IBAction)buttonLogOutTapped:(id)sender;
- (IBAction)buttonCatalogTapped:(id)sender;
- (IBAction)buttonEnquaryTapped:(id)sender;


@end
