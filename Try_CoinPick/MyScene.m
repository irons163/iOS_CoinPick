//
//  MyScene.m
//  Try_CoinPick
//
//  Created by irons on 2015/4/22.
//  Copyright (c) 2015年 ___FULLUSERNAME___. All rights reserved.
//

#import "MyScene.h"
#import "TextureHelper.h"
#import "MyCoin.h"
#import "Skill.h"

@implementation MyScene{
    int playerInitX, playerInitY;
    Boolean isGameRun;
    int ccount;
    int gameLevel;
    int score;                                                                                                
    SKSpriteNode * backgroundNode;
    SKSpriteNode * player;
    SKSpriteNode * controller;
    SKSpriteNode * treatureBox;
//    SKSpriteNode * coin;
    SKSpriteNode * coin10, * coin30, * coin50;
    SKSpriteNode * controlPoint;
    SKLabelNode * gameLevelNode;
    SKSpriteNode * buttonNode;
    
    SKSpriteNode * panel;
    SKSpriteNode * skill1Btn, * skill2Btn, * skill3Btn;
    
    SKSpriteNode * skillAreaBtn;
    
    SKSpriteNode * itemBar;
    SKSpriteNode * item1, * item2, * item3;
    SKSpriteNode * skillArea;
    SKSpriteNode * infoArea;
    SKLabelNode *scoreLabel;
    
    NSMutableArray * scoreArray;
    NSMutableArray * moneyForPerHitLabelArray;
    NSMutableArray * contactQueue;
    
}

static const uint32_t projectileCategory     =  0x1 << 0;
static const uint32_t monsterCategory        =  0x1 << 1;
static const uint32_t toolCategory        =  0x1 << 2;
static const uint32_t catCategory        =  0x1 << 3;
static const uint32_t hamsterCategory        =  0x1 << 5;
static const uint32_t coinCategory        =  0x1 << 6;
static int barInitX, barInitY;
bool isShootEnable = false;

bool isMoveBar = false;

bool isMoveAble = true;

CGPoint p;

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        
        self.physicsWorld.gravity = CGVectorMake(0,0);
        self.physicsWorld.contactDelegate = self;
        
        isGameRun = true;
        
        [TextureHelper initTextures];
        
        contactQueue = [[NSMutableArray alloc] init];
        moneyForPerHitLabelArray = [[NSMutableArray alloc] init];
        
        backgroundNode = [SKSpriteNode spriteNodeWithImageNamed:@"bg02"];
        
        backgroundNode.size = self.frame.size;
        backgroundNode.anchorPoint = CGPointMake(0, 0);
        backgroundNode.position = CGPointMake(0, 0);
        
        [self addChild:backgroundNode];
        
        player = [SKSpriteNode spriteNodeWithTexture:nil size:CGSizeMake(50, 50)];
        
        buttonNode = [SKSpriteNode spriteNodeWithImageNamed:@"control_point"];
        
        buttonNode.size = CGSizeMake(60, 60);
        
        playerInitX = player.size.width/2;
        playerInitY = player.size.height + 40;
        buttonNode.position = CGPointMake(playerInitX, playerInitY);
        
        buttonNode.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:player.size.width/2];
        buttonNode.physicsBody.dynamic = YES;
        buttonNode.physicsBody.categoryBitMask = hamsterCategory;
        buttonNode.physicsBody.contactTestBitMask = monsterCategory|toolCategory;
        buttonNode.physicsBody.collisionBitMask = 0;
        
        [self addChild:buttonNode];
        
        
        panel = [SKSpriteNode spriteNodeWithImageNamed:@"frame"];
        panel.anchorPoint = CGPointZero;
        panel.size = CGSizeMake(200, 200);
        panel.position = CGPointMake(self.frame.size.width/2 - panel.size.width/2, self.frame.size.height/2 - panel.size.height/2);
        [self addChild:panel];
        
//        panel.add Skill
        
        skill1Btn = [SKSpriteNode spriteNodeWithImageNamed:@"treatureBox01"];
        skill1Btn.anchorPoint = CGPointZero;
        skill1Btn.size = CGSizeMake(80, 80);
//        skill1Btn.position = CGPointMake(panel.position.x, panel.position.y);
        skill1Btn.position = CGPointMake(0, 0);
        
        
        [panel addChild:skill1Btn];
