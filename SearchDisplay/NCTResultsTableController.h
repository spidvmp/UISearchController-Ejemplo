//
//  NCTResultsTableController.h
//  SearchDisplay
//
//  Created by Vicente de Miguel on 23/3/15.
//  Copyright (c) 2015 Nicatec Software. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NCTMainTable;

@interface NCTResultsTableController : UITableViewController

@property(strong,nonatomic) NSMutableArray *filtered;
@property (strong,nonatomic) NCTMainTable *tablaOriginal;

@end
