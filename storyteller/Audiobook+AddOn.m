//
//  Audiobook+AddOn.m
//  storyteller
//
//  Created by Bogdan Pavel on 01/03/2014.
//  Copyright (c) 2014 Bogdan Pavel. All rights reserved.
//

#import "Audiobook+AddOn.h"
#import "Storyteller+Create.h"

@implementation Audiobook (AddOn)

+ (Audiobook*)audiobookWithInfo:(NSDictionary*)audiobookDictionary inManagedObjectContext:(NSManagedObjectContext*)context{
    Audiobook * book=nil;
    
    NSString *id=[audiobookDictionary valueForKey:@"id"];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Audiobook"];
    request.predicate = [NSPredicate predicateWithFormat:@"id = %@",id];
    
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if (!matches || error || [matches count]>1){
        //handle error
    }else if ([matches count]){
        book = [matches firstObject];
    }else {
        book = [NSEntityDescription insertNewObjectForEntityForName:@"Audiobook" inManagedObjectContext:context];
        book.id=id;
        book.title = [audiobookDictionary valueForKey:@"title"];
        //book.coverURL = [audiobookDictionary valueForKey:@"coverURL"];
        //NSString *storytellerName= [audiobookDictionary valueForKey:@"storyteller"];
        //book.whoReads = [Storyteller storytellerWithName:storytellerName inManagedObjectContext:context];
    }
    return book;
}

-(void)prepareForDeletion{
    
}

@end
