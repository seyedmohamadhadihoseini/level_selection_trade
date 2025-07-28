void RemoveTouchedLevels(int shiftCandle)
{
    for (int shift = shiftCandle; shift >= 0; shift--)
    {
        for (int i = 0; i < AllLevels.length; i++)
        {
            double high = myHigh(shift);
            double low = myLow(shift);

            Level level = AllLevels.arr[i];
            if (level.isFreeForArr)
            {
                continue;
            }
            if (level.IsTouched(high) || level.IsTouched(low))
            {
                level.Remove();
            }
        }
    }
}