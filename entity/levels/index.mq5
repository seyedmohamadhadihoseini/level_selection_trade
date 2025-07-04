#include "./level.mq5";

class Levels
{
private:
public:
    Level arr[200];
    int length;
    Levels();
    ~Levels();
    int AssignNewLevel(double price, string type);
    void RemoveAll();
    int DataLength();
    void Remove(string name);
    void Sort();
    int LevelTouchedIndex();
    int LevelNextIndex(int currentIndex, int stepFromHere);
    int GetIndex(double price);
};

Levels::Levels()
{
    length = 200;
}
Levels::~Levels()
{
    RemoveAll();
}
int Levels::DataLength()
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
int Levels::AssignNewLevel(double price, string type)
{
    int index = -1;
    for (int i = 0; i < length; i++)
    {
        if (arr[i].isFreeForArr)
        {
            arr[i].Init(price, type);
            arr[i].Show();
            index = i;
            break;
        }
    }
    return index;
}
void Levels::RemoveAll()
{
    for (int i = 0; i < length; i++)
    {
        if (!(arr[i].isFreeForArr))
        {
            arr[i].Remove();
        }
    }
    ChartRedraw(0);
    Sleep(100);
}
void Levels::Remove(string name)
{
    for (int i = 0; i < length; i++)
    {
        if (arr[i].name == name)
        {
            arr[i].Remove();
            return;
        }
    }
}
int Levels::LevelTouchedIndex()
{
    int index = -1;
    for (int i = 0; i < length; i++)
    {
        if (!(arr[i].isFreeForArr))
        {
            if (arr[i].IsTouched())
            {
                index = i;
                break;
            }
        }
    }
    return index;
}
void Levels::Sort()
{
    for (int i = 0; i < length; i++)
    {
        if (!(arr[i].isFreeForArr))
        {
            double price = 99999999;
            int index = 0;
            for (int j = i; j < length; j++)
            {
                if (!(arr[j].isFreeForArr))
                {
                    if (arr[j].price <= price)
                    {
                        price = arr[j].price;
                        index = j;
                    }
                }
            }
            Level temp;
            temp.Init(arr[index].price, arr[index].type);
            arr[index].Init(arr[i].price, arr[i].type);
            arr[i].Init(temp.price, temp.type);
        }
    }
}
int Levels::LevelNextIndex(int currentIndex, int stepFromHere)
{
    int count = 0;
    int i = currentIndex;
    while (true)
    {
        if (count == MathAbs(stepFromHere))
        {
            return i;
        }
        i += stepFromHere > 0 ? 1 : -1;
        if (!(arr[i].isFreeForArr))
        {
            count++;
        }
    }
}
int Levels::GetIndex(double price)
{
    int index = -1;
    for (int i = 0; i < length; i++)
    {
        if (arr[i].price == price)
        {
            index = i;
            break;
        }
    }
    return index;
}