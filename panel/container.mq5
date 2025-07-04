void CreatePanelContainer(ENUM_BASE_CORNER corner,long xPosition,long yPosition,long width,long height)
{
    ObjectCreate(0, "FormContainer", OBJ_RECTANGLE_LABEL, 0, 0, 0);
    ObjectSetInteger(0, "FormContainer", OBJPROP_XDISTANCE, xPosition);       // X position
    ObjectSetInteger(0, "FormContainer", OBJPROP_YDISTANCE, yPosition);        // Y position
    ObjectSetInteger(0, "FormContainer", OBJPROP_XSIZE, width);           // Width of the form
    ObjectSetInteger(0, "FormContainer", OBJPROP_YSIZE, height);           // Height of the form
    ObjectSetInteger(0, "FormContainer", OBJPROP_CORNER, corner);       // Corner reference
    ObjectSetInteger(0, "FormContainer", OBJPROP_BGCOLOR, C'8,21,33'); // Background color
    ObjectSetInteger(0, "FormContainer", OBJPROP_STYLE, STYLE_SOLID);
}