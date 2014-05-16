//
//  SKViewController.m
//  SKPolygraph
//
//  Created by Sandor Kolotenko on 2014.05.16..
//  Copyright (c) 2014 Sandor Kolotenko. All rights reserved.
//

#import "SKViewController.h"
#import "SKPolygraph.h"

@interface SKViewController ()

@end

@implementation SKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)analyseText:(id)sender{
    [self.txtInput resignFirstResponder];
    float result = [[SKPolygraph sharedInstance] analyseSentiment:self.txtInput.text];
    if (result > 0) {
        [self.lblResult setText:@"Positive"];
    }
    else if(result < 0){
        [self.lblResult setText:@"Negative"];
    }
    else{
        [self.lblResult setText:@"Neutral"];
    }
    
    [self.lblScore setText:[NSString stringWithFormat:@"%f", result]];
}
@end
