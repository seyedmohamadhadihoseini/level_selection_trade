void CreateEditText(string name, long xPos, long yPos, long width, long height,long font_size, ENUM_BASE_CORNER corner)
{
    ObjectCreate(0, name, OBJ_EDIT, 0, 0, 0);
    ObjectSetInteger(0, name, OBJPROP_XSIZE, width);
    ObjectSetInteger(0, name, OBJPROP_YSIZE, height);
    ObjectSetInteger(0, name, OBJPROP_FONTSIZE, font_size);
    ObjectSetInteger(0, name, OBJPROP_XDISTANCE, xPos);     // Relative to FormContainer
    ObjectSetInteger(0, name, OBJPROP_YDISTANCE, yPos);     // Relative to FormContainer
    ObjectSetInteger(0, name, OBJPROP_CORNER, corner);      // Corner reference
    ObjectSetInteger(0, name, OBJPROP_BGCOLOR, C'2,0,8'); // Background color
    ObjectSetInteger(0, name, OBJPROP_COLOR, C'226,236,225');
}