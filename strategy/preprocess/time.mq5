input int start_hour = 7;
input int start_min = 30;
input int end_hour = 21;
input int end_min = 30;
bool IsInTradeTime()
{
    MqlDateTime ct;
    TimeCurrent(ct);
    bool result = (ct.hour > start_hour && ct.hour < end_hour);
    if (ct.hour == start_hour && ct.min >= start_min)
    {
        result = true;
    }
    if (ct.hour == end_hour && ct.min <= end_min)
    {
        result = true;
    }
    
    return result;
}
