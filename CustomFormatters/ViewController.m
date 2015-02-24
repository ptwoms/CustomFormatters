//
//  ViewController.m
//  CustomFormatters
//
//  Created by Pyae Phyo Myint Soe on 24/2/15.
//  Copyright (c) 2015 Pyae Phyo Myint Soe. All rights reserved.
//

#import "ViewController.h"
#import "P2MSNumberFormatter.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    P2MSNumberFormatter *customFormatter = [[P2MSNumberFormatter alloc]init];
    [customFormatter setFlexibleDecimalPositiveFormat:@"#,###.00"];//min decimal places 2
    [customFormatter setFlexibleDecimalNegativeFormat:@"(#,###.00)"];
    //

    NSLog(@"Original Format %@", customFormatter.flexibleDecimalPositiveFormat);
    
    CGFloat number0 = 122.3344;
    NSLog(@"Format %f -> %@", number0, [customFormatter stringFromNumber:[NSNumber numberWithDouble:number0]]);
    
    CGFloat number1 = 122;
    NSLog(@"Format %f -> %@", number1, [customFormatter stringFromNumber:[NSNumber numberWithDouble:number1]]);
    
    CGFloat number2 = 0.122;
    NSLog(@"Format %f -> %@", number2, [customFormatter stringFromNumber:[NSNumber numberWithDouble:number2]]);

    CGFloat number3 = 0.0122;
    NSLog(@"Format %f -> %@", number3, [customFormatter stringFromNumber:[NSNumber numberWithDouble:number3]]);
    
    CGFloat number4 = 0.0000122;
    NSLog(@"Format %f -> %@", number4, [customFormatter stringFromNumber:[NSNumber numberWithDouble:number4]]);
    
    CGFloat number5 = -0.0000122;
    NSLog(@"Format %f -> %@", number5, [customFormatter stringFromNumber:[NSNumber numberWithDouble:number5]]);
    
    CGFloat number6 = -1222;
    NSLog(@"Format %f -> %@", number6, [customFormatter stringFromNumber:[NSNumber numberWithDouble:number6]]);


    //set nil to reset positive format
    [customFormatter setFlexibleDecimalPositiveFormat:nil];

    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
