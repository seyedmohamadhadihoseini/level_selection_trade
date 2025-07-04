#include "./label.mq5"
#include "./container.mq5"
#include "./edit.mq5"
#include "./button.mq5";
#include "./events/index.mq5";
class TradeForm
{
private:
    long xPosition;
    long yPosition;
    long pWidth;
    long pHeight;
    ENUM_BASE_CORNER corner;
    long font_size;
    long minimizeX;
    long minimizeY;

public:
    TradeForm();
    ~TradeForm();
    void CreateFormContainer();
    void CreateEdit(string name, long xPos, long yPos, long width, long height, long fontSize);
    void CreateTextLabel(string name, long xPos, long yPos, string text);
    void CreateButton(string name, long xPos, long yPos, long width, long heigth, string text, long fontSize, color clr, color back_clr);
    bool IsInFormRange(long xPos, double yPos);
    void ReDraw();
    void Update()
    {
        ChartRedraw(0);
        Sleep(10);
    }
    void show()
    {
        if (ObjectFind(0, "minimize") < 0)
        {
            ButtonCreate(0, "minimize", 0, 40, 40, 35, 35, CORNER_RIGHT_UPPER, "~", "Arial", 18, clrWhite, C'8,21,33', clrNONE, false, false, true);
        }
        minimizeX = ObjectGetInteger(0, "minimize", OBJPROP_XDISTANCE);
        minimizeY = ObjectGetInteger(0, "minimize", OBJPROP_YDISTANCE);
        xPosition = minimizeX + pWidth + 10;
        yPosition = minimizeY;
        CreateFormContainer();
        long y_cursor = yPosition + 10;
        CreateTextLabel("level_type_label", xPosition - 40, y_cursor, "level type");
        y_cursor += 30;
        long buttonWith = pWidth / 2 - 1;
        long buttonHeight = 28;
        CreateButton("level_buy", xPosition - 2, y_cursor, buttonWith, buttonHeight, "buy", 10, clrWhite, clrBlack);
        CreateButton("level_sell", xPosition - buttonWith - 2, y_cursor, buttonWith, buttonHeight, "sell", 10, clrWhite, clrBlack);
        y_cursor += 30;
        CreateButton("level_lastbuy", xPosition - 2, y_cursor, buttonWith, buttonHeight, "lbuy", 10, clrWhite, clrBlack);
        CreateButton("level_lastsell", xPosition - buttonWith - 2, y_cursor, buttonWith, buttonHeight, "lsell", 10, clrWhite, clrBlack);

        y_cursor += 30;
        CreateButton("restart_btn", xPosition - 2, y_cursor, pWidth - 2, 30, "reset", 10, clrBlack, clrRed);
        y_cursor += 40;
        CreateButton("btn_start", xPosition - 2, y_cursor, pWidth - 2, 30, "start", 10, clrBlack, clrGray);
        y_cursor += 33;
        CreateButton("btn_stop", xPosition - 2, y_cursor, pWidth - 2, 30, "stop", 10, clrBlack, clrGray);
        UpdateORFixFormButtonsColor();
        ChartRedraw(0);
        Sleep(10);
    }
    void initializeValue()
    {
        // ObjectSetString(0, "volume", OBJPROP_TEXT, (string)order.volume);
    }
    void DeleteAllObjects()
    {
        ObjectDelete(0, "FormContainer");
        ObjectDelete(0, "level_type_label");
        ObjectDelete(0, "level_buy");
        ObjectDelete(0, "level_sell");
        ObjectDelete(0, "level_lastbuy");
        ObjectDelete(0, "level_lastsell");
        ObjectDelete(0, "close");
        ObjectDelete(0, "btn_start");
        ObjectDelete(0, "btn_stop");
        ObjectDelete(0, "restart_btn");
        ChartRedraw(0);
        Sleep(10);
    }
};

TradeForm::~TradeForm()
{
    DeleteAllObjects();
    ObjectDelete(0, "minimize");
}
TradeForm::TradeForm(/* args */)
{

    pHeight = 205;
    pWidth = 170;
    font_size = 15;

    corner = CORNER_RIGHT_UPPER;
}
void TradeForm::CreateFormContainer()
{
    CreatePanelContainer(corner, xPosition, yPosition, pWidth, pHeight);
}
void TradeForm::CreateEdit(string name, long xPos, long yPos, long width, long height, long fontSize)
{
    CreateEditText(name, xPos, yPos, width, height, fontSize, corner);
}
void TradeForm::CreateTextLabel(string name, long xPos, long yPos, string text)
{
    LabelCreate(0, name, 0, xPos, yPos, corner, text, "Arial", font_size, clrWhite, 0.0);
}
void TradeForm::CreateButton(string name, long xPos, long yPos, long width, long heigth, string text, long fontSize, color clr, color back_clr)
{
    ButtonCreate(0, name, 0, xPos, yPos, width, heigth, corner, text, "Arial", fontSize, clr, back_clr);
}
void TradeForm::ReDraw()
{
    minimizeX = ObjectGetInteger(0, "minimize", OBJPROP_XDISTANCE);
    minimizeY = ObjectGetInteger(0, "minimize", OBJPROP_YDISTANCE);
    ObjectDelete(0, "minimize");
    ButtonCreate(0, "minimize", 0, minimizeX, minimizeY, 35, 35, CORNER_RIGHT_UPPER, "~", "Arial", 18, clrWhite, C'8,21,33', clrNONE, false, false, true);
    if (!isPanelClosed)
    {
        DeleteAllObjects();
        show();
    }
}
bool TradeForm::IsInFormRange(long xPos, double yPos)
{
    long chartWidth = ChartGetInteger(0, CHART_WIDTH_IN_PIXELS, 0);
    long panelX = chartWidth - xPosition;
    long lastX = chartWidth - minimizeX;
    if (xPos >= panelX && xPos <= (lastX + 35))
    {
        if (yPos >= yPosition && yPos <= (yPosition + pHeight))
        {
            return true;
        }
    }
    return false;
}