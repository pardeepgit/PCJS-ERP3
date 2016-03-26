//
//  CatalogViewController.m
//  PCJS-ERP
//
//  Created by Chetu India on 26/03/16.
//  Copyright © 2016 Chetu. All rights reserved.
//

#import "CatalogViewController.h"
#import "Helper.h"
#import "SVProgressHUD.h"
#import "CatalogCustomTableViewCell.h"
#import "DropDownTableViewCell.h"
#import "CatalogDetailViewController.h"
#import "UIImageView+WebCache.h"

@interface CatalogViewController ()
@end


@implementation CatalogViewController

#pragma mark -  UIViewController overrided methods.
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // Update UI
        
        viewFilterCategory.hidden = true;
        viewFilterCategory.frame = CGRectMake(401, viewFilterCategory.frame.origin.y, 220, 250);
    });

    
    if ([Helper isConnectedToInternet]){
        
        [SVProgressHUD showWithStatus:@"Updating Data..." maskType:SVProgressHUDMaskTypeClear];
        [self performSelector:@selector(fetchData) withObject:nil afterDelay:2.0];
    }
    else{
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"No Internet" message:@"Please check your internet connection." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLayoutSubviews{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // Update UI
        
        viewFilterCategory.hidden = true;
        viewFilterCategory.frame = CGRectMake(401, viewFilterCategory.frame.origin.y, 220, 250);
    });
}



#pragma mark -  fetchData Method.
- (void)fetchData{
    
    NSString *catalogProductUrl = @"http://www.pcjsgroup.biz/pcjsappwebservice/GetAllProducts.php";
    
    ApiServicesModel *apiModelObject = [ApiServicesModel sharedManager];
    apiModelObject.delegate = self;
    [apiModelObject postMethodApiWithRequestParamDictionary:[[NSMutableDictionary alloc] init]  withApiRequestUrl:catalogProductUrl];
    
    [SVProgressHUD dismiss];
}


