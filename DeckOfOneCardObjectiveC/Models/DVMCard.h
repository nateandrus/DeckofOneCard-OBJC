//
//  DVMCard.h
//  DeckOfOneCardObjectiveC
//
//  Created by Nathan Andrus on 2/12/19.
//  Copyright © 2019 Nathan Andrus. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DVMCard : NSObject

@property (nonatomic, readonly, copy) NSString *suit;
@property (nonatomic, readonly, copy) NSString *image;

- (instancetype)initWithSuit: (NSString*)suit
                       image: (NSString*)image;

@end

@interface DVMCard (JSONConvertible)

- (instancetype)initWithJsonDictionary: (NSDictionary*)dicionary;

@end




NS_ASSUME_NONNULL_END
