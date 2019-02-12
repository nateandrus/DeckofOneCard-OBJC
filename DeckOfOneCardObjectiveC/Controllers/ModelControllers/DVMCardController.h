//
//  DVMCardController.h
//  DeckOfOneCardObjectiveC
//
//  Created by Nathan Andrus on 2/12/19.
//  Copyright © 2019 Nathan Andrus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DVMCard.h"
#import <UIKit/UIKit.h>

@interface DVMCardController : NSObject

+ (void)drawANewCard:(NSInteger)cardCount completion: (void(^) (NSArray<DVMCard *> *cards, NSError *error))completion;

+ (void)fetchCardImage:(DVMCard *)cardImage completion: (void(^) (UIImage *cardImage, NSError *error))completion;

@end


