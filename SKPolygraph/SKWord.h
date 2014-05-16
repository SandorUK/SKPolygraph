//
//  SKWord.h
//  SKPolygraph
//
//  Created by Sandor Kolotenko on 2014.05.16..
//  Copyright (c) 2014 Sandor Kolotenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SKWord : NSObject
@property (nonatomic, readonly) NSString *word;
@property (nonatomic, readonly) float emotionalValue;

- (id)initWithWord:(NSString*)word andValue:(float)value;
@end
