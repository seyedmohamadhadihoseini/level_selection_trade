#include "./helper.mq5";
#include "./clickinputlevel.mq5"
string levelsName[] = {"level_buy", "level_sell", "level_lastbuy", "level_lastsell"};
string btnsName[] = {"btn_start", "btn_stop"};
static string level_type;
static bool isPanelClosed = false;
void OnChartEventPanel(const int id,
                       const long &lparam,
                       const double &dparam,
                       const string &sparam)
{

    if (id == CHARTEVENT_OBJECT_CLICK)
    {

        if (sparam == "minimize")
        {
            minimizeHandler();
        }
        else if (StringFind(sparam, "level_", 0) == 0 && TradeState == "stop")
        {
            level_type = sparam;
            UpdateButtonGroup(sparam, levelsName, 4);
            mainForm.Update();
        }
        else if (StringFind(sparam, "btn_", 0) == 0)
        {
            StartStopHandler(sparam);
        }
        else if (sparam == "restart_btn")
        {
            ResetHandler();
        }
    }
    else if (id == CHARTEVENT_CLICK)
    {
        if (TradeState == "stop")
        {
            ClickInputLevelHandler(lparam, dparam);
        }
    }
}

void StartStopHandler(string sparam)
{
    UpdateButtonGroup(sparam, btnsName, 2, clrGray, clrOrange);
    if (sparam == "btn_start")
    {
        TradeState = "start";
        AllLevels.Sort();
        UpdateButtonGroup(TradeState, levelsName, 4);
    }
    else
    {
        TradeState = "stop";
    }
    mainForm.Update();
}
void minimizeHandler()
{
    if (isPanelClosed)
    {
        mainForm.show();
    }
    else
    {
        mainForm.DeleteAllObjects();
    }
    isPanelClosed = !isPanelClosed;
}
void UpdateORFixFormButtonsColor()
{

    UpdateButtonGroup("btn_" + TradeState, btnsName, 2, clrGray, clrOrange);
    UpdateButtonGroup(level_type, levelsName, 4);
    mainForm.Update();
}
void ResetHandler()
{
    AllLevels.RemoveAll();
}