
void TradeForm::CreateInputTime(string hour_name, string min_name, long xlPosition, long ylPosition,bool isForStartTime= true)
{
    long label_font_size = 8;
    long edit_font_size = 13;
    long labelWidth = 57;    
    long editWidth = pWidth/2 - labelWidth;
    long editHeight = 20;
    long xCursor = 0; 
    LabelCreate(0, hour_name + "label", 0, xlPosition-xCursor, ylPosition, CORNER_RIGHT_UPPER, (isForStartTime?"start":"end")+" hour:", "Arial", label_font_size, clrWhite, 0.0);

    xCursor += labelWidth;
    CreateEditText(hour_name, xlPosition - xCursor, ylPosition, editWidth, editHeight, edit_font_size, CORNER_RIGHT_UPPER);
    xCursor = pWidth/2+5;
    LabelCreate(0, min_name + "label", 0, xlPosition - xCursor, ylPosition, CORNER_RIGHT_UPPER, (isForStartTime?"start":"end")+" min:", "Arial", label_font_size, clrWhite, 0.0);
    labelWidth = 45;
    xCursor += labelWidth;
    CreateEditText(min_name, xlPosition - xCursor, ylPosition, editWidth, editHeight, edit_font_size, CORNER_RIGHT_UPPER);
}