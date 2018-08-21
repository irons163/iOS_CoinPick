//
//  Skill.m
//  Try_CoinPick
//
//  Created by irons on 2015/4/22.
//  Copyright (c) 2015年 irons. All rights reserved.
//

#import "Skill.h"

@implementation Skill{
    NSArray * skill1CostArray, * skill2CostArray;
    int moneySpeed;
    int moneyPerCoin;
    int moneyCreateSpeed;
    int moneySaveCapability;
    int touchEarnMoney;
}

-(void)skill{
    skill1CostArray = @[@100,@1000,@10000,@100000];
    skill2CostArray = @[@500,@5000,@50000,@500000];
//    skill3CostArray = @[@500,@5000,@50000,@500000];
//    skill4CostArray = @[@500,@5000,@50000,@500000];
//    skill5CostArray = @[@500,@5000,@50000,@500000];
}

SKSpriteNode * panel;
SKSpriteNode * skill, *skill2,* skill3, *skill4;

-(void)setPanel:(SKSpriteNode*)pal{
    panel = pal;
}

-(void)setSKill1:(SKSpriteNode*)skl{
    skill = skl;
}

-(void)setSKill2:(SKSpriteNode*)skl{
    skill2 = skl;
}

-(void)setSKill3:(SKSpriteNode*)skl{
    skill3 = skl;
}

-(void)setSKill4:(SKSpriteNode*)skl{
    skill4 = skl;
}

-(BOOL)checkTouch:(NSSet *)touches{
    UITouch * touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
//    CGRect rect = [controlPoint calculateAccumulatedFrame];
//    bool isCollision = CGRectContainsPoint(rect, location);
    if(CGRectContainsPoint(skill.calculateAccumulatedFrame, location)){
        
    }else if(CGRectContainsPoint(skill2.calculateAccumulatedFrame, location)){
        
    }
    
    return false;
}

-(void)touch{
    int currentSkill1Index = 0;
    int money = 0;
    money = money - (int)skill1CostArray[currentSkill1Index];
    currentSkill1Index++;
    [self doSkill1];
}

-(void)doSkill1{
    moneySpeed++;
}

-(void)touch2{
    
}

-(void)skill2{
    
}

-(void)doSkill2{
    moneyPerCoin = 50;
}

-(void)skill3{
    
}

-(void)touch3{
    
}

-(void)doSkill3{
    moneyCreateSpeed++;
}

-(void)doSkill4{
    moneySaveCapability++;
}

-(void)doSkill5{
    touchEarnMoney++;
}

@end
