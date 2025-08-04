#include <Trade\PositionInfo.mqh>
CPositionInfo cPositionInfo;

class Position
{
private:
public:
    ulong ticket1;
    ulong ticket2;
    string state1;
    string state2;
    double tp1;
    double tp2;
    double sl1;
    double sl2;
    ENUM_POSITION_TYPE type;
    bool isFreeForArr;
    bool isForBuy;
    double riskPercent;
    double openPrice;
    Position()
    {
        isFreeForArr = true;
        sl1 = 0;
        tp1 = 0;
        sl2 = 0;
        tp2 = 0;
    }
    void Init(ulong _ticket1, string _state1, ulong _ticket2, string initialState2);
    void Remove();
    bool IsTpDone(int index);
    bool IsSlDone(int index);
    bool IsTpReached(int index);
    bool IsRiskFreeDone(int index);
    double GetProfit(int index);
    string GetLastestState();
    bool DoRiskFree(int index);
    bool CanRiskFreeDone(int index);
    bool IsOpen(int index);
    bool CloseManually(int index);
    bool IsAlertLevelDone(int index, double factor);
};

void Position::Init(ulong _ticket1, string initialState1, ulong _ticket2, string initialState2)
{
    ticket1 = _ticket1;
    ticket2 = _ticket2;
    state1 = initialState1;
    state2 = initialState2;

    if (PositionSelectByTicket(ticket1))
    {
        sl1 = cPositionInfo.StopLoss();
        tp1 = cPositionInfo.TakeProfit();
        type = cPositionInfo.PositionType();
    }
    if (PositionSelectByTicket(ticket2))
    {
        sl2 = cPositionInfo.StopLoss();
        tp2 = cPositionInfo.TakeProfit();
    }
    if (type == POSITION_TYPE_BUY)
    {
        openPrice = myAsk();
        isForBuy = true;
    }
    else
    {
        isForBuy = false;
        openPrice = myBid();
    }
}
void Position::Remove()
{
    isFreeForArr = true;
}
bool Position::IsTpDone(int index)
{
    ulong ticket = ticket1;
    if (index == 2)
    {
        ticket = ticket2;
    }
    return ((!PositionSelectByTicket(ticket)) && (FindProfitOfClosedPosition(ticket) > 0));
}
bool Position::IsTpReached(int index)
{
    double tp = tp1;
    if (index == 2)
    {
        tp = tp2;
    }
    return isForBuy ? myAsk() >= tp : myBid() <= tp;
}
bool Position::IsSlDone(int index)
{
    ulong ticket = ticket1;
    if (index == 2)
    {
        ticket = ticket2;
    }

    return ((!PositionSelectByTicket(ticket)) && (FindProfitOfClosedPosition(ticket) < 0));
}
bool Position::CanRiskFreeDone(int index)
{
    bool result = false;
    ulong ticket = ticket1;
    if (index == 2)
    {
        ticket = ticket2;
    }
    int factor = isForBuy ? 1 : -1;
    double offsetPrice = factor * riskFreeOffsetPip * 10 * _Point;
    double riskFreePrice = openPrice + offsetPrice;

    double price = isForBuy ? myBid() : myAsk();
    if (isForBuy)
    {
        if (price >= riskFreePrice)
            result = true;
    }
    else
    {
        if (price <= riskFreePrice)
        {
            result = true;
        }
    }
    return result;
}
bool Position::IsRiskFreeDone(int index)
{
    ulong ticket = ticket1;
    if (index == 2)
    {
        ticket = ticket2;
    }
    bool result = false;
    if (PositionSelectByTicket(ticket))
    {
        double sl = PositionGetDouble(POSITION_SL);
        if (type == POSITION_TYPE_BUY)
        {
            if (sl >= openPrice)
            {
                result = true;
            }
        }
        else
        {
            if (sl <= openPrice)
            {
                result = true;
            }
        }
    }

    return result;
}
bool Position::IsAlertLevelDone(int index, double factor)
{
    double sl = sl1;
    if (index == 2)
    {
        sl = sl2;
    }

    double price = 0;
    double alertLevel = 0;
    if (type == POSITION_TYPE_BUY)
    {
        price = myBid();
        alertLevel = openPrice + factor * (openPrice - sl);
        if (price >= alertLevel)
        {
            return true;
        }
    }
    else
    {
        price = myAsk();
        alertLevel = openPrice - factor * (sl - openPrice);
        if (price <= alertLevel)
        {
            return true;
        }
    }
    return false;
}
double Position::GetProfit(int index)
{
    ulong ticket = ticket1;
    if (index == 2)
    {
        ticket = ticket2;
    }

    double profit = FindProfitOfPosition(ticket);
    return profit;
}
bool Position::IsOpen(int index)
{
    ulong ticket = ticket1;
    if (index == 2)
    {
        ticket = ticket2;
    }
    return PositionSelectByTicket(ticket);
}
string Position::GetLastestState()
{
    string state = "";
    if (IsTpDone(2))
    {
        if (PositionSelectByTicket(ticket1))
        {
            state = "riskfree";
        }
        else
        {
            state = "end";
        }
    }
    else if (IsSlDone(1))
    {
        state = "end";
    }
    else
    {
        if (PositionSelectByTicket(ticket2))
        {
            state = "running";
        }
    }

    return state;
}
bool Position::DoRiskFree(int index)
{
    ulong ticket = ticket1;
    double tp = tp1;
    if (index == 2)
    {
        ticket = ticket2;
        tp = tp2;
    }
    int factor = type == POSITION_TYPE_BUY ? 1 : -1;
    bool result = ModifyPositionMarket(ticket, openPrice + factor * riskFreeOffsetPip * 10 * _Point, tp);
    if (!result)
    {
        Print("error in risk free with offset");
        result = ModifyPositionMarket(ticket, openPrice, tp);
        if (result)
        {
            Print("but risk free done without it");
        }
    }

    return result;
}
bool Position::CloseManually(int index)
{
    ulong ticket = ticket1;
    if (index == 2)
    {
        ticket = ticket2;
    }
    return ClosePosition(ticket);
}