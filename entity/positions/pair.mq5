class PairPosition
{
public:
    int Position1Index;
    int Position2Index;
     
    void DisableAll();
    void DisablePosition(int index);
    int Length(Positions& positions);
    int GetBiggerPosition(Positions& positions);
    int GetLowerPosition(Positions& positions);
    PairPosition();
    ~PairPosition();
};
int PairPosition::GetBiggerPosition(Positions& positions){
    int result = -1;
    if(Position1Index == -1 && Position2Index==-1){
        result =  -1;
    }else if(Position2Index== -1){
        result =  Position1Index;
    }else if(Position1Index == -1){
        result = Position2Index;
    }else {
        double pos1P = positions.arr[Position1Index].riskPercent;
        double pos2P = positions.arr[Position2Index].riskPercent;
        if(pos1P > pos2P){
            result = Position1Index;
        }else{
            result = Position2Index;
        }
    }

    return result;
}
int PairPosition::GetLowerPosition(Positions& positions){
    int result = -1;
    int index = GetBiggerPosition(positions);
    if(index == -1){
        result = -1;
    }else if(index == Position1Index){
        result = (Position2Index == -1)?Position1Index:Position2Index;
    }else if(index == Position2Index){
        result = Position1Index;
    }
    return result;
}
int PairPosition::Length(Positions& positions)
{
    int count = 0;
    if (Position1Index != -1)
    {
        Position pos1 = positions.arr[Position1Index];
        
        if(pos1.IsOpen(1) &&!pos1.IsRiskFreeDone(1) ){
            count ++;
        }
    }
    if (Position2Index != -1)
    {
        Position pos2 = positions.arr[Position2Index];
        if(pos2.IsOpen(1)&& !pos2.IsRiskFreeDone(1)){
            count ++;
        }
    }
    return count;
}
void PairPosition::DisableAll()
{
    Position1Index = -1;
    Position2Index = -1;
}
void PairPosition::DisablePosition(int index){
    if(index == 1){
        Position1Index = -1;
    }else if(index == 2){
        Position2Index = -1;
    }
}
PairPosition::PairPosition(/* args */)
{
    DisableAll();
}

PairPosition::~PairPosition()
{
}
