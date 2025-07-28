
void FreeStep(string &StrategyState)
{
    int index = AllLevels.LevelTouchedIndex();
    isSecondPositionHasMoreRisk = false;
    if (index != -1)
    {
        Level level = AllLevels.arr[index];
        if (level.isForTrade)
        {
            
            // CurrentPositionIndex = TradeTwoPositions(index, order_higherrisk);
            ActivePositions.Position1Index =  TradeTwoPositions(index, order_higherrisk); 
            ActivePositions.Position2Index =  -1; 
            StrategyState = "start1";
            NextLevelIndex = AllLevels.LevelNextIndex(index, level.isForBuy ? -1 : 1);
        }
        AllLevels.Remove(level.name);
    }
}