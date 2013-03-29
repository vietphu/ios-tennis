//
//  TennisViewController.h
//  Tennis
//
//  Created by Jason Michels on 3/28/13.
//  Copyright (c) 2013 Jason Michels. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TennisViewController : UIViewController{
    IBOutlet UIImageView *ball;
    IBOutlet UIImageView *racquet_yellow;
    IBOutlet UIImageView *racquet_green;
    IBOutlet UILabel *tapToBegin;
    
    IBOutlet UILabel *player_score;
    IBOutlet UILabel *computer_score;
    
    CGPoint ballVelocity;
    NSInteger gameState;
    
    NSInteger player_score_value;
    NSInteger computer_score_value;
}

@property(nonatomic, retain) IBOutlet UIImageView *ball;
@property(nonatomic, retain) IBOutlet UIImageView *racquet_yellow;
@property(nonatomic, retain) IBOutlet UIImageView *racquet_green;
@property(nonatomic, retain) IBOutlet UILabel *tapToBegin;

@property(nonatomic, retain) IBOutlet UILabel *player_score;
@property(nonatomic, retain) IBOutlet UILabel *computer_score;

@property(nonatomic) CGPoint ballVelocity;
@property(nonatomic) NSInteger gameState;

-(void)reset:(BOOL) newGame;

@end
