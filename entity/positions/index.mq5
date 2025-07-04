#include "./position.mq5";

class Positions
{
private:
public:
    Position arr[200];
    int length;
    Positions();
    ~Positions();
    int AssignNewPosition(ulong ticket1, string initialState1, ulong ticket2, string initialState2);
    void RemoveAll();
    int DataLength();
    void Remove(ulong ticket1);
};

Positions::Positions()
{
    length = 200;
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
int Positions::AssignNewPosition(ulong ticket1, string initialState1 , ulong ticket2, string initialState2)
{
    for (int i = 0; i < length; i++)
    {
        if (arr[i].isFreeForArr)
        {
            arr[i].Init(ticket1, initialState1, ticket2, initialState2);
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
