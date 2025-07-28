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
double myHigh(int shift){

    return iHigh(_Symbol, PERIOD_CURRENT, shift);
}
double myLow(int shift){

    return iLow(_Symbol, PERIOD_CURRENT, shift);
}
datetime myTime(int shift)
{
    return iTime(_Symbol, PERIOD_CURRENT, shift);
}
int myBarShift(datetime time){
    
    return iBarShift(_Symbol,PERIOD_CURRENT, time, false);
}