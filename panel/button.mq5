bool ButtonCreate(const long chart_ID = 0,                           // chart's ID
                  const string name = "Button",                      // button name
                  const int sub_window = 0,                          // subwindow index
                  const long x = 0,                                   // X coordinate
                  const long y = 0,                                   // Y coordinate
                  const long width = 50,                              // button width
                  const long height = 18,                             // button height
                  const ENUM_BASE_CORNER corner = CORNER_LEFT_UPPER, // chart corner for anchoring
                  const string text = "Button",                      // text
                  const string font = "Arial",                       // font
                  const long font_size = 10,                          // font size
                  const color clr = clrBlack,                        // text color
                  const color back_clr = C'236,233,216',            // background color
                  const color border_clr = clrNONE,                  // border color
                  const bool state = false,                          // pressed/released
                  const bool back = false,                           // in the background
                  const bool selection = false,                      // highlight to move
                  const bool hidden = true,                          // hidden in the object list
                  const long z_order = 0)                            // priority for mouse click
{
    //--- reset the error value
    ResetLastError();
    //--- create the button
    if (!ObjectCreate(chart_ID, name, OBJ_BUTTON, sub_window, 0, 0))
    {
        Print(__FUNCTION__,
              ": failed to create the button! Error code = ", GetLastError());
        return (false);
    }
    //--- set button coordinates
    ObjectSetInteger(chart_ID, name, OBJPROP_XDISTANCE, x);
    ObjectSetInteger(chart_ID, name, OBJPROP_YDISTANCE, y);
    //--- set button size
    ObjectSetInteger(chart_ID, name, OBJPROP_XSIZE, width);
    ObjectSetInteger(chart_ID, name, OBJPROP_YSIZE, height);
    //--- set the chart's corner, relative to which point coordinates are defined
    ObjectSetInteger(chart_ID, name, OBJPROP_CORNER, corner);
    //--- set the text
    ObjectSetString(chart_ID, name, OBJPROP_TEXT, text);
    //--- set text font
    ObjectSetString(chart_ID, name, OBJPROP_FONT, font);
    //--- set font size
    ObjectSetInteger(chart_ID, name, OBJPROP_FONTSIZE, font_size);
    //--- set text color
    ObjectSetInteger(chart_ID, name, OBJPROP_COLOR, clr);
    //--- set background color
    ObjectSetInteger(chart_ID, name, OBJPROP_BGCOLOR, back_clr);
    //--- set border color
    ObjectSetInteger(chart_ID, name, OBJPROP_BORDER_COLOR, border_clr);
    //--- display in the foreground (false) or background (true)
    ObjectSetInteger(chart_ID, name, OBJPROP_BACK, back);
    //--- set button state
    ObjectSetInteger(chart_ID, name, OBJPROP_STATE, state);
    //--- enable (true) or disable (false) the mode of moving the button by mouse
    ObjectSetInteger(chart_ID, name, OBJPROP_SELECTABLE, selection);
    ObjectSetInteger(chart_ID, name, OBJPROP_SELECTED, selection);
    //--- hide (true) or display (false) graphical object name in the object list
    ObjectSetInteger(chart_ID, name, OBJPROP_HIDDEN, hidden);
    //--- set the priority for receiving the event of a mouse click in the chart
    ObjectSetInteger(chart_ID, name, OBJPROP_ZORDER, z_order);
    //--- successful execution
    return (true);
}