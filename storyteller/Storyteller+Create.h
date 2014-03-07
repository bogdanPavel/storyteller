//
//  Storyteller+Create.h
//  storyteller
//
//  Created by Bogdan Pavel on 02/03/2014.
//  Copyright (c) 2014 Bogdan Pavel. All rights reserved.
//

#import "Storyteller.h"

@interface Storyteller (Create)
+ (Storyteller*)storytellerWithName:(NSString*)name inManagedObjectContext:(NSManagedObjectContext*)context;

@end
