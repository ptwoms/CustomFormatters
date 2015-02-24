//
//  P2MSNumberFormatter.m
//  CustomFormatters
//
//  Created by Pyae Phyo Myint Soe on 24/2/15.
//  Copyright (c) 2015 Pyae Phyo Myint Soe. All rights reserved.
//

#import "P2MSNumberFormatter.h"

@interface P2MSNumberFormatter()

@property (nonatomic, strong) NSString *flexibleDecimalPositiveFormatFirstPart, *flexibleDecimalPositiveFormatSecondPart;
@property (nonatomic, strong) NSString *flexibleDecimalNegativeFormatFirstPart, *flexibleDecimalNegativeFormatSecondPart;

@end


@implementation P2MSNumberFormatter

- (NSString *)positiveFormat{
    if (_flexibleDecimalPositiveFormat.length) {
        return _flexibleDecimalPositiveFormat;
    }
    return [super positiveFormat];
}

- (NSString *)negativeFormat{
    if (_flexibleDecimalNegativeFormat.length) {
        return _flexibleDecimalNegativeFormat;
    }
    return [super negativeFormat];
}

- (void)setFDFormat:(NSString *)format formatBase:(NSString **)formatBase formatFirstPart:(NSString **)formatFirstPart formatSecondPart:(NSString **)formatSecondPart{
    NSRange dotRange = [format rangeOfString:@"."];
    if (dotRange.location == NSNotFound || dotRange.location+dotRange.length >= format.length) {//use original format
        (*formatBase) = nil;
        (*formatFirstPart) = nil;
        (*formatSecondPart) = nil;
    }else{
        (*formatBase) = format;
        (*formatFirstPart) = [format substringToIndex:dotRange.location];
        (*formatSecondPart) = [format substringFromIndex:dotRange.location+dotRange.length];
    }
}

- (void)setFlexibleDecimalPositiveFormat:(NSString *)flexibleDecimalPositiveFormat{
    NSString *formatBase, *firstPart, *secondPart;
    [self setFDFormat:flexibleDecimalPositiveFormat formatBase:&formatBase formatFirstPart:&firstPart formatSecondPart:&secondPart];
    _flexibleDecimalPositiveFormat = formatBase;
    _flexibleDecimalPositiveFormatFirstPart = firstPart;
    _flexibleDecimalPositiveFormatSecondPart = secondPart;
    if (formatBase == nil) {
        self.positiveFormat = flexibleDecimalPositiveFormat;
    }
}

- (void)setFlexibleDecimalNegativeFormat:(NSString *)flexibleDecimalNegativeFormat{
    NSString *formatBase, *firstPart, *secondPart;
    [self setFDFormat:flexibleDecimalNegativeFormat formatBase:&formatBase formatFirstPart:&firstPart formatSecondPart:&secondPart];
    _flexibleDecimalNegativeFormat = formatBase;
    _flexibleDecimalNegativeFormatFirstPart = firstPart;
    _flexibleDecimalNegativeFormatSecondPart = secondPart;
    if (formatBase == nil) {
        self.negativeFormat = flexibleDecimalNegativeFormat;
    }
}

- (NSString *)getFormatForValue:(double)doubleVal firstPart:(NSString *)firstPart secondPart:(NSString *)secondPart{
    double exponent = log10(fabs(doubleVal));
    unichar firstChar = [secondPart characterAtIndex:0];
    NSMutableString *finalFormat = [NSMutableString stringWithFormat:@"%@.", firstPart];
    if (exponent < 0) {
        double estimatedDigitPos = ceil(fabs(exponent));
        for (int i = 1; i < estimatedDigitPos; i++) {
            [finalFormat appendFormat:@"%c", firstChar];
        }
    }
    [finalFormat appendString:secondPart];
    NSLog(@"Final Format %@", finalFormat);
    return finalFormat;
}

- (NSString *)stringFromNumber:(NSNumber *)number{
    double doubleVal = [number doubleValue];
    if (doubleVal < 0) {
        if (_flexibleDecimalNegativeFormat.length) {
            NSLog(@"Negative format");
            [self setNegativeFormat:[self getFormatForValue:doubleVal firstPart:_flexibleDecimalNegativeFormatFirstPart secondPart:_flexibleDecimalNegativeFormatSecondPart]];
            
            //need to find out why the formatting is not working correctly if this line is omitted
            [self setPositiveFormat:[self getFormatForValue:-doubleVal firstPart:_flexibleDecimalPositiveFormatFirstPart secondPart:_flexibleDecimalPositiveFormatSecondPart]];
        }
    }else{
        if (_flexibleDecimalPositiveFormat.length) {
            NSLog(@"positive format");
            [self setPositiveFormat:[self getFormatForValue:doubleVal firstPart:_flexibleDecimalPositiveFormatFirstPart secondPart:_flexibleDecimalPositiveFormatSecondPart]];
        }
    }
    return [super stringFromNumber:number];
}

@end
