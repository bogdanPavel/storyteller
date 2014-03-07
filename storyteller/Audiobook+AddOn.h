//
//  Audiobook+AddOn.h
//  storyteller
//
//  Created by Bogdan Pavel on 01/03/2014.
//  Copyright (c) 2014 Bogdan Pavel. All rights reserved.
//

#import "Audiobook.h"

@interface Audiobook (AddOn)
+ (Audiobook*)audiobookWithInfo:(NSDictionary*)audiobookDictionary inManagedObjectContext:(NSManagedObjectContext*)context;

@end