//        [self addChild:skill1Btn];
        
        skill2Btn = [SKSpriteNode spriteNodeWithImageNamed:@"treatureBox01"];
        skill2Btn.anchorPoint = CGPointZero;
        skill2Btn.size = CGSizeMake(80, 80);
        skill2Btn.position = CGPointMake(skill1Btn.position.x, skill1Btn.position.y+80);
        
        [panel addChild:skill2Btn];
//        [self addChild:skill2Btn];
        
        skill3Btn = [SKSpriteNode spriteNodeWithImageNamed:@"treatureBox01"];
        skill3Btn.anchorPoint = CGPointZero;
        skill3Btn.size = CGSizeMake(80, 50);
        skill3Btn.position = CGPointMake(panel.position.x, panel.position.y+100);
        
        [panel addChild:skill3Btn];
//        [self addChild:skill3Btn];
        
//        [panel addChild:];
        
        skillAreaBtn = [SKSpriteNode spriteNodeWithImageNamed:@"coin_10_btn01"];
        skillAreaBtn.size = CGSizeMake(80, 50);
        skillAreaBtn.position = CGPointMake(panel.position.x, panel.position.y+150);
        [self addChild:skillAreaBtn];
        
        NSArray * nsArray = [TextureHelper getTexturesWithSpriteSheetNamed:@"hamster" withinNode:nil sourceRect:CGRectMake(0, 0, 192, 200) andRowNumberOfSprites:2 andColNumberOfSprites:7
                                                                  sequence:@[@7]];
        
        //        self.player = [SKSpriteNode spriteNodeWithImageNamed:@"player"];
        player = [SKSpriteNode spriteNodeWithTexture:nsArray[0]];
        
        player.size = CGSizeMake(60, 60);
        
        playerInitX = player.size.width/2;
        playerInitY = player.size.height + 40;
        player.position = CGPointMake(playerInitX, playerInitY);
        
        
        
        player.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:player.size.width/2];
        player.physicsBody.dynamic = YES;
        player.physicsBody.categoryBitMask = hamsterCategory;
        player.physicsBody.contactTestBitMask = monsterCategory|toolCategory;
        player.physicsBody.collisionBitMask = 0;
        
        [self addChild:player];
        
        controlPoint = [SKSpriteNode spriteNodeWithImageNamed:@"control_point"];
        controlPoint.size = CGSizeMake(50, 50);
        //        barInitX = self.controlPoint.size.width/2;
        barInitX = playerInitX;
        barInitY = controlPoint.size.height;
        controlPoint.position = CGPointMake(barInitX, barInitY);
        [self addChild:controlPoint];
        
        
        treatureBox = [SKSpriteNode spriteNodeWithImageNamed:@"treatureBox01"];
        treatureBox.size = CGSizeMake(100, 100);
        treatureBox.position = CGPointMake(200, 400);
        
        
//        SKAction * upaction = [SKAction ];
        
        SKAction* upAction = [SKAction moveByX:0 y:50 duration:0.5];
        upAction.timingMode = SKActionTimingEaseOut;
        SKAction* downAction = [SKAction moveByX:0 y:-50 duration: 0.5]; downAction.timingMode = SKActionTimingEaseIn;
        // 3
        //        topNode.runAction(SKAction.sequence(
        //                                            [upAction, downAction, SKAction.removeFromParent()]))
        
        SKAction* upEnd = [SKAction runBlock:^{
//            sheep.texture = [SKTexture textureWithImageNamed:@"sheep_jump3"];
        }];
        
        SKAction* horzAction = [SKAction moveToX:50 duration:1.0];
        
        SKAction * end;
        
        end = [SKAction runBlock:^{
            [coin10 removeAllActions];
//            [sheepArrayLeft addObject:sheep];
//            if(coin10.count > sheepLeftMax){
//                SKSpriteNode* removeSheep = sheepArrayLeft[0];
//                SKAction* removeAction = [SKAction moveTo:CGPointMake(-removeSheep.size.width, removeSheep.position.y) duration:2];
//                SKAction* removeEnd = [SKAction runBlock:^{
//                    [removeSheep removeFromParent];
//                    [sheepArrayLeft removeObjectAtIndex:0];
//                }];
//                [removeSheep runAction:[SKAction sequence:@[removeAction, removeEnd]]];
            
//            }
//            [self changeGamePoint];
//            [self sheepWalkL:sheep];
        }];
        
        
