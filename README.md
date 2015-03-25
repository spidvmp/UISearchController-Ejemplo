#UISearchController iOS8

El UISearchController funciona de la siguiente manera:
Tenemos una UITableView origen, donde estan todos los datos que se quieren mostrar. Se crea un **UISearchController** al cual se le añade una segunda UITableView. Esta segunda tabla es la que se muestra con los datos filtrados. El **UISearchcontoller** se mete en la tabla origen y se encargara automaticamente de poner la tabla original o la de los datos filtrados segun se escriba o no en el UISearchBar
Cada UITableView lleva su delegate y su datasource, que pueden ser independientes por cada tabla o centralizarlo en la tabila original

En este ejemplo esta con los delegate y datasource independiente por cada tabla. Lo mas complicado esta en la tabla de datos filtrados, cuando pulsamos sobre una celda y queremos mostrar el detall de la celda pulsada. LA UITableView de los datos filtrados lo ha puesto el **UISearchController** por lo que no hay UINavigationController para poder hacer un push. 
