//
//  CatalogViewController.h
//  PCJS-ERP
//
//  Created by Chetu India on 26/03/16.
//  Copyright © 2016 Chetu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApiServicesModel.h"


@interface CatalogViewController : UIViewController <ApiServicesModelResponseDelegate>
{
    
#pragma makr -  Widget elements declaration.
    IBOutlet __weak UITableView *tableViewCatalog;
    IBOutlet __weak UIButton *buttonBack;

    IBOutlet __weak UIView *viewFilterCategory;
    IBOutlet __weak UITableView *tableViewFilterCategory;
    IBOutlet __weak UIButton *buttonFilterCategory;
}

#pragma mark -  property declaration of Instance variable.
@property (nonatomic, retain) NSMutableArray *catalogArray;
@property (nonatomic, retain) NSMutableArray *categoryArray;
@property (nonatomic, retain) NSMutableArray *sectionArray;


#pragma mark -  IBAction target methods declarations.
- (IBAction)buttonBackTapped:(id)sender;
- (IBAction)buttonFilterCategoryTapped:(id)sender;

@end