//        [textureBox runAction:];
        
        
        
        [self addChild:treatureBox];
        
        coin10 = [SKSpriteNode spriteNodeWithImageNamed:@"coin_10_btn01"];
        coin10.size = CGSizeMake(50, 50);
        coin10.position = CGPointMake(100 + coin10.size.width, 0);
        
        [self addChild:coin10];
        
        [coin10 runAction:[SKAction group:@[[SKAction sequence:@[upAction, upEnd, downAction, end]], horzAction]]];
        
        //        coin10Btn
        
//        CGSize coinMaskDisplaySise = CGSizeMake((coin10Btn.position.x - disapearX), coin10Btn.size.height);
//        
//        SKSpriteNode *coinMask = [SKSpriteNode spriteNodeWithColor:[SKColor whiteColor] size:coinMaskDisplaySise];
//        
//        coinMask.anchorPoint = coin10.anchorPoint;
//        
//        coinMask.position = coin10.position;
//        //        coinMask.position = CGPointMake(disapearX, coin10Btn.position.y);
//        
//        SKCropNode * coinCropNode = [SKCropNode node];
//        //        SKSpriteNode *mask = [SKSpriteNode spriteNodeWithColor:[SKColor yellowColor] size: CGSizeMake(1, 1)];
//        
//        [coinCropNode addChild:coin10];
//        
//        coinCropNode.maskNode = coinMask;
//        
//        //        [node addChild:mask];
//        
//        [self addChild:coinCropNode];
        
        
        
        
        coin30 = [SKSpriteNode spriteNodeWithImageNamed:@"coin_30_btn01"];
        coin30.size = CGSizeMake(50, 50);
        coin30.position = CGPointMake(100 + coin30.size.width*2, 100);
        
        [self addChild:coin30];
        
        coin50 = [SKSpriteNode spriteNodeWithImageNamed:@"coin_50_btn01"];
        coin50.size = CGSizeMake(50, 50);
        coin50.position = CGPointMake(100 + coin50.size.width*3, 100);
        
        [self addChild:coin50];
        

        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
        myLabel.text = @"Hello, World!";
        myLabel.fontSize = 30;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame));
        
        [self addChild:myLabel];
        
        [self showScore];
    }
    return self;
}

-(void)changeBG{
    backgroundNode.texture = [TextureHelper bgTextures][gameLevel];
}

-(void)changeGameLevelNode{
    gameLevelNode = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    
    gameLevelNode.text = @"10";
    gameLevelNode.fontColor = [UIColor greenColor];
    gameLevelNode.fontSize = 30;
    gameLevelNode.position = CGPointMake(CGRectGetMidX(self.frame),
                                   CGRectGetMidY(self.frame) - 50);
    
    [self addChild:gameLevelNode];
}

-(void) throwCoin:(SKSpriteNode *)coin{
    
    int randomX = arc4random_uniform(self.size.width);
    
    SKAction* upAction = [SKAction moveByX:0 y:50 duration:0.5];
    upAction.timingMode = SKActionTimingEaseOut;
    SKAction* downAction = [SKAction moveByX:0 y:-coin.position.y duration: 1.5]; downAction.timingMode = SKActionTimingEaseIn;
    // 3
    //        topNode.runAction(SKAction.sequence(
    //                                            [upAction, downAction, SKAction.removeFromParent()]))
    
    SKAction* upEnd = [SKAction runBlock:^{
        //            sheep.texture = [SKTexture textureWithImageNamed:@"sheep_jump3"];
    }];
    
    SKAction* horzAction = [SKAction moveToX:randomX duration:2];
    
    SKAction * end;
    
    end = [SKAction runBlock:^{
        [coin10 removeAllActions];
        //            [sheepArrayLeft addObject:sheep];
        //            if(coin10.count > sheepLeftMax){
        //                SKSpriteNode* removeSheep = sheepArrayLeft[0];
        //                SKAction* removeAction = [SKAction moveTo:CGPointMake(-removeSheep.size.width, removeSheep.position.y) duration:2];
        //                SKAction* removeEnd = [SKAction runBlock:^{
        //                    [removeSheep removeFromParent];
        //                    [sheepArrayLeft removeObjectAtIndex:0];
        //                }];
        //                [removeSheep runAction:[SKAction sequence:@[removeAction, removeEnd]]];
        
        //            }
        //            [self changeGamePoint];
        //            [self sheepWalkL:sheep];
    }];
//    coin10 = [SKSpriteNode spriteNodeWithImageNamed:@"coin_10_btn01"];
//    coin10.size = CGSizeMake(50, 50);
//    coin10.position = CGPointMake(100 + coin10.size.width, 0);
//    
//    [self addChild:coin10];
    
    [coin runAction:[SKAction group:@[[SKAction sequence:@[upAction, upEnd, downAction, end]], horzAction]]];
}

