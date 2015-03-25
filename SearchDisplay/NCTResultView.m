//
//  NCTResultView.m
//  SearchDisplay
//
//  Created by Vicente de Miguel on 23/3/15.
//  Copyright (c) 2015 Nicatec Software. All rights reserved.
//

#import "NCTResultView.h"

@interface NCTResultView ()

@property(strong,nonatomic) UILabel *label;

@end

@implementation NCTResultView

//esto no hace nada del otro mundo, muestra el nombre de la ciudad que has pulsado, si lo has pulsado desde la tabla original sale de un color y si es desde la tabla de datos filtrados es de otro color

-(id)initWithElement:(NSString *)element inResult:(BOOL)search{
    if ( self = [super init]) {
        _label=[[UILabel alloc]initWithFrame:CGRectMake(40, 100, 200, 40)];
        _label.text=element;
        
        //si es que si le pongo un colo si no le doy otro color, es solo para distiguir si ha venido del search o del maintable
        if ( search )
            _label.backgroundColor=[UIColor greenColor];
        else
            _label.backgroundColor=[UIColor yellowColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //añado el label a la vista
    [self.view addSubview:self.label];
}



@end
