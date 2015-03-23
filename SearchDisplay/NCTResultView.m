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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
