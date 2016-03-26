//
//  CatalogDetailViewController.h
//  PCJS-ERP
//
//  Created by Chetu India on 26/03/16.
//  Copyright © 2016 Chetu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CatalogDetailViewController : UIViewController
{
    IBOutlet __weak UILabel *labelCode;
    IBOutlet __weak UILabel *labelCategory;
    IBOutlet __weak UILabel *labelDesignNumber;
    IBOutlet __weak UILabel *labelWidth;
    IBOutlet __weak UILabel *labelSubCategory;
    IBOutlet __weak UILabel *labelDesignType;
    
    IBOutlet __weak UIImageView *imageViewCatalog;
    
    UIImageView *imageViewZoomCatalog;
    UIView *dimView;
}

@property (nonatomic, retain) NSMutableDictionary *catalogDataDictionary;


- (IBAction)backButtonTapped:(id)sender;

@end
