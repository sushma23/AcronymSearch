//
//  NetworkingManager.m
//  Acronym
//
//  Created by Sushma on 2/28/16.
//  Copyright © 2016 Sush. All rights reserved.
//

#import "NetworkingManager.h"
#define baseURL @"http://www.nactem.ac.uk/software/acromine/dictionary.py"

@implementation NetworkingManager

+ (void)requestDataWithParameters: (NSDictionary *)parameters
                   withCompletion: (void (^)(id responseData, NSError *error))completionBlock {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPResponseSerializer *serializer = [AFHTTPResponseSerializer serializer];
    
    serializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    manager.responseSerializer = serializer;
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];

    [manager GET:baseURL
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
                         
            NSError *error;
            id jsonSerializer = [NSJSONSerialization JSONObjectWithData:responseObject options:1 error:&error];
             
            //Validate data
            if(jsonSerializer){
                completionBlock(jsonSerializer,nil);
             }else{
                 completionBlock(nil,nil);
             }
        }
     
        //handle failure
        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error: %@", error);
            completionBlock(nil, error);
             
        }];
    
}

@end
