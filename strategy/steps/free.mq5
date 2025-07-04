
void FreeStep(string &StrategyState)
{
    int index = AllLevels.LevelTouchedIndex();
    if (index != -1)
    {
        Level level = AllLevels.arr[index];
        if (level.isForTrade)
        {
            CurrentPositionIndex = TradeTwoPositions(index, order_higherrisk);
            StrategyState = "start1";
        }
        NextLevelIndex = AllLevels.LevelNextIndex(index,level.isForBuy ? -1 : 1);
        AllLevels.Remove(level.name);
    }
}