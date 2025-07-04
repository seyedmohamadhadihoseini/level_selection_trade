double myAsk()
{
    MqlTick Latest_Price;
    SymbolInfoTick(Symbol(), Latest_Price);

    return Latest_Price.ask;
}
double myBid()
{
    MqlTick Latest_Price;
    SymbolInfoTick(Symbol(), Latest_Price);

    return Latest_Price.bid;
}
datetime myTime(int shift)
{
    return iTime(_Symbol, PERIOD_CURRENT, shift);
}