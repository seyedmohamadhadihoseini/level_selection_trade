void Start2Step(string &StrategyState)
{
    Position currentPos = AllPositions.arr[SecondPositionIndex];
    if (currentPos.state1 == "riskfree")
    {
        StrategyState = "start1";   
    }
}