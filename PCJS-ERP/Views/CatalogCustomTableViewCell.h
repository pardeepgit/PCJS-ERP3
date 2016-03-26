//
//  CatalogCustomTableViewCell.h
//  PCJS-ERP
//
//  Created by Chetu India on 26/03/16.
//  Copyright © 2016 Chetu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CatalogCustomTableViewCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UIView *viewCatalogCell;

@property (nonatomic, retain) IBOutlet UILabel *labelCode;
@property (nonatomic, retain) IBOutlet UILabel *labelCategory;
@property (nonatomic, retain) IBOutlet UILabel *labelDesignNumber;
@property (nonatomic, retain) IBOutlet UILabel *labelWidth;
@property (nonatomic, retain) IBOutlet UILabel *labelMUnit;
@property (nonatomic, retain) IBOutlet UILabel *labelDesignType;
@property (nonatomic, retain) IBOutlet UILabel *labelSubCategory;

@property (nonatomic, retain) IBOutlet UIImageView *imageViewCatalog;

@end
