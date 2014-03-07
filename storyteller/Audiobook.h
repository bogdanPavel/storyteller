//
//  Audiobook.h
//  storyteller
//
//  Created by Bogdan Pavel on 05/03/2014.
//  Copyright (c) 2014 Bogdan Pavel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Author, Chapter, Language, Storyteller;

@interface Audiobook : NSManagedObject

@property (nonatomic, retain) NSData * cover;
@property (nonatomic, retain) NSDate * dateLastModified;
@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * totalDuration;
@property (nonatomic, retain) NSString * synopsis;
@property (nonatomic, retain) NSData * audioPreview;
@property (nonatomic, retain) NSNumber * rating;
@property (nonatomic, retain) NSSet *storytellers;
@property (nonatomic, retain) NSSet *chapters;
@property (nonatomic, retain) Language *language;
@property (nonatomic, retain) NSSet *authors;
@end

@interface Audiobook (CoreDataGeneratedAccessors)

- (void)addStorytellersObject:(Storyteller *)value;
- (void)removeStorytellersObject:(Storyteller *)value;
- (void)addStorytellers:(NSSet *)values;
- (void)removeStorytellers:(NSSet *)values;

- (void)addChaptersObject:(Chapter *)value;
- (void)removeChaptersObject:(Chapter *)value;
- (void)addChapters:(NSSet *)values;
- (void)removeChapters:(NSSet *)values;

- (void)addAuthorsObject:(Author *)value;
- (void)removeAuthorsObject:(Author *)value;
- (void)addAuthors:(NSSet *)values;
- (void)removeAuthors:(NSSet *)values;

@end
