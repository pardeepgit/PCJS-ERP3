//
//  DashBoardViewController.m
//  PCJS-ERP
//
//  Created by Chetu India on 25/03/16.
//  Copyright © 2016 Chetu. All rights reserved.
//

#import "DashBoardViewController.h"
#import "EnquaryViewController.h"
#import "CatalogViewController.h"


@interface DashBoardViewController ()
@end


@implementation DashBoardViewController

#pragma mark -  UIViewController overrided methods.
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}



#pragma mark -  buttonLogOutTapped Method.
- (IBAction)buttonLogOutTapped:(id)sender{
    [self.navigationController popViewControllerAnimated:true];
}

#pragma mark -  buttonCatalogTapped Method.
- (IBAction)buttonCatalogTapped:(id)sender{
    CatalogViewController *catalogViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"catalogViewController"];
    [self.navigationController pushViewController:catalogViewController animated:YES];
}

#pragma mark -  buttonEnquaryTapped Method.
- (IBAction)buttonEnquaryTapped:(id)sender{
    EnquaryViewController *enquaryViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"enquaryViewController"];
    [self.navigationController pushViewController:enquaryViewController animated:YES];
}




#pragma mark -  Memory management Method.
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
