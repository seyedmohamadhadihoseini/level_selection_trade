#include "position.mq5";

class Positions
{
private:
public:
    Position arr[2000];
    int length;
    Positions();
    ~Positions();
    int AssignNewPosition(ulong ticket1, string initialState1, ulong ticket2, string initialState2, double riskPercent);
    void RemoveAll();
    int DataLength();
    int DataLength(string state);
    void Remove(ulong ticket1);
    int GetFirstPositionIndex();
    int GetFirstPositionIndex(string state);
};

Positions::Positions()
{
    length = 2000;
}
Positions::~Positions()
{
    RemoveAll();
}
int Positions::DataLength()
{
    int count = 0;
    for (int i = 0; i < length; i++)
    {
        if (!arr[i].isFreeForArr)
        {
            count++;
        }
    }
    return count;
}
int Positions::DataLength(string state)
{
    int count = 0;
    for (int i = 0; i < length; i++)
    {
        Position position = arr[i];
        if (!(position.isFreeForArr))
        {
            if (position.GetLastestState() == state)
            {
                count++;
            }
        }
    }
    return count;
}
int Positions::AssignNewPosition(ulong ticket1, string initialState1, ulong ticket2, string initialState2, double riskPercent)
{
    for (int i = 0; i < length; i++)
    {
        if (arr[i].isFreeForArr)
        {
            arr[i].Init(ticket1, initialState1, ticket2, initialState2);
            arr[i].riskPercent = riskPercent;
            arr[i].isFreeForArr = false;
            return i;
        }
    }
    return -1;
}
void Positions::RemoveAll()
{
    for (int i = 0; i < length; i++)
    {
        arr[i].Remove();
    }
}
void Positions::Remove(ulong ticket1)
{
    for (int i = 0; i < length; i++)
    {
        if (arr[i].ticket1 == ticket1)
        {
            arr[i].Remove();
            return;
        }
    }
}
int Positions::GetFirstPositionIndex()
{
    int result = -1;
    for (int i = 0; i < length; i++)
    {
        if (!(arr[i].isFreeForArr))
        {
            result = i;
            break;
        }
    }
    return result;
}
int Positions::GetFirstPositionIndex(string state)
{
    int result = -1;
    for (int i = 0; i < length; i++)
    {
        if (!(arr[i].isFreeForArr))
        {
            if (arr[i].GetLastestState() == state)
            {
                result = i;
                break;
            }
        }
    }
    return result;
}
#include  "pair.mq5";