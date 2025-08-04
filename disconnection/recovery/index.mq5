#include "RemoveTouchedLevels.mq5";
#include "manage.mq5";
void RecoverLevelsAndPositionsAfterDisconnection(datetime disconnectionTime)
{
    int shiftCandle = myBarShift(disconnectionTime);
    RemoveTouchedLevels(shiftCandle);
}
void RiskFreeLostPositionInDisconnection()
{
    int runningPositionCount = ActivePositions.Length(AllPositions);
    if (runningPositionCount == 1)
    {
        ManageRecoverOnePosition();
    }
    else if (runningPositionCount == 2)
    {
        ManageRecoverTwoPosition();
    }
}