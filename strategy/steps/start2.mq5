void Start2Step(string &StrategyState)
{
    Position currentPos = AllPositions.arr[ActivePositions.Position2Index];
    if (currentPos.state1 == "riskfree")
    {
        StrategyState = "start1";   
    }
}