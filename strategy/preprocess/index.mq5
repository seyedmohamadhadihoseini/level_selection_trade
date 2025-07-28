#include "./time.mq5";
#include "InitState.mq5";
bool PreProcessReadyToNext(string &StrategyState)
{
    static int timeState = 0;
    if (!IsInTradeTime())
    {

        if (timeState == 1)
        {
            AllLevels.RemoveAll();
            timeState = 0;
        }
        if (TradeState == "start")
        {
            for (int i = 0; i < AllLevels.length; i++)
            {
                if (!(AllLevels.arr[i].isFreeForArr))
                {
                    if (AllLevels.arr[i].IsTouched())
                    {
                        AllLevels.arr[i].Remove();
                    }
                }
            }
        }
        
        one_percent_risk_money = AccountInfoDouble(ACCOUNT_BALANCE) * 0.01;
        return false;
    }else if(IsInSleepTime()){
        return false;
    }
    else
    {
        if (timeState == 0)
        {
            DetermineInitState(StrategyState);
            PRINT(StrategyState);
        }
        timeState = 1;
        if (StrategyState == "end")
        {
            // AllLevels.RemoveAll();
            return false;
        }
        return true;
    }
}
