void TrackMyOrders(string &StrategyState)
{
    for (int i = 0; i < AllPositions.length; i++)
    {
        Position pair = AllPositions.arr[i];
        if (pair.isFreeForArr)
        {
            continue;
        }
        if (pair.state2 == "start")
        {
            if (pair.IsTpDone(2))
            {
                ModifyPositionMarket(pair.ticket1, pair.openPrice, pair.tp1);
                AllPositions.arr[i].state2 = "end";
                AllPositions.arr[i].state1 = "riskfree";
            }
            else if (pair.IsSlDone(2))
            {
                StrategyState = "end";
                AllPositions.Remove(pair.ticket1);
            }
        }
        else
        {
            if (pair.state1 == "riskfree")
            {
                if (pair.IsAlertLevelDone(1, tp1_factor_for_notification))
                {
                    ModifyPositionMarket(pair.ticket1, pair.tp2, pair.tp1);
                    SendNotification("price reach to "+(string) tp1_factor_for_notification+(string) " r/r");
                    AllPositions.arr[i].state1 = "trail";
                }
            }
            else if (pair.state1 == "trail")
            {
                if (!PositionSelectByTicket(pair.ticket1))
                {
                    AllPositions.arr[i].state1 = "end";
                    AllPositions.Remove(pair.ticket1);
                }
            }
        }
    }
}