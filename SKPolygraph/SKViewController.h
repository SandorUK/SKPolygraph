//
//  SKViewController.h
//  SKPolygraph
//
//  Created by Sandor Kolotenko on 2014.05.16..
//  Copyright (c) 2014 Sandor Kolotenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *lblResult;
@property (strong, nonatomic) IBOutlet UILabel *lblScore;
@property (strong, nonatomic) IBOutlet UIButton *btnAnalyse;
@property (strong, nonatomic) IBOutlet UITextField *txtInput;
- (IBAction)analyseText:(id)sender;
@end
