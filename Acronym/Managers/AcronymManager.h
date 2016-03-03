//
//  AcronymManager.h
//  Acronym
//
//  Created by Sushma on 2/28/16.
//  Copyright © 2016 Sush. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AcronymManager : NSObject

//gets the acronyms for the search text
- (void)getAcronyms: (NSString *)searchText
     withCompletion: (void (^)(NSArray *data, NSError *error, NSString *errorMessage))completionBlock;

@end
