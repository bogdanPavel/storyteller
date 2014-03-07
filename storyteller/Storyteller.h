//
//  Storyteller.h
//  storyteller
//
//  Created by Bogdan Pavel on 05/03/2014.
//  Copyright (c) 2014 Bogdan Pavel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Audiobook;

@interface Storyteller : NSManagedObject

@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * rating;
@property (nonatomic, retain) NSSet *audiobooks;
@end

@interface Storyteller (CoreDataGeneratedAccessors)

- (void)addAudiobooksObject:(Audiobook *)value;
- (void)removeAudiobooksObject:(Audiobook *)value;
- (void)addAudiobooks:(NSSet *)values;
- (void)removeAudiobooks:(NSSet *)values;

@end
