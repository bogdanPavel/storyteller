//
//  Storyteller+Create.m
//  storyteller
//
//  Created by Bogdan Pavel on 02/03/2014.
//  Copyright (c) 2014 Bogdan Pavel. All rights reserved.
//

#import "Storyteller+Create.h"

@implementation Storyteller (Create)
+ (Storyteller*)storytellerWithName:(NSString*)name inManagedObjectContext:(NSManagedObjectContext*)context{
    Storyteller *storyteller = nil;
    
    if ([name length]){
        NSFetchRequest *request = [ NSFetchRequest fetchRequestWithEntityName:@"Storyteller"];
        request.predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
        
        NSError *error;
        NSArray *matches = [ context executeFetchRequest:request error:&error];
        
        if(!matches || ([matches count]>1)){
            //handle error
        }else if (![matches count]){
            storyteller = [NSEntityDescription insertNewObjectForEntityForName:@"Storyteller" inManagedObjectContext:context];
            storyteller.name = name;
        }else{
            storyteller = [matches lastObject];
        }
        
    }
    return storyteller;
}
@end
