double FindProfitOfClosedPosition(long position_ticket)
{
    double total_profit = 0;
    if (HistorySelectByPosition(position_ticket))
    {
        long deals_count = HistoryDealsTotal();
        for (int i = 0; i < deals_count; i++)
        {
            ulong deal_ticket = HistoryDealGetTicket(i);
            if (deal_ticket > 0)
            {
                if (HistoryDealGetInteger(deal_ticket, DEAL_POSITION_ID) == position_ticket)
                {
                    double profit = HistoryDealGetDouble(deal_ticket, DEAL_PROFIT);
                    total_profit += profit;
                    double commision = HistoryDealGetDouble(deal_ticket, DEAL_COMMISSION);
                    double swap = HistoryDealGetDouble(deal_ticket, DEAL_SWAP);
                    // total_profit += commision + swap;
                }
            }
        }
    }
    return total_profit;
}
double FindProfitOfPosition(long position_ticket){
    double result ;
    if(PositionSelectByTicket(position_ticket)){
        result =  PositionGetDouble(POSITION_PROFIT);
    }else{
        result = FindProfitOfClosedPosition(position_ticket);
    }
    return result;
}