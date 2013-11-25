//
//  DetailViewController.m
//  Adventiste Hymnes
//
//  Created by Steeven Sylveus on 9/3/13.
//  Copyright (c) 2013 Steeven Sylveus. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize detailTxt, tempString;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.detailTxt.editable = NO;
    
    [self.detailTxt setUserInteractionEnabled:YES];
    self.detailTxt.text = tempString;
    NSLog(@"%@", tempString);
    [self.detailTxt setScrollEnabled:YES];
    
    [self.myScrollView setScrollEnabled:NO];
    self.myScrollView.minimumZoomScale=1.0;
    self.myScrollView.maximumZoomScale=2.0;
    [self.myScrollView setContentSize:CGSizeMake(320, 900)];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadingHymn:)
                                                 name:@"loadHymn"
                                               object:nil];
    
    self.detailTxt.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed: @"music.jpg"]];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed: @"music.jpg"]];
    
    self.pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGesture:)];
    
    // And add it to your text view.
    [self.detailTxt addGestureRecognizer:self.pinchGestureRecognizer];
    
    // ...

    
}

- (void)pinchGesture:(UIPinchGestureRecognizer *)gestureRecognizer
{
	NSLog(@"*** Pinch: Scale: %f Velocity: %f", gestureRecognizer.scale, gestureRecognizer.velocity);
    
	UIFont *font = self.detailTxt.font;
	CGFloat pointSize = font.pointSize;
	NSString *fontName = font.fontName;
    
	pointSize = ((gestureRecognizer.velocity > 0) ? 1 : -1) * 1 + pointSize;
	
	if (pointSize < 10) pointSize = 10;
	if (pointSize > 30) pointSize = 30;
	
	self.detailTxt.font = [UIFont fontWithName:fontName size:pointSize];
	
	
}


-(void)loadingHymn:(NSNotification *)notification
{
    //[self updateMenuLabel:self.tempString];
    
    [self.myScrollView setScrollEnabled:YES];
    self.myScrollView.minimumZoomScale=1.0;
    self.myScrollView.maximumZoomScale=2.0;
    [self.myScrollView setContentSize:CGSizeMake(320, 900)];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
