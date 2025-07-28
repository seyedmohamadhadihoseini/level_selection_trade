#include "./helper.mq5";
#include "./clickinputlevel.mq5";
#include "states.mq5";
#include  "time.mq5";
string levelsName[] = {"level_buy", "level_sell", "level_lastbuy", "level_lastsell"};
string btnsName[] = {"btn_start", "btn_stop"};

void OnChartEventPanel(const int id,
                       const long &lparam,
                       const double &dparam,
                       const string &sparam)
{

    if (id == CHARTEVENT_OBJECT_CLICK)
    {

        ChangeButtonStates(sparam, false);
        if (sparam == "minimize")
        {
            minimizeHandler();
        }
        else if (StringFind(sparam, "level_", 0) == 0 && TradeState == "stop")
        {
            if(level_type == sparam && doubleClickTrigger){
                UpdateButtonGroup(sparam, levelsName, 4,clrBlack,clrGray);
                doubleClickTrigger = !doubleClickTrigger;
            }else{
                level_type = sparam;
                UpdateButtonGroup(sparam, levelsName, 4);
                doubleClickTrigger = true;
            }
            mainForm.Update();
        }
        else if (sparam == "btn_delete_level")
        {
            DeleteLevelHandler();
        }
        else if (StringFind(sparam, "btn_", 0) == 0)
        {

            StartStopHandler(sparam);
        }
        else if (sparam == "restart_btn")
        {
            ResetHandler();
        }else if(StringFind(sparam, "lv_", 0) == 0 && isDeleteButtonEnable){
            AllLevels.Remove(sparam);
            mainForm.Update();
        }else if(sparam == "sleeping_time_btn"){
            SleepingHandler();
        }
    }
    else if (id == CHARTEVENT_CLICK)
    {
        if (TradeState == "stop" && doubleClickTrigger)
        {
            ClickInputLevelHandler(lparam, dparam);
        }
    }else if(id == CHARTEVENT_OBJECT_ENDEDIT){
        if(StringFind(sparam, "time_", 0) == 0){
            UpdateTimeHandler(sparam);
        }
    }
    mainForm.Update();
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
    if(!doubleClickTrigger){
        UpdateButtonGroup(level_type, levelsName, 4,clrBlack,clrGray);
    }else{
        UpdateButtonGroup(level_type, levelsName, 4);
    }
    UpdateFormInputsTimes();
    mainForm.Update();
}
void ResetHandler()
{
    AllLevels.RemoveAll();
}
void DeleteLevelHandler()
{
    isDeleteButtonEnable = !isDeleteButtonEnable;
    ObjectSetInteger(0, "btn_delete_level", OBJPROP_BGCOLOR, isDeleteButtonEnable ? clrRed : clrGray);
    mainForm.Update();
}
void SleepingHandler(){
    IsSleepTimeEnable = !IsSleepTimeEnable;
    
    ObjectSetInteger(0, "sleeping_time_btn", OBJPROP_BGCOLOR, IsSleepTimeEnable ? clrOrange : clrGray);
    mainForm.ReDraw();
}