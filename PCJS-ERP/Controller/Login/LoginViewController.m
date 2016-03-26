//
//  LoginViewController.m
//  PCJS-ERP
//
//  Created by Pardeep Kumar on 26/03/2016.
//  Copyright © 2016 Chetu. All rights reserved.
//

#import "LoginViewController.h"
#import "EnquaryTableViewCell.h"
#import "DashBoardViewController.h"

@interface LoginViewController ()
@end


@implementation LoginViewController


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
- (void) screenDesign
{
    self.loginPlaceHolderArray = [[NSMutableArray alloc] init];
    [self.loginPlaceHolderArray addObject:@"Email"];
    [self.loginPlaceHolderArray addObject:@"Password"];
    
    self.loginFieldArray = [[NSMutableArray alloc] init];
    [self.loginFieldArray addObject:@"emailid"];
    [self.loginFieldArray addObject:@"Password"];
    
    
    tableViewAuthField.separatorColor = [UIColor clearColor];
    for (int index = 0; index < self.loginFieldArray.count; index++) {
        [self.loginRequestDictionary setValue:@"" forKey:[self.loginFieldArray objectAtIndex:index]];
    }
    
    [tableViewAuthField reloadData];
}






#pragma mark -  UITextField delegates Method.
- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    if (textField.tag == self.loginPlaceHolderArray.count-1){
        
        [textField resignFirstResponder];
        return true;
    }
    else{
        
        EnquaryTableViewCell *cell = [tableViewAuthField cellForRowAtIndexPath:[NSIndexPath indexPathForRow:textField.tag inSection:0]];
        [cell.textFieldEntries becomeFirstResponder];
        return  false;
    }
}

- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return true;
}

- (void) textFieldDidBeginEditing:(UITextField *)textField{
    
    if (textField.tag == self.loginPlaceHolderArray.count-1){
        textField.returnKeyType = UIReturnKeyDone;
    }
    else{
        textField.returnKeyType = UIReturnKeyNext;
    }
    
    if (textField.tag == 0) {
        textField.keyboardType = UIKeyboardTypeEmailAddress;
    }
    else{
        textField.keyboardType = UIKeyboardTypeDefault;
    }
}

- (void) textFieldDidEndEditing:(UITextField *)textField{
    
    NSString *stringValue = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSLog(@"%@", stringValue);
    [self.loginRequestDictionary setValue:stringValue forKey:[self.loginFieldArray objectAtIndex:textField.tag]];
}







#pragma mark -  UITableView datasource and delegate Method.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.loginPlaceHolderArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    EnquaryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EnquaryTableViewCell"];
    if (cell == nil) {
        cell = [[EnquaryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                           reuseIdentifier:@"EnquaryTableViewCell@"];
    }
    
    tableView.separatorColor = [UIColor clearColor];
    
    cell.textFieldEntries.placeholder = [self.loginPlaceHolderArray objectAtIndex:indexPath.row];
    cell.textFieldEntries.tag = indexPath.row;
    cell.textFieldEntries.delegate = self;
    cell.titleLabel.text = [self.loginPlaceHolderArray objectAtIndex:indexPath.row];
    
    if (![[self.loginRequestDictionary valueForKey:[self.loginFieldArray objectAtIndex:indexPath.row]] isEqualToString:@""]){
        cell.textFieldEntries.text = [self.loginRequestDictionary valueForKey:[self.loginFieldArray objectAtIndex:indexPath.row]] ;
    }
    
    return cell;
}







#pragma mark -  loginButtonTapped Method.
- (IBAction)loginButtonTapped:(id)sender{
    DashBoardViewController *dashBoardViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"dashBoardViewController"];
    [self.navigationController pushViewController:dashBoardViewController animated:YES];
}





#pragma mark -  Memory management Method.
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
