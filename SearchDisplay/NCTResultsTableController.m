//
//  NCTResultsTableController.m
//  SearchDisplay
//
//  Created by Vicente de Miguel on 23/3/15.
//  Copyright (c) 2015 Nicatec Software. All rights reserved.
//

#import "NCTResultsTableController.h"
#import "NCTResultView.h"
#import "NCTMainTable.h"

@interface NCTResultsTableController ()

@end

@implementation NCTResultsTableController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    //NSLog(@"numberOfSections de la tabla resultsController");
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    //NSLog(@"numberOfRows de la tabla resultsController %lu",(unsigned long)[self.filtered count]);
    return [self.filtered count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"cellForRowAtindex de la tabla resultsController");
    static NSString *cellId=@"celda";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if ( cell == nil )
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    
    cell.textLabel.text=[self.filtered objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"Did select  del resultsController");
    NCTResultView *rview=[[NCTResultView alloc]initWithElement:[self.filtered objectAtIndex:indexPath.row] inResult:YES];
//    [self.tablaOriginal.searchController setActive:NO];
//    [self.tablaOriginal.navigationController pushViewController:rview animated:YES];
//    [self presentViewController:rview animated:YES completion:^{
//        nil;
//    }];
    //con esto llego al searchcontroller
    UISearchController *sc = (UISearchController*)self.parentViewController;
    sc.active=NO;
    NCTMainTable *mt=(NCTMainTable*)sc.delegate;
    [mt.navigationController pushViewController:rview animated:NO];
    
    
    //[self.presentingViewController.navigationController pushViewController:rview animated:YES];
    //[self.navigationController pushViewController:rview animated:YES];

}


@end
