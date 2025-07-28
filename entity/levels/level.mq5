
enum LevelTypes
{
    level_buy,
    level_sell,
    level_lastbuy,
    level_lastsell
};
class Level
{
private:
public:
    string name;
    double price;
    string type;
    bool isFreeForArr;
    bool isForBuy;
    bool isForTrade;
    Level()
    {
        isFreeForArr = true;
        price = 9999999999;
    }
    void Init(double price, string type);
    void Show();
    void Remove();
    bool IsTouched();
    bool IsTouched(double tprice);
};

void Level::Init(double _price, string _type)
{
    price = _price;
    type = _type;
    name = "lv_" + (string)price;
    isFreeForArr = false;
    isForBuy = type == "level_buy" || type == "level_lastbuy";
    isForTrade = type == "level_buy" || type == "level_sell";
}
void Level::Show()
{
    if (type == "level_buy")
    {
        HLineCreate(0, name, 0, price, clrBlue);
    }
    else if (type == "level_sell")
    {
        HLineCreate(0, name, 0, price, clrRed);
    }
    else if (type == "level_lastbuy")
    {
        HLineCreate(0, name, 0, price, C'20,240,221');
    }
    else if (type == "level_lastsell")
    {
        HLineCreate(0, name, 0, price, C'221,72,72');
    }
}
bool Level::IsTouched(double tprice)
{
    bool result = false;
    if (isForBuy)
    {

        if (tprice - (telorance_pip * 10 * _Point) <= price)
        {
            result = true;
        }
    }
    else
    {

        if (tprice + (telorance_pip * 10 * _Point) >= price)
        {
            result = true;
        }
    }

    return result;
}
bool Level::IsTouched()
{
    return IsTouched(isForBuy ? myBid() : myAsk());
}
void Level::Remove()
{
    isFreeForArr = true;
    HLineDelete(0, name);
}