#pragma mark -  ApiServicesModelResponseDelegate method postMethodApiResponseDelegate.
- (void) postMethodApiResponseDelegate:(NSMutableArray *)responseArray{
    
    if ([responseArray count] != 0){
        
        self.catalogArray = [[NSMutableArray alloc] init];
        
        for (int index = 0; index < responseArray.count; index++) {
            
            NSMutableDictionary *catalogDict = [responseArray objectAtIndex:index];
            [self.catalogArray addObject:[self prepareCatalogDictionary:catalogDict]];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // Update UI
            
            [SVProgressHUD dismiss];
            [tableViewCatalog reloadData];
        });
    }
    else{
        
        [SVProgressHUD dismiss];

        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert!!" message:@"An error occured to load data. Please try again.." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}


#pragma mark -  prepareCatalogDictionary Method.
- (NSMutableDictionary *) prepareCatalogDictionary: (NSMutableDictionary *)catalogDict{
    
    NSMutableDictionary *catalogPreparedDict = [[NSMutableDictionary alloc] init];
    
    if ([catalogDict valueForKey:@"barcode_symbology"] == nil || [catalogDict valueForKey:@"barcode_symbology"] == (id)[NSNull null]){
        [catalogPreparedDict setValue:@"" forKey:@"designtype"];
    }
    else{
        [catalogPreparedDict setValue:[catalogDict valueForKey:@"barcode_symbology"]  forKey:@"designtype"];
    }
    
    if ([catalogDict valueForKey:@"cname"] == nil || [catalogDict valueForKey:@"cname"] == (id)[NSNull null]){
        [catalogPreparedDict setValue:@"" forKey:@"category"];
    }
    else{
        [catalogPreparedDict setValue:[catalogDict valueForKey:@"cname"]  forKey:@"category"];
    }
    
    if ([catalogDict valueForKey:@"code"] == nil || [catalogDict valueForKey:@"code"] == (id)[NSNull null]){
        [catalogPreparedDict setValue:@"" forKey:@"productcode"];
    }
    else{
        [catalogPreparedDict setValue:[catalogDict valueForKey:@"code"]  forKey:@"productcode"];
    }

    if ([catalogDict valueForKey:@"internal_design_number"] == nil || [catalogDict valueForKey:@"internal_design_number"] == (id)[NSNull null]){
        [catalogPreparedDict setValue:@"" forKey:@"designnumber"];
    }
    else{
        [catalogPreparedDict setValue:[catalogDict valueForKey:@"internal_design_number"]  forKey:@"designnumber"];
    }

    if ([catalogDict valueForKey:@"width"] == nil || [catalogDict valueForKey:@"width"] == (id)[NSNull null]){
        [catalogPreparedDict setValue:@"" forKey:@"width"];
    }
    else{
        [catalogPreparedDict setValue:[catalogDict valueForKey:@"width"]  forKey:@"width"];
    }

    if ([catalogDict valueForKey:@"unit"] == nil || [catalogDict valueForKey:@"unit"] == (id)[NSNull null]){
        [catalogPreparedDict setValue:@"" forKey:@"measuringunit"];
    }
    else{
        [catalogPreparedDict setValue:[catalogDict valueForKey:@"unit"]  forKey:@"measuringunit"];
    }
    
    if ([catalogDict valueForKey:@"image"] == nil || [catalogDict valueForKey:@"image"] == (id)[NSNull null]){
        [catalogPreparedDict setValue:@"" forKey:@"image"];
    }
    else{
        [catalogPreparedDict setValue:[catalogDict valueForKey:@"image"]  forKey:@"image"];
    }

    if ([catalogDict valueForKey:@"rack"] == nil || [catalogDict valueForKey:@"rack"] == (id)[NSNull null]){
        [catalogPreparedDict setValue:@"" forKey:@"subcategory"];
    }
    else{
        [catalogPreparedDict setValue:[catalogDict valueForKey:@"rack"]  forKey:@"subcategory"];
    }

    return catalogPreparedDict;
}


#pragma mark -  buttonBackTapped Method.
- (IBAction)buttonBackTapped:(id)sender{
    [self.navigationController popViewControllerAnimated:true];
}

#pragma mark -  buttonFilterCategoryTapped Method.
- (IBAction)buttonFilterCategoryTapped:(id)sender{
    
}












#pragma mark -  UITableView datasource and delegate Method.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == tableViewCatalog){
        return self.catalogArray.count;
    }
    else{
        return self.categoryArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == tableViewCatalog){
        return 300.0;
    }
    else{
        return 40.0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == tableViewCatalog){
        
        CatalogCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CatalogCustomTableViewCell"];
        
        if (cell == nil) {
            cell = [[CatalogCustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                     reuseIdentifier:@"CatalogCustomTableViewCell@"];
        }
        
        tableView.separatorColor = [UIColor clearColor];
        
        if (indexPath.row%2 == 0){
            cell.viewCatalogCell.backgroundColor = [UIColor colorWithRed:40/255.0 green:100/255.0 blue:125/255.0 alpha:1];
            cell.viewCatalogCell.layer.cornerRadius = 5.0;
        }
        else{
            cell.viewCatalogCell.backgroundColor = [UIColor colorWithRed:125/255.0 green:175/255.0 blue:185/255.0 alpha:1];
            cell.viewCatalogCell.layer.cornerRadius = 5.0;
        }
        
        NSMutableDictionary *catalogDictionay = [self.catalogArray objectAtIndex:indexPath.row];
        cell.labelCategory.text = [NSString stringWithFormat:@"Category: %@",  [catalogDictionay valueForKey:@"category"]];
        cell.labelCode.text = [NSString stringWithFormat:@"Product Code: %@", [catalogDictionay valueForKey:@"productcode"]];
        cell.labelDesignNumber.text = [NSString stringWithFormat:@"Design Number: %@", [catalogDictionay valueForKey:@"designnumber"]];
        cell.labelWidth.text = [NSString stringWithFormat:@"Width: %@",[catalogDictionay valueForKey:@"width"]];
        cell.labelMUnit.text = [NSString stringWithFormat:@"M Unit: %@",[catalogDictionay valueForKey:@"measuringunit"]] ;
        cell.labelDesignType.text = [NSString stringWithFormat:@"Design Type: %@",[catalogDictionay valueForKey:@"designtype"]];
        cell.labelSubCategory.text = [NSString stringWithFormat:@"Sub Category: %@",[catalogDictionay valueForKey:@"subcategory"]] ;

        NSString *imageUrlString = [NSString stringWithFormat:@"http://www.pcjsgroup.biz/assets/uploads/%@", [catalogDictionay valueForKey:@"image"]];
        NSURL *imageUrl = [NSURL URLWithString:imageUrlString];
        [cell.imageViewCatalog sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@""]];
        cell.imageViewCatalog.layer.cornerRadius = 5.0;
        cell.imageViewCatalog.clipsToBounds = true;
        
        return cell;
    }
    else{
        
        DropDownTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DropDownTableViewCell"];
        if (cell == nil) {
            cell = [[DropDownTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                reuseIdentifier:@"DropDownTableViewCell@"];
        }
        
        tableView.separatorColor = [UIColor clearColor];
        
        cell.labelTitle.layer.cornerRadius = 5.0;
        cell.labelTitle.clipsToBounds = true;
        cell.labelTitle.text = [self.categoryArray objectAtIndex:indexPath.row];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == tableViewCatalog){

        CatalogDetailViewController *catalogDetailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CatalogDetailViewController"];
        catalogDetailViewController.catalogDataDictionary = [self.catalogArray objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:catalogDetailViewController animated:YES];
    }
    else{
        
    }
}
























#pragma mark -  Memory management Method.
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end