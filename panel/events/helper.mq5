void UpdateButtonGroup(string name, string &names[], int length,color beforeColor=clrBlack,color afterColor=clrOrange)
{
    for (int i = 0; i < length; ++i)
    {
        if (names[i] == name)
        {
            ObjectSetInteger(0, names[i], OBJPROP_BGCOLOR, afterColor);
        }
        else
        {
            ObjectSetInteger(0, names[i], OBJPROP_BGCOLOR, beforeColor);
        }
    }
}