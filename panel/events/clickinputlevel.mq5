void ClickInputLevelHandler(long lparam, double dparam)
{
    if (CheckIsInFormRange(lparam, dparam) || isPanelClosed)
    {
        return;
    }
    datetime time;
    double price;
    int subwinow;
    ChartXYToTimePrice(0, (int)lparam, (int)dparam, subwinow, time, price);

    AllLevels.AssignNewLevel(price, level_type);
    mainForm.Update();
    mainForm.ReDraw();
    Sleep(100);
}
bool CheckIsInFormRange(long lparam, double dparam)
{
    return mainForm.IsInFormRange(lparam, dparam);
}