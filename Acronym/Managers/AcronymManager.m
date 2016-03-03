//
//  AcronymManager.m
//  Acronym
//
//  Created by Sushma on 2/28/16.
//  Copyright © 2016 Sush. All rights reserved.
//

#import "AcronymManager.h"
#import "NetworkingManager.h"

#define AcronymKey @"sf"
#define AcronymItemKeyDict @"lfs"
#define AcronymItemKey @"lf"

@implementation AcronymManager

- (void)getAcronyms: (NSString *)searchText
     withCompletion: (void (^)(NSArray *data, NSError *error, NSString *errorMessage))completionBlock {
    
    NSDictionary *pararmeters = [NSDictionary dictionaryWithObject:searchText forKey:AcronymKey];
    [NetworkingManager requestDataWithParameters: pararmeters withCompletion:^(id responseData, NSError *error) {
        if (error == nil) {
            if ([responseData isKindOfClass:[NSArray class]]) {
                completionBlock([self createAcronymArray:responseData], nil, nil);
            } else {
                completionBlock(nil, nil, @"Data not compatible");
            }
            
        } else {
            completionBlock(nil, error, error.localizedDescription);
        }
    }];
}

//create the result array
-(NSArray *)createAcronymArray:(NSArray *)responseData {
    NSMutableArray *acronyms = [[NSMutableArray alloc] init];
    for (NSDictionary *items in responseData){
        for (NSDictionary *item in items[AcronymItemKeyDict]) {
            [acronyms addObject: item[AcronymItemKey]];
        }
    }
    return acronyms;
}

@end
