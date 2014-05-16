//
//  SKPolygraphTests.m
//  SKPolygraphTests
//
//  Created by Sandor Kolotenko on 2014.05.16..
//  Copyright (c) 2014 Sandor Kolotenko. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SKPolygraph.h"
#import "SKWord.h"

@interface SKPolygraphTests : XCTestCase

@end

@implementation SKPolygraphTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testDictionariesLoad
{
    int count = [[SKPolygraph sharedInstance] wordCount];
    XCTAssertTrue(count > 0, @"Dictionary is empty");
}

- (void)testDictionariesPositiveCount
{
    int count = [[SKPolygraph sharedInstance] wordCountPositive];
    XCTAssertTrue(count > 0, @"Positive dictionary is empty");
}

- (void)testDictionariesNegativeCount
{
    int count = [[SKPolygraph sharedInstance] wordCountNegative];
    XCTAssertTrue(count > 0, @"Negative dictionary is empty");
}

- (void)testAnalyzePositiveWord
{
    SKWord *word = [[SKPolygraph sharedInstance] analyseSentimentOfWord:@"warm"];
    XCTAssert(word.emotionalValue > 0.0f, @"Wrong emotional value for a positive word");
}


- (void)testAnalyzeNegativeWord
{
    SKWord *word = [[SKPolygraph sharedInstance] analyseSentimentOfWord:@"cold"];
    XCTAssert(word.emotionalValue < 0.0f, @"Wrong emotional value for a negative word");
}


- (void)testAnalyzeNonexistingWord
{
    SKWord *word = [[SKPolygraph sharedInstance] analyseSentimentOfWord:@"hasjdhkasj"];
    XCTAssert(word.emotionalValue == 0.0f, @"Wrong emotional value for a non-existing word");
}

- (void)testAnalyzePositivePhrase
{
    float score = [[SKPolygraph sharedInstance] analyseSentiment:@"That was a nice warm day!"];
    XCTAssert(score > 0.0f, @"Wrong emotional value for a positive phrase");
}

- (void)testAnalyzeNegativePhrase
{
    float score = [[SKPolygraph sharedInstance] analyseSentiment:@"It was cold and rainy."];
    XCTAssert(score < 0.0f, @"Wrong emotional value for a negative phrase");
}

- (void)testAnalyzeGibberish
{
    float score = [[SKPolygraph sharedInstance] analyseSentiment:@"Ez itt egy magyar szöveg."];
    XCTAssert(score == 0.0f, @"Wrong emotional value for a negative phrase");
}

@end
