//
//  SKPolygraph.m
//  SKPolygraph
//
//  Created by Sandor Kolotenko on 2014.05.16..
//  Copyright (c) 2014 Sandor Kolotenko. All rights reserved.
//

#import "SKPolygraph.h"
#import "SKWord.h"
#define kPositiveDictionary @"positive-words"
#define kNegativeDictionary @"negative-words"

@implementation SKPolygraph

+ (id)sharedInstance {
    // Singleton implementation
    static SKPolygraph *sharedPolygraph = nil;
    static dispatch_once_t onceToken;
    
    // We need this to be thread safe
    dispatch_once(&onceToken, ^{
        sharedPolygraph = [[self alloc] init];
    });
    return sharedPolygraph;
}

- (id)init{
    // Load dictionaries on init
    self = [super init];
    if (self) {
        _dictionary = [[NSMutableArray alloc] init];
        NSArray *positive = [self loadDictionaryFromFile:kPositiveDictionary withValue:1.0f];
        NSArray *negative = [self loadDictionaryFromFile:kNegativeDictionary withValue:-1.0f];
        
        _positiveCount = [positive count];
        _negativeCount = [negative count];
        
        [_dictionary addObjectsFromArray:positive];
        [_dictionary addObjectsFromArray:negative];
    }
    
    return self;
}

- (int)wordCount{
    return [_dictionary count];
}

- (int)wordCountPositive{
    return _positiveCount;
}

- (int)wordCountNegative{
    return _negativeCount;
}

- (NSArray*)loadDictionaryFromFile:(NSString*)filename withValue:(float)value{
    // Dictionary loader
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSString* path = [[NSBundle mainBundle] pathForResource:filename
                                                     ofType:@"txt"];
    NSError *error;
    NSString *content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSASCIIStringEncoding
                                                     error:&error];
    
    if (!error) {
        NSArray *items = [content componentsSeparatedByString:@"\n"];
        if (items) {
            for (NSString *item in items) {
                if ([item length] > 0) {
                    if (![[item substringToIndex:1] isEqualToString:@";"] &&
                        ![[item substringToIndex:1] isEqualToString:@"\n"]) {
                    
                        SKWord *word = [[SKWord alloc] initWithWord:item andValue:value];
                        [result addObject:word];
                    }
                }
            }
        }
    }
    
    return [NSArray arrayWithArray:result];
}

- (float)analyseSentiment:(NSString *)text{
    // Here we use CFStringTokenizer to split text given into separate words
    // and then process them one-by-one
    
    float score = 0;
    
    CFStringRef string = (__bridge CFStringRef)text;
    CFLocaleRef locale = CFLocaleCopyCurrent();
    
    CFStringTokenizerRef tokenizer =
    CFStringTokenizerCreate(
                            kCFAllocatorDefault
                            , string
                            , CFRangeMake(0, CFStringGetLength(string))
                            , kCFStringTokenizerUnitWord
                            , locale);
    
    CFStringTokenizerTokenType tokenType = kCFStringTokenizerTokenNone;
    unsigned tokensFound = 0;
    
    while(kCFStringTokenizerTokenNone !=
          (tokenType = CFStringTokenizerAdvanceToNextToken(tokenizer))) {
        CFRange tokenRange = CFStringTokenizerGetCurrentTokenRange(tokenizer);
        CFStringRef tokenValue =
        CFStringCreateWithSubstring(
                                    kCFAllocatorDefault
                                    , string
                                    , tokenRange);
        
        // Process the word
        NSString *word = (__bridge NSString*)tokenValue;
        SKWord *processedWord = [self analyseSentimentOfWord:word];
        score += processedWord.emotionalValue;
        
        CFRelease(tokenValue);
        ++tokensFound;
    }
    
    // Clean up
    CFRelease(tokenizer);
    CFRelease(locale);
    
    return score;
}

- (SKWord*)analyseSentimentOfWord:(NSString *)word{
    NSString *cleanWord = [word stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    cleanWord = [cleanWord lowercaseString];
    
    // Not optimal search at all [O(n)], but okay for small dictionary (< 10 000 records)
    for (SKWord* dictionaryWord in _dictionary) {
        if ([dictionaryWord.word isEqualToString:cleanWord]) {
            return dictionaryWord;
        }
    }
    
    return [[SKWord alloc] initWithWord:word andValue:0.0f];
}
@end
