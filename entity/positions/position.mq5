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
    bool IsAlertLevelDone(int index,double factor);
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
    }
    else
    {
        openPrice = myBid();
    }
}
void Position::Remove()
{
    isFreeForArr = true;
}
bool Position::IsTpDone(int index)
{
    double tp = tp1;
    if (index == 2)
    {
        tp = tp2;
    }

    if (type == POSITION_TYPE_BUY)
    {
        double price = myBid();
        if (price >= tp)
        {
            return true;
        }
    }
    else
    {
        double price = myAsk();
        if (price <= tp)
        {
            return true;
        }
    }
    return false;
}
bool Position::IsSlDone(int index)
{
    double sl = sl1;
    if (index == 2)
    {
        sl = sl2;
    }
    if (type == POSITION_TYPE_BUY)
    {
        double price = myBid();
        if (price <= sl)
        {
            return true;
        }
    }
    else
    {
        double price = myAsk();
        if (price >= sl)
        {
            return true;
        }
    }
    return false;
}
bool Position::IsAlertLevelDone(int index,double factor)
{
    double sl = sl1;
    if (index == 2)
    {
        sl = sl2;
    }
    
    double price = 0;
    double alertLevel = 0;
    if(type == POSITION_TYPE_BUY){
        price = myBid();
        alertLevel = openPrice + factor*(openPrice-sl);
        if(price >= alertLevel){
            return true;
        }
    }else{
        price = myAsk();
        alertLevel = openPrice - factor * (sl-openPrice);
        if(price <= alertLevel){
            return true;
        }
    }
    return false;
}