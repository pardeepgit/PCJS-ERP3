//
//  CatalogDetailViewController.m
//  PCJS-ERP
//
//  Created by Chetu India on 26/03/16.
//  Copyright © 2016 Chetu. All rights reserved.
//

#import "CatalogDetailViewController.h"
#import "UIImageView+WebCache.h"


@interface CatalogDetailViewController ()
@end


@implementation CatalogDetailViewController

#pragma mark -  UIViewController overrided methods.
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSLog(@"Hi inside of viewWillAppear Method.");
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self screenDesign];
}



#pragma mark -  screenDesign Method.
- (void) screenDesign{

    imageViewZoomCatalog = [[UIImageView alloc] initWithFrame:CGRectMake(420, self.view.frame.origin.y -40, self.view.frame.size.width-40, self.view.frame.size.height-80)];
    
    labelCode.text = [NSString stringWithFormat:@"Product Code %@", [self.catalogDataDictionary valueForKey:@"productcode"]];
    
    labelCategory.text = [NSString stringWithFormat:@"Category %@", [self.catalogDataDictionary valueForKey:@"category"]];;

    labelDesignNumber.text = [NSString stringWithFormat:@"Composition %@", [self.catalogDataDictionary valueForKey:@"designnumber"]];
    
    labelWidth.text = [NSString stringWithFormat:@"Width %@", [self.catalogDataDictionary valueForKey:@"width"]];

    labelSubCategory.text = [NSString stringWithFormat:@"Sub Category %@", [self.catalogDataDictionary valueForKey:@"subcategory"]];

    labelDesignType.text = [NSString stringWithFormat:@"Product Design Type %@", [self.catalogDataDictionary valueForKey:@"designtype"]];


    NSString *imageUrlString = [NSString stringWithFormat:@"http://www.pcjsgroup.biz/assets/uploads/%@", [self.catalogDataDictionary valueForKey:@"image"]];
    NSURL *imageUrl = [NSURL URLWithString:imageUrlString];
    [imageViewCatalog sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@""]];
    imageViewCatalog.layer.cornerRadius = 5.0;
    imageViewCatalog.clipsToBounds = true;

}


#pragma mark -  backButtonTapped Method.
- (IBAction)backButtonTapped:(id)sender{
    [self.navigationController popViewControllerAnimated:true];
}


#pragma mark -  Memory management Method.
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
