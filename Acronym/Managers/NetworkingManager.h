//
//  NetworkingManager.h
//  Acronym
//
//  Created by Sushma on 2/28/16.
//  Copyright © 2016 Sush. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

//AFNetworking calls integrated
@interface NetworkingManager : NSObject

+ (void)requestDataWithParameters: (NSDictionary *)parameters
                   withCompletion: (void (^)(id responseData, NSError *error))completionBlock;

@end
