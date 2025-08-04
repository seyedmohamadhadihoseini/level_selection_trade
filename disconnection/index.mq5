#include "recovery/index.mq5";

void DisconnectionHandler()
{
    bool isConnected = TerminalInfoInteger(TERMINAL_CONNECTED);
    static bool IsNowConnected = false;
    static datetime DisconnectionTime;
    if (!isConnected)
    {
        if (!IsNowConnected)
        {
            DisconnectionTime = myTime(0);
        }

        IsNowConnected = true;
        IsDisconnectionHandlerEnd = false;
    }
    else if (IsNowConnected)
    {
        IsNowConnected = false;
        Sleep(200);
        RecoverLevelsAndPositionsAfterDisconnection(DisconnectionTime);
        IsDisconnectionHandlerEnd = true;
    }
}