void Start1Step(string &StrategyState){
    Position currentPos = AllPositions.arr[CurrentPositionIndex];
    Level nextLevel = AllLevels.arr[NextLevelIndex];
    

    if(nextLevel.isForTrade && nextLevel.IsTouched()){
        SecondPositionIndex =  TradeTwoPositions(NextLevelIndex,order_lowerrisk);
        StrategyState = "start2";
        AllLevels.Remove(nextLevel.name);
    }else if(currentPos.state1 == "riskfree"){
        StrategyState = "free";
    }
}
// check for risk free or another level