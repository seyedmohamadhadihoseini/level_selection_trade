#include <Trade\Trade.mqh>

CTrade cTrade;
ulong BuyMarketWithRiskMoney(double risk_money, double sl, double tp)
{
    double sl_point = (myAsk() - sl) / _Point;
    double volume = CalculateVolume(sl_point, risk_money);
    return BuyMarket(volume, sl, tp);
}
ulong SellMarketWithRiskMoney(double risk_money, double sl, double tp)
{
    double sl_point = (sl - myBid()) / _Point;
    double volume = CalculateVolume(sl_point, risk_money);
    PRINT(risk_money);
    return SellMarket(volume, sl, tp);
}
ulong BuyMarket(double volume, double sl, double tp)
{
    double price = myAsk();
    bool result = cTrade.Buy(volume, NULL, price, sl, tp, "opened by developerseyed@gmail.com");
    return result ? cTrade.ResultOrder() : 0;
}
ulong SellMarket(double volume, double sl, double tp)
{
    double price = myBid();
    bool result = cTrade.Sell(volume, NULL, price, sl, tp, "opened by developerseyed@gmail.com");
    return result ? cTrade.ResultOrder() : 0;
}
bool ModifyPositionMarket(ulong ticket, double sl, double tp)
{
    return cTrade.PositionModify(ticket, sl, tp);
}
double CalculateVolume(double sl_points, double riskMoney)
{
    double pointCost = GetPointValue(1);
    double vol = riskMoney / (sl_points * pointCost);

    return NormalizeDouble(vol, 2);
}
double GetPointValue(double for_lot)
{
    // اندازه قرارداد (تعداد اونس در یک لات)
    double contractSize = SymbolInfoDouble(_Symbol, SYMBOL_TRADE_CONTRACT_SIZE);
    // اندازه یک پوینت
    double point = _Point;
    // ارز سود (معمولاً USD برای XAUUSD)
    string profitCurrency = SymbolInfoString(_Symbol, SYMBOL_CURRENCY_PROFIT);
    // ارزش هر پوینت برای یک لات = اندازه قرارداد * اندازه پوینت
    double pointValueForOneLot = contractSize * point;
    // محاسبه برای لات ورودی
    double result = pointValueForOneLot * for_lot;
    return result;
}