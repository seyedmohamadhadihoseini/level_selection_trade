void Start1Step(string &StrategyState)
{
    Position currentPos = AllPositions.arr[ActivePositions.Position1Index];
    Level nextLevel = AllLevels.arr[NextLevelIndex];
    if (nextLevel.isForTrade && nextLevel.IsTouched())
    {
        double risk = order_lowerrisk;
        if (isSecondPositionHasMoreRisk)
        {
            risk = order_higherrisk;
        }
        // SecondPositionIndex = TradeTwoPositions(NextLevelIndex, risk);
        ActivePositions.Position2Index = TradeTwoPositions(NextLevelIndex, risk);
        NextLevelIndex = AllLevels.LevelNextIndex(NextLevelIndex, nextLevel.isForBuy ? -1 : 1);
        StrategyState = "start2";
        AllLevels.Remove(nextLevel.name);
    }
    else if (currentPos.state1 == "riskfree")
    {
        StrategyState = "free";
    }
}
// check for risk free or another level