#property copyright "Copyright 2025, seyedmohadihoseini@gmail.com"
#property link "https://hadi.s4r4.com/"
#property version "1.00"
#define PRINT(A) Print(#A + " = " + (string)A)
#include "graphic/index.mq5"
#include "services/index.mq5";
#include "panel/index.mq5";
#include "entity/index.mq5";
#include "strategy/index.mq5";
#include "disconnection/index.mq5";
#include "test/index.mq5";

input double telorance_pip = 0.5;
input double order_higherrisk = 1.5;
input double order_lowerrisk = 0.5;
input double riskFreeOffsetPip = 3;
input double levels_minimum_distance_pip = 22;

string TradeState = "start";

TradeForm mainForm;
Levels AllLevels;
int OnInit()
{
    one_percent_risk_money = AccountInfoDouble(ACCOUNT_BALANCE) * 0.01;
    mainForm.show();
    EventSetMillisecondTimer(400);
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
    TestAppInit();
    RunStrategy();
}
void OnDeinit(const int reason)
{
    if (reason == REASON_CHARTCHANGE)
    {
        return;
    }
    EventKillTimer();
    AllLevels.RemoveAll();

    mainForm.DeleteAllObjects();
}
void OnTimer()
{
    DisconnectionHandler();
}