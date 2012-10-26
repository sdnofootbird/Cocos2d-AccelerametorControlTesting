//
//  HelloWorldLayer.h
//  WorldNotEven
//
//  Created by Xuefeng Dai on 26/7/12.
//  Copyright Nest 2012. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
enum PlayerControlType {
    PLAYER_ACCE_TYPE = 1,
    PLAYER_VELO_TYPE = 2,
    PLAYER_POSI_TYPE = 3
};

@interface HelloWorldLayer : CCLayer
{
    /********* TEST *********/
    CCSprite* acce_slider;
    float acce_value;
    float acce_max_value;
    float acce_min_value;
    BOOL acce_on;
    CCSprite* velo_slider;
    float velo_value;
    float velo_max_value;
    float velo_min_value;
    BOOL velo_on;
    CCSprite* posi_slider;
    float posi_value;
    float posi_max_value;
    float posi_min_value;
    BOOL posi_on;
    
    CCMenuItem* controlStyleChangeButton;
    CCMenu* uiMenu;
    CCLabelTTF* label;
    CCLabelTTF* velo_label;
    CCLabelTTF* acce_label;
    CCLabelTTF* posi_label;
    CCLabelTTF* velocityX_label;
    
    CCSprite* player;
    float velocityX;
    float targetVelocityX;
    float targetPositionX;
    enum PlayerControlType pct;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
