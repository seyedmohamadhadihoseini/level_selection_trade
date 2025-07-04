
#include "./preprocess/index.mq5";
#include "../trade/index.mq5";
#include "./steps/index.mq5";
#include "./track/index.mq5";
input double tp1_factor = 2;
input double tp1_factor_for_notification = 1.7;
input double tp2_PIP = 20;
Positions AllPositions;
double one_percent_risk_money = 0;
int CurrentPositionIndex = -1;
int SecondPositionIndex = -1;
void RunStrategy()
{
    static string StrategyState = "free";
    TrackMyOrders(StrategyState);
    
    if (!PreProcessReadyToNext(StrategyState))
    {     
        return;
    }

    if(StrategyState == "free"){
        FreeStep(StrategyState);
    }else if(StrategyState == "start1"){
        Start1Step(StrategyState);
    }else if(StrategyState == "start2"){
        Start2Step(StrategyState);
    }else if(StrategyState == "end"){
        return;
    }
    // if state="free" then find level that touched
    // else if state="start1" then check if risk free or not , if  risk free then state="free" else check for another level that be tocuhed
    // if another level gonna touched then state="start2" , then check if risk free then state="start1" else if its gonna loss then state="end"
   
}
