//
//  DVMCardController.m
//  DeckOfOneCardObjectiveC
//
//  Created by Nathan Andrus on 2/12/19.
//  Copyright © 2019 Nathan Andrus. All rights reserved.
//

#import "DVMCardController.h"
#import "DVMCard.h"

@implementation DVMCardController

//https://deckofcardsapi.com/api/deck/new/draw/?count=1
static NSString * const baseURLString = @"https://deckofcardsapi.com/api/deck/new/draw/";


+ (instancetype)sharedController
{
    static DVMCardController *sharedController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedController = [[DVMCardController alloc] init];
    });
    return sharedController;
}


+ (void)drawANewCard:(NSInteger)numberOfCards completion: (void(^) (NSArray<DVMCard *> *_Nullable , NSError *error))completion
{

    NSString *cardCount = [NSString stringWithFormat:(@"%lx"), (long)numberOfCards];
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURLComponents *componentsWithURL = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:YES];
    NSURLQueryItem *drawCount = [NSURLQueryItem queryItemWithName:@"count" value: cardCount];
    componentsWithURL.queryItems = @[drawCount];
    NSURL * finalSearchURL = componentsWithURL.URL;
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalSearchURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error receiving data from URL");
            completion(nil, nil);
            return;
        }
        if (response) {
            NSLog(@"%@", response);
        }
        if (data) {
            NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error: &error];
            NSArray *cardsArray = jsonDictionary[@"cards"];
            NSMutableArray *cardsPlaceholder = [NSMutableArray array];
            for (id cardsDictionary in cardsArray) {
                DVMCard *newCard = [[DVMCard alloc] initWithJsonDictionary:cardsDictionary];
                [cardsPlaceholder addObject:newCard];
            }
            completion(cardsPlaceholder, nil);
        }
    }] resume];
}




+ (void)fetchCardImage:(DVMCard *)card completion: (void(^) (UIImage * _Nullable, NSError *error))completion
{
    NSURL *imageURL = [NSURL URLWithString: card.image];
    [[[NSURLSession sharedSession] dataTaskWithURL:imageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"There was an error receiving image from URL");
            completion(nil, nil);
            return;
        }
        if (data) {
            UIImage *cardImage = [UIImage imageWithData:data];
            completion(cardImage, nil);
        }
    }] resume];
}

@end