-(void)randomNewCoin{
    int randomNum = 3;
    int random = arc4random_uniform(randomNum);
    
    switch (random) {
        case 0:
            [self newCoin10];
            break;
        case 1:
            [self newCoin30];
            break;
        case 2:
            [self newCoin50];
            break;
        default:
            break;
    }
    
}

-(void)newCoin10{
    MyCoin * coin = [MyCoin spriteNodeWithImageNamed:@"coin_10_btn01"];
    coin.size = CGSizeMake(50, 50);
    coin.position = CGPointMake(100 + coin.size.width, 0);
    
    coin.position = treatureBox.position;
    
    coin.money = 10;
    
    [self setCoinCategory:coin];
    
    [self addChild:coin];
    
    [self throwCoin:coin];
}

-(void)newCoin30{
    MyCoin * coin = [MyCoin spriteNodeWithImageNamed:@"coin_30_btn01"];
    coin.size = CGSizeMake(50, 50);
    coin.position = CGPointMake(100 + coin.size.width, 0);
    
    coin.position = treatureBox.position;
    
    coin.money = 30;
    
    [self setCoinCategory:coin];
    
    [self addChild:coin];
    
    [self throwCoin:coin];
}

-(void)newCoin50{
    MyCoin * coin = [MyCoin spriteNodeWithImageNamed:@"coin_50_btn01"];
    coin.size = CGSizeMake(50, 50);
    coin.position = CGPointMake(100 + coin.size.width, 0);
    
    coin.position = treatureBox.position;
    
    coin.money = 50;
    
    [self setCoinCategory:coin];
    
    [self addChild:coin];
    
    [self throwCoin:coin];
}

-(void)setCoinCategory:(SKSpriteNode*)coin{
    coin.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:coin.size.width/2];
    coin.physicsBody.dynamic = YES;
    coin.physicsBody.categoryBitMask = coinCategory;
    coin.physicsBody.contactTestBitMask = hamsterCategory;
    coin.physicsBody.collisionBitMask = 0;
}

-(void)showScore{
    scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    
    scoreLabel.text = [NSString stringWithFormat:@"%d",score];
    scoreLabel.fontSize = 50;
    scoreLabel.fontColor = [UIColor blueColor];
    scoreLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                   CGRectGetMidY(self.frame));
    
    [self addChild:scoreLabel];
}

-(void)setCoin{
    SKLabelNode * label = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    label.text = @"1";
    label.fontSize = 50;
    label.fontColor = [UIColor redColor];
    label.position = CGPointMake(treatureBox.position.x, treatureBox.position.y);
    [moneyForPerHitLabelArray addObject:label];
    
    SKAction * action = [SKAction moveByX:0 y:40 duration:2];
    
    SKAction * remove = [SKAction runBlock:^{
        [label removeFromParent ];
    }];
    
    [label runAction:action];
    
    [self addChild:label];
}

-(void)coin:(MyCoin *) coin didCollideWithHamster:(SKSpriteNode *) hamster{
    
    if(coin.hidden||coin==nil){
        return;
    }
    
    coin.hidden = true;
    
//    if(self.fire.hidden && !isInvinceble){
//        hp--;
        //    [self shake:10];
        
//        [hamster removeAllActions];
//        [hamster setTexture:[TextureHelper hamsterInjureTexture]];
    
//        if(hp<=0){
//            isGameRun = NO;
//            //            self.onGameEnd2(YES);
//            for (int i =0; i < [spriteNodes count]; i++) {
//                SKSpriteNode * m = [spriteNodes objectAtIndex:i];
//                [m removeAllActions];
//                //                [m removeFromParent];
//                //        [spriteNodes removeObjectAtIndex:i];
//            }
//            self.onGameOver(gameLevel, gameTime);
//            return;
//            
//        }
//        isInvinceble = true;
//        isMoveAble = false;
//        isShootEnable = false;
    
//        NSTimer * timer =  [NSTimer scheduledTimerWithTimeInterval:2.0
//                                                            target:self
//                                                          selector:@selector(hamsterInjureTime)
//                                                          userInfo:nil
//                                                           repeats:NO];
//    }
    
    
    score += coin.money;
    
    scoreLabel.text = [NSString stringWithFormat:@"%d",score];
    
    [coin removeFromParent];
    coin = nil;
}


