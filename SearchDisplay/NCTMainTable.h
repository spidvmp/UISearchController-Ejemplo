//
//  NCTMainTable.h
//  SearchDisplay
//
//  Created by Vicente de Miguel on 23/3/15.
//  Copyright (c) 2015 Nicatec Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NCTResultsTableController.h"




@interface NCTMainTable : UITableViewController <NCTResultsTableControllerDelegate>

@property ( strong,nonatomic) NSArray *elementos;



@end
