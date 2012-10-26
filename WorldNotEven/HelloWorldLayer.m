//
//  HelloWorldLayer.m
//  WorldNotEven
//
//  Created by Xuefeng Dai on 26/7/12.
//  Copyright Hong Kong University 2012. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// HelloWorldLayer implementation
@implementation HelloWorldLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        
        self.isAccelerometerEnabled = YES;
        self.isTouchEnabled = YES;
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
		
		// create and initialize a Label
		label = [CCLabelTTF labelWithString:@"Velocity Control Type" fontName:@"Marker Felt" fontSize:23];
	
		// position the label on the center of the screen
		label.position =  ccp( screenSize.width /2 , screenSize.height - 100 );
		
		// add the label as a child to this Layer
		[self addChild: label];
        
        acce_label = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:10];
        acce_label.position = ccp(10, screenSize.height -10);
        [acce_label setAnchorPoint:ccp(0, 1)];
        [self addChild:acce_label];
        
        velo_label = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:10];
        velo_label.position = ccp(10, screenSize.height - 20);
        [velo_label setAnchorPoint:ccp(0, 1)];
        [self addChild:velo_label];
        
        posi_label = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:10];;
        [posi_label setPosition:ccp(10, screenSize.height - 30)];
        [posi_label setAnchorPoint:ccp(0, 1)];
        [self addChild:posi_label];
        
        velocityX_label = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:10];
        [velocityX_label setPosition:ccp(10, screenSize.height - 40)];
        [velocityX_label setAnchorPoint:ccp(0, 1)];
        [self addChild:velocityX_label];
        
        acce_slider = [CCSprite spriteWithFile:@"Icon-Small.png"];
        [acce_slider setPosition:ccp(screenSize.width/2, 20)];
        [self addChild:acce_slider];
        
        velo_slider = [CCSprite spriteWithFile:@"Icon-Small.png"];
        [velo_slider setPosition:ccp(screenSize.width/2, 80)];
        [self addChild:velo_slider];
        
        posi_slider = [CCSprite spriteWithFile:@"Icon-Small.png"];
        [posi_slider setPosition:ccp(screenSize.width/2, 140)];
        [self addChild:posi_slider];
        
        acce_on = NO;
        velo_on = NO;
        posi_on = NO;
        acce_max_value = 1000;
        acce_min_value = 0;
        velo_max_value = 1500;
        velo_min_value = 500;
        posi_max_value = 800;
        posi_min_value = 0;
        
        controlStyleChangeButton = [CCMenuItemImage itemFromNormalImage:@"Icon-Small.png" selectedImage:@"Icon-Small.png" target:self selector:@selector(changeControlStyle:)];
        [controlStyleChangeButton setAnchorPoint:ccp(1, 1)];
        [controlStyleChangeButton setPosition:ccp(screenSize.width/2, screenSize.height)];
        
        uiMenu = [CCMenu menuWithItems:controlStyleChangeButton, nil];
        uiMenu.position = CGPointZero;
        [self addChild:uiMenu];
        
        player = [CCSprite spriteWithFile:@"Icon.png"];
        [player setPosition:ccp(screenSize.width/2, screenSize.height * 0.7)];
        [self addChild:player];
        
        [self schedule:@selector(tick:)];
        
        // intial value;
        acce_value = 500;
        velo_value = 1000;
        posi_value = 400;
        pct = PLAYER_VELO_TYPE;

	}
	return self;
}

-(void)changeControlStyle:(id)sender{
    switch (pct) {
        case PLAYER_ACCE_TYPE:
            pct = PLAYER_VELO_TYPE;
            [label setString:@"Velocity Control Type"];
            break;
        case PLAYER_VELO_TYPE:
            pct = PLAYER_POSI_TYPE;
            [label setString:@"position Control Type"];
            break;
        case PLAYER_POSI_TYPE:
            pct = PLAYER_ACCE_TYPE;
            [label setString:@"acceleration Control Type"];
            break;
        default:
            break;
    }
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView: [touch view]];
    location.y = 480 - location.y;
    if (location.y < [acce_slider position].y + [acce_slider contentSize].height/2) {
        acce_on = YES;
    }
    else if (location.y < [velo_slider position].y + [velo_slider contentSize].height/2) {
        velo_on = YES;
    }
    else if (location.y < [posi_slider position].y + [posi_slider contentSize].height/2) {
        posi_on = YES;
    }
    
}

