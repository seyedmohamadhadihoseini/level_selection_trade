int start_hour = 7;
int start_min = 30;
int end_hour = 21;
int end_min = 30;
int sleep_start_hour = 18;
int sleep_start_min = 30;
int sleep_end_hour = 19;
int sleep_end_min = 30;
bool IsSleepTimeEnable = true;
bool IsInTradeTime()
{
    return IsInTimeRange(start_hour,start_min,end_hour,end_min) ;
}
bool IsInSleepTime(){

    return IsSleepTimeEnable && IsInTimeRange(sleep_start_hour,sleep_start_min,sleep_end_hour,sleep_end_min);
}
bool IsInTimeRange(int first_hour,int first_min,int second_hour,int second_min){
    MqlDateTime ct;
    TimeCurrent(ct);
    bool result = (ct.hour > first_hour && ct.hour < second_hour);
    if (ct.hour == first_hour && ct.min >= first_min)
    {
        result = true;
    }
    if (ct.hour == second_hour && ct.min <= second_min)
    {
        result = true;
    }
    
    return result;
}