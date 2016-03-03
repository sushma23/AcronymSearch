//
//  CALayer+BorderProperties.h
//  Acronym
//
//  Created by Sushma on 3/2/16.
//  Copyright © 2016 Sush. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CALayer (BorderProperties)

// This assigns a CGColor to borderColor.
@property (nonatomic, assign) UIColor* borderUIColor;

@end
