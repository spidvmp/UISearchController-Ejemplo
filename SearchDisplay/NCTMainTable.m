//
//  NCTMainTable.m
//  SearchDisplay
//
//  Created by Vicente de Miguel on 23/3/15.
//  Copyright (c) 2015 Nicatec Software. All rights reserved.
//

#import "NCTMainTable.h"
#import "NCTResultsTableController.h"
#import "NCTResultView.h"

@interface NCTMainTable () <UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating>

//creo el searchcontroller, se encaga de mostrar el cuadrado del search
@property (strong,nonatomic) UISearchController *searchController;

//creo la tabla de los resultados
@property (strong,nonatomic) NCTResultsTableController *resultsController;

@end

@implementation NCTMainTable

- (void)viewDidLoad {
    [super viewDidLoad];
    

    //creo los elementos que muestro en la tabla
    _elementos=[NSArray arrayWithObjects:@"Bilbao", @"Barcelona", @"Badalona", @"Madrid", @"Murcia", @"Baracaldo", @"Madridejos", @"Mostoles", @"Sevilla", @"Pontevedra", @"Puertollano",@"Palma de Mallorca", nil];
    
    //creo el controlador de la tabla que da los resultados
    _resultsController = [[NCTResultsTableController alloc] init];
    
    //creo el controlador del search, el cual tendra una referencia al resultsController
    _searchController = [[UISearchController alloc]initWithSearchResultsController:self.resultsController];


    //le encasqueto el search a la cabecera de la tabla
    [self.searchController.searchBar sizeToFit];
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    //defino el delegado del searchcontroller, asi me entero cuando dan a un boton, cuando aparece, etc como con textfield
    self.searchController.searchBar.delegate=self;
    
    //defino quien es el delegado del searchController, queno es lomismo que el searchBar. Éste esta incluido en el searchController, que es un controlador
    self.searchController.delegate=self;
    
    //ahora definimos quien se como la busqueda cada vez que pulsemos una tecla en el searchBar
    self.searchController.searchResultsUpdater=self;
    
    

    
    //podemos configurar unpoco la presentacion
    
    //si queremos que cuando se le de al searchBar se ponga el fondo de la tabla como con una capa gris (que es por defecto)
    //ponemos este valor a YES, si lo dejamos con NO no se cambia el alpha de la tabla
    self.searchController.dimsBackgroundDuringPresentation =NO;

}

#pragma mark - Table Delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"select row del mainTable");
    NCTResultView *rview=[[NCTResultView alloc]initWithElement:[self.elementos objectAtIndex:indexPath.row] inResult:NO];
    [self.navigationController pushViewController:rview animated:YES];
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

#pragma mark - UISearchBarDelegate
//todas las acciones que se pueden hacer con el searchBar, boton de busqueda, cancelar, saber que empiezan a editar, etc

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"Dan al boton de busqueda");
    [searchBar resignFirstResponder];
    
}

#pragma mark - UISearchControllerDelegate
/*
 delegado del controlador del search, se muestra un controlador, por lo tanto los metodos del delegado para saber cuando aparece, desaparece, etc. Este a su vez tiene un SearchBar, que es donde se escribe que tiene su delegado aparte
 Esto no se ejecuta cuando aparece el searchBar, se ejecuta cuando se pulsa sobre el searchBar, entonces aparece el controlador, que saca el teclado y pone el fondo mas oscuro
 */
- (void)presentSearchController:(UISearchController *)searchController {
    NSLog(@"han pulsado sobre el searchController");
    
}

- (void)willPresentSearchController:(UISearchController *)searchController {
    // do something before the search controller is presented
    NSLog(@"Se va a presentar el searchController");
}

- (void)didPresentSearchController:(UISearchController *)searchController {
    // do something after the search controller is presented
    NSLog(@"Se ha presentado el searchController");
}

- (void)willDismissSearchController:(UISearchController *)searchController {
    // do something before the search controller is dismissed
    NSLog(@"Va a desaparecer el searchController");
}

- (void)didDismissSearchController:(UISearchController *)searchController {
    // do something after the search controller is dismissed
    NSLog(@"Ha desaparecido  el searchController");
}

#pragma mark - UISearchresultsUpdating
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    //esto se ejecuta cada vez que escribimos algo en el searchBar
    NSLog(@"updateSearchResults");
    /*
     Aqui haces la busqueda que tengas que hacer y el resultado se lo tienes que pasar a self.resultsController de la forma que sea. En este caso estoy usando un arraypor lo que le paso el array filtrado y el resultsController como es el delegado de la tabla pues saca de ahi los datos para hacer la tabla de la busqueda
     */
    NSPredicate *pred= [NSPredicate predicateWithFormat:@"self contains [cd] %@",searchController.searchBar.text];
    NSArray *r=[self.elementos filteredArrayUsingPredicate:pred];
    self.resultsController.filtered=[r mutableCopy];
    [self.resultsController.tableView reloadData];
}

-(void)updateUserActivityState:(NSUserActivity *)activity {
    NSLog(@"activity");
    
}
@end
