//
//  Apple.m
//  Phonagotchi
//
//  Created by Viviane Chan on 2016-07-07.
//  Copyright © 2016 Lighthouse Labs. All rights reserved.
//

#import "Apple.h"

@implementation Apple


-(void)createApple {
UIImageView *apple = [[UIImageView alloc] initWithFrame:CGRectMake(200, 200, 40, 40)];
apple.translatesAutoresizingMaskIntoConstraints = YES;
apple.image = [UIImage imageNamed:@"apple"];
apple.userInteractionEnabled=YES;
[self.view addSubview:apple];

}



@end
