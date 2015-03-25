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

    //he obtenido el objeto  que han pulsado. lo envio a traves del protocolo a la tabla principal, que es quien tiene el navigation controller
    if ([self.resultsDelegate respondsToSelector:@selector(resultsTableViewController:didSelectRow:)]) {
        //le envio el mensaje que que me han seleccionado y le paso el objeto seleccionado
        [self.resultsDelegate resultsTableViewController:self didSelectRow:[self.filtered objectAtIndex:indexPath.row]];
    }
    


}


@end
