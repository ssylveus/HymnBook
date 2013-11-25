//
//  DetailViewController.h
//  Adventiste Hymnes
//
//  Created by Steeven Sylveus on 9/3/13.
//  Copyright (c) 2013 Steeven Sylveus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController<UIScrollViewDelegate, UITextViewDelegate>

@property(strong, nonatomic)NSString *tempString;

@property (strong, nonatomic) IBOutlet UITextView *detailTxt;
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@property(strong, nonatomic) UIPinchGestureRecognizer *pinchGestureRecognizer;
@end
