//
//  LPGViewController.m
//  Phonagotchi
//
//  Created by Steven Masuch on 2014-07-26.
//  Copyright (c) 2014 Lighthouse Labs. All rights reserved.
//

#import "LPGViewController.h"
#import "Pet.h"

@interface LPGViewController ()

@property (nonatomic) UIImageView *petImageView;
@property (nonatomic) UIImageView *appleImageView;
@property (nonatomic, strong) UIImageView *appleBasketImageView;
@property (nonatomic) UIImageView *bucketImageView;

@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, strong) UIPanGestureRecognizer *moveAppleGestureRecognizer;
@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGestureRecognizer;


@property (nonatomic, strong) Pet *cat;

@end

@implementation LPGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self prepareView];
    [self preparePet];
    [self prepareBucket];
    [self prepareApple];
    [self prepareGestureRecognizers];
}

#pragma mark - Preparation -
    
    - (void)prepareView {
        self.view.backgroundColor = [UIColor colorWithRed:(252.0/255.0) green:(240.0/255.0) blue:(228.0/255.0) alpha:1.0];
    }
    

- (void)preparePet {
    self.petImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.petImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.petImageView.image = [UIImage imageNamed:@"default"];
    self.petImageView.userInteractionEnabled=YES;
    [self.view addSubview:self.petImageView];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.petImageView
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.petImageView
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.0
                                                           constant:0.0]];
}

- (void)prepareApple{
    self.appleBasketImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.appleBasketImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.appleBasketImageView.image = [UIImage imageNamed:@"apple"];
    self.appleBasketImageView.userInteractionEnabled = YES;
    [self.view addSubview:self.appleBasketImageView];

    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.appleBasketImageView
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:-40.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.appleBasketImageView
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:-25.0]];

    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.appleBasketImageView
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:1.0
                                                           constant:40.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.appleBasketImageView
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:1.0
                                                           constant:40.0]];
    
}

- (void)prepareBucket{
    self.bucketImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.bucketImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.bucketImageView.image = [UIImage imageNamed:@"bucket"];
    self.bucketImageView.userInteractionEnabled=YES;
    [self.view addSubview:self.bucketImageView];

    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bucketImageView
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:-20.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bucketImageView
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:-20.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bucketImageView
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:1.0
                                                           constant:50.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bucketImageView
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:1.0
                                                           constant:50.0]];
    
}

- (void)prepareGestureRecognizers {
    [self preparePanGestureRecognizer];
    [self preparelongPressGestureRecognizer];
    [self prepareMoveAppleGestureRecognizer];
}



- (void)preparePanGestureRecognizer {
        self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panned:)];
        [self.petImageView addGestureRecognizer:self.panGestureRecognizer];
    }

- (void)preparelongPressGestureRecognizer {
    self.longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressed:)];
    [self.appleBasketImageView addGestureRecognizer:self.longPressGestureRecognizer];
}

- (void)prepareMoveAppleGestureRecognizer {
    self.moveAppleGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveApple:)];
    self.appleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 200, 40, 40)];
    [self.appleImageView addGestureRecognizer:self.moveAppleGestureRecognizer];
    
    
    //[self.view addGestureRecognizer:self.moveAppleGestureRecognizer];
}

#pragma mark - Gesture Recognizer Handlers -

#pragma mark Pan Gesture Recognizer Hanlders

- (void)panned:(UIPanGestureRecognizer *)recognizer {
    NSLog(@"panned");
    CGPoint velocity = [ self.panGestureRecognizer velocityInView:self.petImageView];
    if (velocity.x > 2500)
    {
    self.petImageView.image = [UIImage imageNamed:@"grumpy"];
    self.cat.isGrumpy = YES;
    }
}

- (void)moveApple:(UIPanGestureRecognizer *)recognizer {
    NSLog(@"apple moved");
    CGPoint location = [recognizer locationInView:self.view];
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
            break;
            
        case UIGestureRecognizerStateChanged:
            self.appleImageView.center = location;
            break;
        case UIGestureRecognizerStateEnded:
            
                [UIView animateWithDuration:1 animations:^{
                    _appleImageView.frame = CGRectMake(200, 400, 50, 50);
                    _appleImageView.alpha = 0.5;
                    _appleImageView.backgroundColor = [UIColor yellowColor];
                
            
            if (CGRectIntersectsRect([self.petImageView frame], [self.appleImageView frame])) {
                NSLog(@"Overlaped, it's working!");
                NSLog(@"UIGestureRecognizerStateEnded: end location = %f, %f", location.x, location.y);
            }
            break;
                }
    
        default:
            
            break;
                 }
    

#pragma mark - Long Gesture Recognizer Hanlders

- (void)longPressed:(UILongPressGestureRecognizer *)recognizer {
    NSLog(@"longPressed");
    
    switch (recognizer.state) {
            case UIGestureRecognizerStateBegan:
                
                self.appleImageView.translatesAutoresizingMaskIntoConstraints = YES;
                self.appleImageView.image = [UIImage imageNamed:@"apple"];
                [self.view addSubview:self.appleImageView];
                
                self.appleImageView.userInteractionEnabled = YES;
                
                break;
            case UIGestureRecognizerStateChanged:
                
                break;
            case UIGestureRecognizerStateEnded:
                
                break;
            default:

                break;
    }
}




@end
