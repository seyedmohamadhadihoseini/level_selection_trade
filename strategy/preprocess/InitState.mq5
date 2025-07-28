void DetermineInitState(string &StrategyState)
{
    PRINT(StrategyState);
    
    if (AllPositions.DataLength("running") == 1)
    {
        int index = AllPositions.GetFirstPositionIndex("running");
        Position position = AllPositions.arr[index];
        
        if (position.riskPercent == order_lowerrisk)
        {
            StrategyState = "start1";
            isSecondPositionHasMoreRisk = true;
        }
    }
    if (StrategyState == "end")
    {
        StrategyState = "free";
    }
    else if(StrategyState == "start1" || StrategyState == "start2"){
        bool isForBuyLevel = AllPositions.arr[ActivePositions.Position1Index].isForBuy;
        double price = myBid();
        if(isForBuyLevel){
            price = myAsk();
        }
        NextLevelIndex= AllLevels.FindNearestLevel(isForBuyLevel,price);
        price = AllLevels.arr[NextLevelIndex].price;
        PRINT(price);
    }

}