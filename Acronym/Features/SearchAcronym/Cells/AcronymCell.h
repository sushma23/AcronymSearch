//
//  AcronymCell.h
//  Acronym
//
//  Created by Sushma on 2/28/16.
//  Copyright © 2016 Sush. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AcronymCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *name;
+(NSString *)identifier;

@end
