//
//  NCTResultsTableController.h
//  SearchDisplay
//
//  Created by Vicente de Miguel on 23/3/15.
//  Copyright (c) 2015 Nicatec Software. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NCTMainTable;
@class NCTResultsTableController;


//defino un protodolo para comunicar de la tabla resultado a la tabla principal que se ha seleccionado una celda y le paso el contenido de la celda
@protocol NCTResultsTableControllerDelegate <NSObject>

@optional
-(void) resultsTableViewController:(NCTResultsTableController*) trC didSelectRow:(id) object;
@end

@interface NCTResultsTableController : UITableViewController 

@property(strong,nonatomic) NSMutableArray *filtered;
@property (strong,nonatomic) NCTMainTable *tablaOriginal;

//propiedad para relacionarme con con la tabla de resultados
@property (weak,nonatomic) id<NCTResultsTableControllerDelegate> resultsDelegate;

@end