-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView: [touch view]];
    if (acce_on) {
        [acce_slider setPosition:ccp(location.x, [acce_slider position].y)];
        acce_value = location.x / 320 * (acce_max_value - acce_min_value) + acce_min_value;
    }
    else if (velo_on) {
        [velo_slider setPosition:ccp(location.x, [velo_slider position].y)];
        velo_value = location.x / 320 * (velo_max_value - velo_min_value) + velo_min_value;
    }
    else if (posi_on) {
        [posi_slider setPosition:ccp(location.x, [posi_slider position].y)];
        posi_value = location.x / 320 * (posi_max_value - posi_min_value) + posi_min_value;
    }
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    acce_on = NO;
    velo_on = NO;
    posi_on = NO;
}

- (void)accelerometer:(UIAccelerometer*)accelerometer didAccelerate:(UIAcceleration*)acceleration
{	
    [self setAccelerometer:acceleration.x];
}

-(void)setAccelerometer:(float) x{
    switch (pct) {
        case PLAYER_ACCE_TYPE:
            if (velocityX < 0) {
                velocityX = velocityX + x * acce_value;
            }
            else{
                velocityX = velocityX + x * acce_value;
            }
            break;
        case PLAYER_VELO_TYPE:
            if (x > 0.64) {
                x = 0.64;
            }
            else if (x < -0.64) {
                x = -0.64;
            }
            targetVelocityX = velo_value * x;
            break;
        case PLAYER_POSI_TYPE:
            if (x > 0.4) {
                x = 0.4;
            }
            else if (x < -0.4) {
                x = -0.4;
            }
            velocityX = velo_value;
            targetPositionX = x * posi_value + [[CCDirector sharedDirector] winSize].width/2;
            break;
        default:
            break;
    }
    CCLOG(@"accelerometer is %.03f",x);
    
}

-(void)setPosition:(CGPoint)position{
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    if (position.x > screenSize.width) {
        position.x = screenSize.width;
    }
    else if (position.x < 0) {
        position.x = 0;
    }
    [player setPosition:ccp(position.x, [player position].y)];
}

-(void)updateVelocity:(ccTime)dt{
    float newVelocity = 0;
    if (velocityX - targetVelocityX > 0) {
        newVelocity = velocityX - acce_value * dt;
        if (newVelocity < targetVelocityX) {
            newVelocity = targetVelocityX;
        }
    }
    else{
        newVelocity = velocityX + acce_value * dt;
        if (newVelocity > targetVelocityX) {
            newVelocity = targetVelocityX;
        }
    }
    velocityX = newVelocity;
}

-(void) updatePosition:(ccTime)dt{
    float newPosition = 0;
    if (targetPositionX > [player position].x) {
        newPosition = [player position].x + velocityX * dt;
    }
    else {
        newPosition = [player position].x - velocityX * dt;
    }
    [self setPosition:ccp(newPosition, [player position].y)];
}

-(void) tick:(ccTime) dt{
    
    switch (pct) {
        case PLAYER_VELO_TYPE:
            [self updateVelocity:dt];
            [self setPosition:ccpAdd(player.position, ccp(velocityX * dt, 0))];
            break;
        case PLAYER_ACCE_TYPE:
            [self setPosition:ccpAdd(player.position, ccp(velocityX * dt, 0))];
            break;
        case PLAYER_POSI_TYPE:
            [self updatePosition:dt];
            break;
        default:
            break;
    }
    [posi_label setString:[NSString stringWithFormat:@"posi: %.02f", posi_value]];
    [velo_label setString:[NSString stringWithFormat:@"velo: %.02f", velo_value]];
    [acce_label setString:[NSString stringWithFormat:@"acce: %.02f", acce_value]];
    [velocityX_label setString:[NSString stringWithFormat:@"velocityX: %.02f", velocityX]];
}



// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
