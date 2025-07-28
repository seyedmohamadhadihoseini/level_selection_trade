void UpdateTimeHandler(string name)
{
    int time_value = (int)ObjectGetString(0, name, OBJPROP_TEXT);
    if (name == "time_starthour")
    {
        start_hour = time_value;
    }
    else if (name == "time_startmin")
    {
        start_min = time_value;
    }
    else if (name == "time_endhour")
    {
        end_hour = time_value;
    }
    else if (name == "time_endmin")
    {
        end_min = time_value;
    }
    else if (name == "time_sleepstarthour")
    {
        sleep_start_hour = time_value;
    }
    else if (name == "time_sleepstartmin")
    {
        sleep_start_min = time_value;
    }
    else if (name == "time_sleependhour")
    {
        sleep_end_hour = time_value;
    }
    else if (name == "time_sleependmin")
    {
        sleep_end_min = time_value;
    }
}

void UpdateFormInputsTimes(){
    ObjectSetString(0, "time_starthour", OBJPROP_TEXT, (string)start_hour);
    ObjectSetString(0, "time_startmin", OBJPROP_TEXT, (string)start_min);
    ObjectSetString(0, "time_endhour", OBJPROP_TEXT, (string)end_hour);
    ObjectSetString(0, "time_endmin", OBJPROP_TEXT, (string)end_min);
    ObjectSetString(0, "time_sleepstarthour", OBJPROP_TEXT, (string)sleep_start_hour);
    ObjectSetString(0, "time_sleepstartmin", OBJPROP_TEXT, (string)sleep_start_min);
    ObjectSetString(0, "time_sleependhour", OBJPROP_TEXT, (string)sleep_end_hour);
    ObjectSetString(0, "time_sleependmin", OBJPROP_TEXT, (string)sleep_end_min);
}