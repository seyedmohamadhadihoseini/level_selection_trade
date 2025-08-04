void ManageRecoverOnePosition()
{
    int index = ActivePositions.GetBiggerPosition(AllPositions);
    if (index != -1)
    {
        Position position = AllPositions.arr[index];
        bool isTp2Done = position.IsTpDone(2);
        if (isTp2Done)
        {
            // double profit = position.GetProfit(1);CanRiskFreeDone
            if (position.CanRiskFreeDone(1))
            {
                if (!position.DoRiskFree(1))
                {
                    position.CloseManually(1);
                }
            }
        }
    }
}
void ManageRecoverTwoPosition()
{
    int biggerIndex = ActivePositions.GetBiggerPosition(AllPositions);
    int lowerIndex = ActivePositions.GetLowerPosition(AllPositions);

    Position bigPosition = AllPositions.arr[biggerIndex];
    Position lowPosition = AllPositions.arr[lowerIndex];
    bool isLowPositionTp2Done = lowPosition.IsTpDone(2);
    bool isBigPositionTp2Done = bigPosition.IsTpDone(2);
    if (isLowPositionTp2Done)
    {
        if (lowPosition.CanRiskFreeDone(1))
        {
            if (!lowPosition.DoRiskFree(1))
            {
                lowPosition.CloseManually(1);
            }
        }
    }
    if (isBigPositionTp2Done)
    {
        if (bigPosition.CanRiskFreeDone(1))
        {
            if (bigPosition.DoRiskFree(1))
            {
                bigPosition.CloseManually(1);
            }
        }
    }
}