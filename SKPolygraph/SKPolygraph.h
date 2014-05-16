//
//  SKPolygraph.h
//  SKPolygraph
//
//  Created by Sandor Kolotenko on 2014.05.16..
//  Copyright (c) 2014 Sandor Kolotenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SKWord.h"

@interface SKPolygraph : NSObject{
    NSMutableArray *_dictionary;
    int _positiveCount;
    int _negativeCount;
}

+ (id)sharedInstance;

- (NSArray*)loadDictionaryFromFile:(NSString*)filename withValue:(float)value;
- (int)wordCount;
- (int)wordCountPositive;
- (int)wordCountNegative;

- (float)analyseSentiment:(NSString*)text;
- (SKWord*)analyseSentimentOfWord:(NSString*)word;
@end
