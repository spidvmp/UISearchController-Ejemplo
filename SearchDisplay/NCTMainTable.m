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
@property (strong,nonatomic) NCTResultsTableController *resultsTableController;
@end

/*
 Esta es la tabla principal, donde estan todos los datos que tengan que aparecer. Estos datos estan sacados de un array, pero si fuera coredata seria basicamente lo mismo.
 En versiones anteriores para hacer un UISearchDisplayController se ponia este objeto y es como si hubieran 2 tablas, luego habia que estar comprobando en los metodos del delegado y del datasource de que tabla se estaba hablando, la original o al de los datos filtrados. Lo que han hecho ahora los de Apple es hacer 2 controladores, uno para hacer todo lo relacionado con el searchbar y otro para cotrolar los datos filtrados en una tabla aparte. Por este motivo tenemos el tableviewcontroller original que es este, donde aparecen los datos que se tienen que mostrar, despues hay un controlador para el SearchController y luego hay otro controlador ( que sera un uitableViewcontroller) para mostrar los datos filtrados. El Searchcontroller es el que se ocupa de poner un controlador u otro, segun se este buscando o no. 
 Del searchController hay un metodo que es el que tiene la chicha, que es:
 -(void)updateSearchResultsForSearchController:(UISearchController *)searchController
 En cuento toquemos el searchbar se llama a este metodo y segun vamos escribiendo se va llamando. Es aqui donde hay que hacer la busqueda y pasarsela a la tabla que miuestra los datos filtrados, el otro controlador.
 Con esto hay algunas cosas que pueden ser un poco liosas, con respecto al controlador de los datos filtrados hay que decidir quien es el delegado y el data source, que puede ser el mismo o el controlador de datos originales, este en el que estamos. Yo la version que he hech es para el delegado sea el mismo y no el este controlador.
 Si lo que hacemos es que este controlador sea el delegado tenremos que estar haciendo un if para saber si tiene que dar datos de la tabla original o de la filtrada y entonces el controlador de los datos filtrados solo tendra el metodo de cellForRowAtIndex
 
 Vaya rllo he soltado, pero mi consejo es que vayais por partes y vereis que no es tan dificil
 - Crear un UITableViewController que muesre una tabla, de un array, como he hecho yo es suficiente
 - Meterle el UISEarchBarDelegate y creais el _searchController. Necesitareis hacer la UITableViewcontroller de resultados, aunque de momento no la vais a usar. Probar a ver que pasa cuando pulsais sobre el searchbar y que metodos se pueden llamar. en este ejemplo solo tengo searchBarSearchButtonClicked: NO OS OLVIDEIS DE PONER EL DELEGADO=self
 -Una vez que hayais visto que no tiene ciencia lo que habeis hecho (tampoco hace nada) añadir el UISearchControllerDelegate. He puesto los metodos que se pueden llamar, pero si lo mirais por encima vereis que lo mismo ni los usais
 - Una vez que hayis visto que tampoco tiene ciencia, ahora viene lo bueno, añadir el UISearchResultsUpdating y añadir el metodo updateSearchResultsForSearchController: ponerle un NSLog o punto de interrupcion y ahora si que vais a necesitar el UITableViewController de resultados, poner puntos de interrupcion y probar, ya vereis que lo hace todo solo
 */

@implementation NCTMainTable

- (void)viewDidLoad {
    [super viewDidLoad];
    

    //creo los elementos que muestro en la tabla
    _elementos=[NSArray arrayWithObjects:@"Bilbao", @"Barcelona", @"Badalona", @"Madrid", @"Murcia", @"Baracaldo", @"Madridejos", @"Mostoles", @"Sevilla", @"Pontevedra", @"Puertollano",@"Palma de Mallorca", nil];
    
    //creo el controlador de la tabla que da los resultados
    _resultsTableController = [[NCTResultsTableController alloc] init];
    
    
    //creo el controlador del search, el cual tendra una referencia al resultsController
    _searchController = [[UISearchController alloc]initWithSearchResultsController:self.resultsTableController];



    //le encasqueto el search a la cabecera de la tabla
    [self.searchController.searchBar sizeToFit];
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    //defino el delegado del searchcontroller, asi me entero cuando dan a un boton, cuando aparece, etc como con textfield
    //el searchcontroller incluye el searchBar, asi que asigno el delegado del searchBar
    self.searchController.searchBar.delegate=self;
    
    //defino quien es el delegado del searchController, que no es lomismo que el searchBar. Éste esta incluido en el searchController, que es un controlador
    self.searchController.delegate=self;
    
    //ahora definimos quien se como la busqueda cada vez que pulsemos una tecla en el searchBar
    self.searchController.searchResultsUpdater=self;
    
    
    //self.resultsTableController.tablaOriginal=self;
    
    //podemos configurar unpoco la presentacion
    
    //si queremos que cuando se le de al searchBar se ponga el fondo de la tabla como con una capa gris (que es por defecto)
    //ponemos este valor a YES, si lo dejamos con NO no se cambia el alpha de la tabla
    self.searchController.dimsBackgroundDuringPresentation =NO;
    self.searchController.hidesNavigationBarDuringPresentation=NO;

}

#pragma mark - Table Delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"select row del mainTable");
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
    //NSLog(@"han pulsado sobre el searchController");
    
}

- (void)willPresentSearchController:(UISearchController *)searchController {
    // do something before the search controller is presented
    //NSLog(@"Se va a presentar el searchController");
}

- (void)didPresentSearchController:(UISearchController *)searchController {
    // do something after the search controller is presented
    //NSLog(@"Se ha presentado el searchController");
}

- (void)willDismissSearchController:(UISearchController *)searchController {
    // do something before the search controller is dismissed
    //NSLog(@"Va a desaparecer el searchController");
}

- (void)didDismissSearchController:(UISearchController *)searchController {
    // do something after the search controller is dismissed
    //NSLog(@"Ha desaparecido  el searchController");
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
    self.resultsTableController.filtered=[r mutableCopy];
    //una vez que le has pasado los datos nuevos al controlador le tienes que decir que recargue la tabla, si no no se muestra nada
    [self.resultsTableController.tableView reloadData];
}

-(void)updateUserActivityState:(NSUserActivity *)activity {
    NSLog(@"activity");
    
}
@end
