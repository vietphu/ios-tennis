//
//  TennisViewController.m
//  Tennis
//
//  Created by Jason Michels on 3/28/13.
//  Copyright (c) 2013 Jason Michels. All rights reserved.
//

#import "TennisViewController.h"

#define kGameStateRunning 1
#define kGameStatePaused 2

#define kBallSpeedX 10
#define kBallSpeedY 15
#define kCompMoveSpeed 15

#define kScoreToWin 5

@interface TennisViewController ()

@end

@implementation TennisViewController
@synthesize ball, racquet_green, racquet_yellow, player_score, computer_score, gameState, ballVelocity, tapToBegin;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.gameState = kGameStatePaused;
    ballVelocity = CGPointMake(kBallSpeedX, kBallSpeedY);
    [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(gameLoop) userInfo:nil repeats:YES ];
}

- (void) gameLoop
{
    if (gameState == kGameStateRunning) {
        ball.center = CGPointMake(ball.center.x + ballVelocity.x, ball.center.y + ballVelocity.y);
        
        //Check for raquet collision
        if (CGRectIntersectsRect(ball.frame, racquet_yellow.frame)) {
            ballVelocity.y = -ballVelocity.y; 
        }
        
        if (CGRectIntersectsRect(ball.frame, racquet_green.frame)) {
            //todo add in way to stop the infinite stuck behind racquet
            ballVelocity.y = -ballVelocity.y;
        }
        
        //Begin simple AI
        if (ball.center.y <= self.view.center.y) {
            if (ball.center.x < racquet_green.center.x) {
                CGPoint compLocation = CGPointMake(racquet_green.center.x - kCompMoveSpeed, racquet_green.center.y);
                racquet_green.center = compLocation;
            }
            
            if (ball.center.x > racquet_green.center.x) {
                CGPoint compLocation = CGPointMake(racquet_green.center.x + kCompMoveSpeed, racquet_green.center.y);
                racquet_green.center = compLocation;
            }
        }
        
        //Begin scoring game logic
        if (ball.center.y <= 0) {
            player_score_value++;
            [self reset:(player_score_value >= kScoreToWin)];
        }
        
        if (ball.center.y > self.view.bounds.size.height) {
            computer_score_value++;
            [self reset:(computer_score_value >= kScoreToWin)];
        }
        
        //This checks if the ball goes out of bounds
        if (ball.center.x > self.view.bounds.size.width || ball.center.x < 0) {
            ballVelocity.x = -ballVelocity.x;
        }
        
        if (ball.center.y > self.view.bounds.size.height || ball.center.y < 0) {
            ballVelocity.y = -ballVelocity.y;
        }
        
        
        
    } else {
        if (tapToBegin.hidden) {
            tapToBegin.hidden = NO;
        }
    }
}

- (void)reset:(BOOL)newGame
{
    self.gameState = kGameStatePaused;
    ball.center = self.view.center;
    
    if (newGame) {
        if (computer_score_value > player_score_value) {
            tapToBegin.text = @"Computer Wins!";
        } else {
            tapToBegin.text = @"Player Wins!";
        }
        
        computer_score_value = 0;
        player_score_value = 0;
    } else {
        tapToBegin.text = @"Tap To Begin";
    }
    
    player_score.text = [NSString stringWithFormat:@"%d", player_score_value];
    computer_score.text = [NSString stringWithFormat:@"%d", computer_score_value];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (gameState == kGameStatePaused) {
        tapToBegin.hidden = YES;
        gameState = kGameStateRunning;
    } else {
        [self touchesMoved:touches withEvent:event];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:touch.view];
    CGPoint xLocation = CGPointMake(location.x, racquet_yellow.center.y);
    racquet_yellow.center = xLocation;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
