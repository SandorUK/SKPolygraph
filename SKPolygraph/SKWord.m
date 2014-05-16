//
//  SKWord.m
//  SKPolygraph
//
//  Created by Sandor Kolotenko on 2014.05.16..
//  Copyright (c) 2014 Sandor Kolotenko. All rights reserved.
//

#import "SKWord.h"

@implementation SKWord

- (id)initWithWord:(NSString*)word andValue:(float)value{
    self = [super init];
    if (self) {
        _word = word;
        _emotionalValue = value;
    }
    
    return self;
}
@end
