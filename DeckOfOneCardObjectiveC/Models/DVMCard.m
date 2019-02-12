//
//  DVMCard.m
//  DeckOfOneCardObjectiveC
//
//  Created by Nathan Andrus on 2/12/19.
//  Copyright © 2019 Nathan Andrus. All rights reserved.
//

#import "DVMCard.h"

@implementation DVMCard

+ (NSString *)suitKey { return @"suit"; }
+ (NSString *)imageKey { return @"image"; }

- (instancetype)initWithSuit:(NSString *)suit image:(NSString *)image
{
    self = [super init];
    if (self) {
        _suit = suit;
        _image = image;
    }
    return self;
}
@end

@implementation DVMCard (JSONConvertible)


- (instancetype)initWithJsonDictionary:(NSDictionary *)dictionary
{
  
    NSString *suit = dictionary[[DVMCard suitKey]];
    NSString *image = dictionary[[DVMCard imageKey]];

    return [self initWithSuit:suit image:image];
}


@end
