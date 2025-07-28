void ManageRecoverOnePosition()
{
    int index = ActivePositions.GetBiggerPosition(AllPositions);
    if (index != -1)
    {
        Position position = AllPositions.arr[index];
        bool isTp2Done = position.IsTpDone(2);
        if (isTp2Done)
        {
            double profit1 = position.GetProfit(1);
            if (profit1 > 0)
            {
                position.DoRiskFree(1);
            }
            else
            {
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
    bool isTp2DoneLowPosition = lowPosition.IsTpDone(2);
    if(isTp2DoneLowPosition){
        double profit = lowPosition.GetProfit();
        if(profit > 0){
            lowPosition.DoRiskFree(1);
        }else{
        }
    }else{
        return;
    }
}