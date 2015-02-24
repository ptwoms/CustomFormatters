//
//  P2MSNumberFormatter.h
//  CustomFormatters
//
//  Created by Pyae Phyo Myint Soe on 24/2/15.
//  Copyright (c) 2015 Pyae Phyo Myint Soe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface P2MSNumberFormatter : NSNumberFormatter

@property (nonatomic, strong) NSString *flexibleDecimalPositiveFormat;
@property (nonatomic, strong) NSString *flexibleDecimalNegativeFormat;

@end