- (void)didBeginContact:(SKPhysicsContact *)contact
{
    [contactQueue addObject:contact];
    
}

-(void)processContactsForUpdate
{
    for (SKPhysicsContact * contact in [contactQueue copy]) {
        [self handleContact:contact];
        [contactQueue removeObject:contact];
    }
}

-(void) handleContact:(SKPhysicsContact *)contact
{
    NSLog(@"contact");
    // What you are doing in your current didBeginContact method
    // 1
    SKPhysicsBody *firstBody, *secondBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask)
    {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }
    else
    {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    if ((firstBody.categoryBitMask & hamsterCategory) != 0 &&
        (secondBody.categoryBitMask & coinCategory) != 0)
    {
        NSLog(@"will do didCollideWithMonster");
        [self coin:(SKSpriteNode *) secondBody.node didCollideWithHamster:(SKSpriteNode *) firstBody.node];
        
    }

    
    // 2
//    if ((firstBody.categoryBitMask & projectileCategory) != 0 &&
//        (secondBody.categoryBitMask & monsterCategory) != 0)
//    {
//        NSLog(@"will do didCollideWithMonster");
//        [self projectile:(SKSpriteNode *) firstBody.node didCollideWithMonster:(SKSpriteNode *) secondBody.node];
//        
//    }
//
//    else if ((firstBody.categoryBitMask & projectileCategory) != 0 &&
//             (secondBody.categoryBitMask & toolCategory) != 0)
//    {
//        NSLog(@"will do didCollideWithTool");
//        [self projectile:(SKSpriteNode *) firstBody.node didCollideWithTool:(SKSpriteNode *) secondBody.node];
//    }
//    
//    else if ((firstBody.categoryBitMask & projectileCategory) != 0 &&
//             (secondBody.categoryBitMask & catCategory) != 0)
//    {
//        NSLog(@"will do didCollideWithCat");
//        [self projectile:(Bullet *) firstBody.node didCollideWithCat:(SKSpriteNode *) secondBody.node];
//    }
//    
//    else if ((firstBody.categoryBitMask & monsterCategory) != 0 &&
//             (secondBody.categoryBitMask & hamsterCategory) != 0)
//    {
//        NSLog(@"will do didCollideWithHamster");
//        [self monster:(SKSpriteNode *) firstBody.node didCollideWithHamster:(SKSpriteNode *) secondBody.node];
//    }
//    
//    else if ((firstBody.categoryBitMask & toolCategory) != 0 &&
//             (secondBody.categoryBitMask & hamsterCategory) != 0)
//    {
//        NSLog(@"will do didhumsterCollideWithTool");
//        [self humster:(SKSpriteNode *) secondBody.node didhumsterCollideWithTool:(Tool *) firstBody.node];
//    }
    
    //    firstBody.node.hidden = true;
    //    [firstBody.node removeFromParent];
    //    [secondBody.node removeFromParent];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
//    for (UITouch *touch in touches) {
//        CGPoint location = [touch locationInNode:self];
//        
//        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
//        
//        sprite.position = location;
//        
//        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
//        
//        [sprite runAction:[SKAction repeatActionForever:action]];
//        
//        [self addChild:sprite];
//    }
    
    [self randomNewCoin];
    
    UITouch * touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    CGRect rect = [controlPoint calculateAccumulatedFrame];
    bool isCollision = CGRectContainsPoint(rect, location);
    if(isCollision){
        p = location;
        isMoveBar = true;
        isShootEnable = true;
    }
    
    [self setCoin];
    
    [self changeBG];
    gameLevel++;
    
    if(CGRectContainsPoint(skillAreaBtn.calculateAccumulatedFrame, location)){
        
        panel.hidden = false;
        
    }
    
    Skill* skill = [Skill new];
    [skill checkTouch:touches];
    
    CGPoint locationInPanel = [touch locationInNode:panel];
    
    if(CGRectContainsPoint(skill1Btn.calculateAccumulatedFrame, locationInPanel)){
        panel.hidden = true
        ;
    }
    
    if(CGRectContainsPoint(skill2Btn.calculateAccumulatedFrame, locationInPanel)){
        panel.hidden = true
        ;
    }
    
    if(CGRectContainsPoint(skill3Btn.calculateAccumulatedFrame, location)){
        panel.hidden = true
        ;
    }
    
//    if(self.pauseBtnNode.hidden==false){
//        rect = [self.pauseBtnNode calculateAccumulatedFrame];
//        isCollision = CGRectContainsPoint(rect, location);
//        if(isCollision){
//            [self setGameRun:YES];
//            [self setViewRun:YES];
//        }
//    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    if(isMoveBar && isMoveAble){
        
        
        
        UITouch * touch = [touches anyObject];
        CGPoint location = [touch locationInNode:self];
        
        CGFloat offx = location.x - p.x;
        CGPoint position = controlPoint.position;
        position.x = position.x + offx;
        controlPoint.position = position;
        
        position = player.position;
        position.x = position.x + offx;
        player.position = position;
        
        p = location;
        
//        fire.position = player.position;
        
        if(offx > 8){
            player.xScale = -1;
            
//            player.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:player.size.width/2];
//            player.physicsBody.dynamic = YES;
//            player.physicsBody.categoryBitMask = hamsterCategory;
//            player.physicsBody.contactTestBitMask = monsterCategory|toolCategory;
//            player.physicsBody.collisionBitMask = 0;
//            player.physicsBody.usesPreciseCollisionDetection = YES;
            
            TextureHelper *textureHelper = [TextureHelper alloc];
            
            NSArray * nsArray = [TextureHelper getTexturesWithSpriteSheetNamed:@"hamster" withinNode:nil sourceRect:CGRectMake(0, 0, 192, 200) andRowNumberOfSprites:2 andColNumberOfSprites:7
                                 //            sequence:[NSArray arrayWithObjects:@"10",@"11",@"12",@"11",@"10", nil]];
                                                                      sequence:@[@3,@4,@5,@4,@3,@2]];
            
            SKAction * monsterAnimation = [SKAction animateWithTextures:nsArray timePerFrame:0.1];
            
            SKAction * actionMoveDone = [SKAction removeFromParent];
            
            //        [self.player runAction:[SKAction sequence: @[monsterAnimation, actionMoveDone]]];
            
            [player runAction:monsterAnimation];
            
        }else if(offx <-8){
            player.xScale = 1;
            
//            player.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:player.size.width/2];
//            player.physicsBody.dynamic = YES;
//            player.physicsBody.categoryBitMask = hamsterCategory;
//            player.physicsBody.contactTestBitMask = monsterCategory|toolCategory;
//            player.physicsBody.collisionBitMask = 0;
//            player.physicsBody.usesPreciseCollisionDetection = YES;
            
            TextureHelper *textureHelper = [TextureHelper alloc];
            
            NSArray * nsArray = [TextureHelper getTexturesWithSpriteSheetNamed:@"hamster" withinNode:nil sourceRect:CGRectMake(0, 0, 192, 200) andRowNumberOfSprites:2 andColNumberOfSprites:7
                                 //            sequence:[NSArray arrayWithObjects:@"10",@"11",@"12",@"11",@"10", nil]];
                                                                      sequence:@[@3,@4,@5,@4,@3,@2]];
            
            SKAction * monsterAnimation = [SKAction animateWithTextures:nsArray timePerFrame:0.1];
            
            SKAction * actionMoveDone = [SKAction removeFromParent];
            
            //        [self.player runAction:[SKAction sequence: @[monsterAnimation, actionMoveDone]]];
            
            [player runAction:monsterAnimation];
            
        }
    }
}


