//+------------------------------------------------------------------+
//|                                                         test.mq5 |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Ltd."
#property link "https://www.mql5.com"
#property version "1.00"
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
{
  //---
  

  
  //---
  return (INIT_SUCCEEDED);
}
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
  //---
  
  Print("in on deinit");
}
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+

double myBid()
{
  MqlTick Latest_Price;
  SymbolInfoTick(Symbol(), Latest_Price);

  return Latest_Price.bid;
}
long myTime(int shift)
{
  return SymbolInfoInteger(_Symbol, SYMBOL_TIME_MSC);
  return iTime(_Symbol, PERIOD_CURRENT, shift);
}
void OnTick()
{
  //---
  
}
//+------------------------------------------------------------------+
