//
//  ViewController.m
//  SearchDisplay
//
//  Created by Vicente de Miguel on 23/3/15.
//  Copyright (c) 2015 Nicatec Software. All rights reserved.
//

#import "ViewController.h"
#import "NCTResultsTableController.h"

@interface ViewController () <UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating>


@property ( strong,nonatomic) UISearchController *searchController;

@property (strong,nonatomic) NCTResultsTableController *resultsTableController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    //creo los elementos que muestro en la tabla
    _elementos=[NSArray arrayWithObjects:@"Bilbao", @"Barcelona", @"Badalona", @"Madrid", @"Murcia", @"Baracaldo", @"Madridejos", @"Mostoles", @"Sevilla", @"Pontevedra", @"Puertollano", nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return [self.elementos count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId=@"celda";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if ( cell == nil )
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    
    cell.textLabel.text=[self.elementos objectAtIndex:indexPath.row];
    
    return cell;
}
@end