-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
    if(!isGameRun)
        return;
    
    /* Called before each frame is rendered */
    // 获取时间增量
    // 如果我们运行的每秒帧数低于60，我们依然希望一切和每秒60帧移动的位移相同
    CFTimeInterval timeSinceLast = currentTime - self.lastUpdateTimeInterval;
    self.lastUpdateTimeInterval = currentTime;
    if (timeSinceLast > 1) { // 如果上次更新后得时间增量大于1秒
        timeSinceLast = 1.0 / 60.0;
        self.lastUpdateTimeInterval = currentTime;
    }
    
    [self updateWithTimeSinceLastUpdate:timeSinceLast];
}

- (void)updateWithTimeSinceLastUpdate:(CFTimeInterval)timeSinceLast {
    self.lastSpawnTimeInterval += timeSinceLast;
    
    [self processContactsForUpdate];
    
    if (self.lastSpawnTimeInterval > 0.5) {
        self.lastSpawnTimeInterval = 0;
        
        ccount++;
        
        if(ccount==2)    {
            
            
            int continueAttackCounter = 0;
            
            int r = arc4random_uniform(40);
            
            
            [self randomNewCoin];
            
            ccount = 0;
        }
        
    }else if(self.lastSpawnTimeInterval > 0.3){
        
    }
    
    
}

@end
