#property copyright "Copyright 2025, seyedmohadihoseini@gmail.com"
#property link "https://hadi.s4r4.com/"
#property version "1.00"
#include "./graphic/index.mq5"
#include "./services/index.mq5";
#include "./panel/index.mq5";
#include "./entity/index.mq5";
#include "./strategy/index.mq5";
#include "./test/index.mq5";
input double telorance_pip = 0.5;
input double order_higherrisk = 1.5;
input double order_lowerrisk = 0.5;
string TradeState = "start";

TradeForm mainForm;
Levels AllLevels;
int OnInit()
{
    mainForm.show();
    TestAppInit();
    return 0;
}
void OnChartEvent(const int id, const long &lparam, const double &dparam, const string &sparam)
{
    OnChartEventPanel(id, lparam, dparam, sparam);
}
void OnTick()
{
    if (TradeState == "stop")
    {
        return;
    }
    RunStrategy();
    
}
void OnDeinit(const int reason)
{
   AllLevels.RemoveAll();
   
   mainForm.DeleteAllObjects();
}