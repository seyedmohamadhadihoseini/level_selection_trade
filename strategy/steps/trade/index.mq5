int TradeTwoPositions(int index, double risk_percent)
{
    Level level = AllLevels.arr[index];
    double riskMoney = one_percent_risk_money * risk_percent;
    double sl = 0;
    double tp1 = 0;
    double tp2 = 0;
    ulong ticket1;
    ulong ticket2;
    if (level.isForBuy)
    {
        double price = myAsk();
        int slIndex = AllLevels.LevelNextIndex(index, -2);
        sl = AllLevels.arr[slIndex].price - 50 * _Point;
        tp1 = price + tp1_factor * (price - sl);
        tp2 = price + tp2_PIP*10 * _Point;
        ticket1 = BuyMarketWithRiskMoney(riskMoney, sl, tp1);
        ticket2 = BuyMarketWithRiskMoney(riskMoney, sl, tp2);
    }
    else
    {
        double price = myBid();
        int slIndex = AllLevels.LevelNextIndex(index, 2);
        sl = AllLevels.arr[slIndex].price + 50 * _Point;
        tp1 = price - tp1_factor * (sl - price);
        tp2 = price - tp2_PIP *10 * _Point;
        ticket1 = SellMarketWithRiskMoney(riskMoney, sl, tp1);
        ticket2 = SellMarketWithRiskMoney(riskMoney, sl, tp2);
    }
    return AllPositions.AssignNewPosition(ticket1, "start", ticket2, "start");
}
