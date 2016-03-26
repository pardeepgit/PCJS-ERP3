//
//  EnquaryViewController.m
//  PCJS-ERP
//
//  Created by Chetu India on 25/03/16.
//  Copyright © 2016 Chetu. All rights reserved.
//

#import "EnquaryViewController.h"
#import "DropDownTableViewCell.h"
#import "EnquaryFooterTableViewCell.h"
#import "EnquaryTableViewCell.h"



@interface EnquaryViewController ()
@end


@implementation EnquaryViewController


#pragma mark -  UIViewController overrided methods.
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"Hi inside of viewWillAppear Method.");
    
    
    [self screenDesign];
}





#pragma mark -  screenDesign Method.
- (void) screenDesign{
    
    self.enquaryPlaceHolderArray = [[NSMutableArray alloc] init];
    [self.enquaryPlaceHolderArray addObject:@"Date"];
    [self.enquaryPlaceHolderArray addObject:@"Sales Code"];
    [self.enquaryPlaceHolderArray addObject:@"Client Code/Name"];
    [self.enquaryPlaceHolderArray addObject:@"Product Sub/Category"];
    [self.enquaryPlaceHolderArray addObject:@"Design Number"];
    [self.enquaryPlaceHolderArray addObject:@"Client Design Number"];
    [self.enquaryPlaceHolderArray addObject:@"Width"];
    [self.enquaryPlaceHolderArray addObject:@"Projected Quantity"];
    [self.enquaryPlaceHolderArray addObject:@"Target Price"];
    [self.enquaryPlaceHolderArray addObject:@"Quoted Price"];
    [self.enquaryPlaceHolderArray addObject:@"Time Line"];
    [self.enquaryPlaceHolderArray addObject:@"Status"];
    [self.enquaryPlaceHolderArray addObject:@"Image"];

    self.enquaryArray = [[NSMutableArray alloc] init];
    [self.enquaryArray addObject:@"date"];
    [self.enquaryArray addObject:@"salescode"];
    [self.enquaryArray addObject:@"clientcode"];
    [self.enquaryArray addObject:@"prodsubcategory"];
    [self.enquaryArray addObject:@"designnumber"];
    [self.enquaryArray addObject:@"client_designnumber"];
    [self.enquaryArray addObject:@"width"];
    [self.enquaryArray addObject:@"projectedqty"];
    [self.enquaryArray addObject:@"targetprice"];
    [self.enquaryArray addObject:@"quoteprice"];
    [self.enquaryArray addObject:@"timeline"];
    [self.enquaryArray addObject:@"status"];
    [self.enquaryArray addObject:@"image"];

    
    tableViewEnquary.separatorColor = [UIColor clearColor];
    
    self.enquaryDictionary = [[NSMutableDictionary alloc] init];
    for (int index = 0; index < self.enquaryArray.count; index++) {
        [self.enquaryDictionary setValue:@"" forKey:[self.enquaryArray objectAtIndex:index]];
    }
    [self.enquaryDictionary setValue:@"Thanks for Enquary." forKey:@"remarks"];

    
    
    /*
     * Code to get current date with formatter dd/MM/yyyy.
     * Set it to date field of Enwuary form.
     */
    NSDate* todayDate = [NSDate date];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString* todayDateString = [dateFormatter stringFromDate:todayDate];
    NSLog(@"Date is: %@", todayDateString);
    
    [self.enquaryDictionary setValue:todayDateString forKey:@"date"];

    
    [tableViewEnquary reloadData];
}


#pragma mark -  backButtonTapped Method.
- (IBAction)backButtonTapped:(id)sender{
    [self.navigationController popViewControllerAnimated:true];
}





#pragma mark -  UITableView datasource and delegate Method.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == tableViewEnquary){
        return self.enquaryPlaceHolderArray.count;
    }
    else{
        return self.dropDownArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == tableViewEnquary){
        
        if (indexPath.row == self.enquaryPlaceHolderArray.count -1){
            return 220.0;
        }
        else{
            return 70.0;
        }
    }
    else{
        return 40.0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == tableViewEnquary){
        
        if (indexPath.row == self.enquaryPlaceHolderArray.count -1){
            
            EnquaryFooterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EnquaryFooterTableViewCell"];
            if (cell == nil) {
                cell = [[EnquaryFooterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                    reuseIdentifier:@"EnquaryFooterTableViewCell@"];
            }
            
            tableView.separatorColor = [UIColor clearColor];
            
            cell.ImageViewEnquary.layer.cornerRadius = 10;
            cell.ImageViewEnquary.clipsToBounds = true;
            
            cell.buttonChooseImage.layer.cornerRadius = 5;
            cell.buttonSubmit.layer.cornerRadius = 5;
            cell.viewBG.layer.cornerRadius = 5;

            [cell.buttonChooseImage addTarget:self action:@selector(chooseImageButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
            [cell.buttonSubmit addTarget:self action:@selector(submitButtonTapped:) forControlEvents:UIControlEventTouchUpInside];

            return cell;
        }
        else{
            
            EnquaryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EnquaryTableViewCell"];
            if (cell == nil) {
                cell = [[EnquaryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                   reuseIdentifier:@"EnquaryTableViewCell@"];
            }
            
            tableView.separatorColor = [UIColor clearColor];
            
            cell.textFieldEntries.placeholder = [self.enquaryPlaceHolderArray objectAtIndex:indexPath.row];
            cell.textFieldEntries.tag = indexPath.row;
            cell.textFieldEntries.delegate = self;
            cell.titleLabel.text = [self.enquaryPlaceHolderArray objectAtIndex:indexPath.row];
            
            if (![[self.enquaryDictionary valueForKey:[self.enquaryArray objectAtIndex:indexPath.row]] isEqualToString:@""]){
                
                NSLog(@"%@",  [self.enquaryDictionary valueForKey:[self.enquaryArray objectAtIndex:indexPath.row]]);
                cell.textFieldEntries.text = [self.enquaryDictionary valueForKey:[self.enquaryArray objectAtIndex:indexPath.row]] ;
            }
            else{
                cell.textFieldEntries.placeholder = [self.enquaryPlaceHolderArray objectAtIndex:indexPath.row];
            }
            
            return cell;
        }
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
        cell.labelTitle.text = [self.dropDownArray objectAtIndex:indexPath.row];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}





#pragma mark -  chooseImageButtonTapped Method.
- (void) chooseImageButtonTapped:(UIButton *)sender{
    
    
}

#pragma mark -  submitButtonTapped Method.
- (void) submitButtonTapped:(UIButton *)sender{
    
    
}













#pragma mark -  Memory management Method.
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
