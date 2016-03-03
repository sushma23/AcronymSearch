//
//  CALayer+BorderProperties.m
//  Acronym
//
//  Created by Sushma on 3/2/16.
//  Copyright © 2016 Sush. All rights reserved.
//

#import "CALayer+BorderProperties.h"

@implementation CALayer (BorderProperties)

- (void)setBorderUIColor:(UIColor *)color {
    self.borderColor = color.CGColor;
}

- (UIColor *)borderUIColor {
    return [UIColor colorWithCGColor:self.borderColor];
}

@end