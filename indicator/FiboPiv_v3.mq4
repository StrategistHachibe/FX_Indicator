//+------------------------------------------------------------------+
//|                                                   FiboPiv_v1.mq4 |
//|                                                          Kalenzo |
//|                                      bartlomiej.gorski@gmail.com |
//+------------------------------------------------------------------+
#property copyright "Kalenzo"
#property link      "bartlomiej.gorski@gmail.com"
extern color Resistance_3 = Lime;
extern color Resistance_2 = Green;
extern color Resistance_1 = DarkGreen;
extern color Piviot = Blue;
extern color Support_1 = Maroon;
extern color Support_2 = Crimson;
extern color Support_3 = Red;
#property indicator_chart_window
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
//---- indicators
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator deinitialization function                       |
//+------------------------------------------------------------------+
int deinit()
  {
//----
   ObjectDelete("S1");
   ObjectDelete("S2");
   ObjectDelete("S3");
   ObjectDelete("R1");
   ObjectDelete("R2");
   ObjectDelete("R3");
   ObjectDelete("PIVIOT");
   ObjectDelete("Support 1");
   ObjectDelete("Support 2");
   ObjectDelete("Support 3");
   ObjectDelete("Piviot level");
   ObjectDelete("Resistance 1");
   ObjectDelete("Resistance 2");
   ObjectDelete("Resistance 3");
   Comment(" ");
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int start()
  {
   
//----
double rates[1][6],yesterday_close,yesterday_high,yesterday_low;
ArrayCopyRates(rates, Symbol(), PERIOD_D1);

if(DayOfWeek() == 1)
{
   if(TimeDayOfWeek(iTime(Symbol(),PERIOD_D1,1)) == 5)
   {
       yesterday_close = rates[1][4];
       yesterday_high = rates[1][3];
       yesterday_low = rates[1][2];
   }
   else
   {
      for(int d = 5;d>=0;d--)
      {
         if(TimeDayOfWeek(iTime(Symbol(),PERIOD_D1,d)) == 5)
         {
             yesterday_close = rates[d][4];
             yesterday_high = rates[d][3];
             yesterday_low = rates[d][2];
         }
         
      }  
      
   }
}
else
{
    yesterday_close = rates[1][4];
    yesterday_high = rates[1][3];
    yesterday_low = rates[1][2];
}


//---- Calculate Pivots

Comment("\nYesterday quotations:\nH ",yesterday_high,"\nL ",yesterday_low, "\nC ",yesterday_close);
double R = yesterday_high - yesterday_low;//range
double p = (yesterday_high + yesterday_low + yesterday_close)/3;// Standard Pivot
double r3 = p + (R * 1.000);
double r2 = p + (R * 0.618);
double r1 = p + (R * 0.382);
double s1 = p - (R * 0.382);
double s2 = p - (R * 0.618);
double s3 = p - (R * 1.000);

drawLine(r3,"R3", Resistance_3,0);
drawLabel("Resistance 3",r3,Resistance_3);
drawLine(r2,"R2", Resistance_2,0);
drawLabel("Resistance 2",r2,Resistance_2);
drawLine(r1,"R1", Resistance_1,0);
drawLabel("Resistance 1",r1,Resistance_1);

drawLine(p,"PIVIOT",Piviot,1);
drawLabel("Piviot level",p,Piviot);

drawLine(s1,"S1",Support_1,0);
drawLabel("Support 1",s1,Support_1);
drawLine(s2,"S2",Support_2,0);
drawLabel("Support 2",s2,Support_2);
drawLine(s3,"S3",Support_3,0);
drawLabel("Support 3",s3,Support_3);


//----
   return(0);
  }
//+------------------------------------------------------------------+
void drawLabel(string name,double lvl,color Color)
{
    if(ObjectFind(name) != 0)
    {
        ObjectCreate(name, OBJ_TEXT, 0, Time[10], lvl);
        ObjectSetText(name, name, 8, "Arial", EMPTY);
        ObjectSet(name, OBJPROP_COLOR, Color);
    }
    else
    {
        ObjectMove(name, 0, Time[10], lvl);
    }
}


void drawLine(double lvl,string name, color Col,int type)
{
         if(ObjectFind(name) != 0)
         {
            ObjectCreate(name, OBJ_HLINE, 0, Time[0], lvl,Time[0],lvl);
            
            if(type == 1)
            ObjectSet(name, OBJPROP_STYLE, STYLE_SOLID);
            else
            ObjectSet(name, OBJPROP_STYLE, STYLE_DOT);
            
            ObjectSet(name, OBJPROP_COLOR, Col);
            ObjectSet(name,OBJPROP_WIDTH,1);
            
         }
         else
         {
            ObjectDelete(name);
            ObjectCreate(name, OBJ_HLINE, 0, Time[0], lvl,Time[0],lvl);
            
            if(type == 1)
            ObjectSet(name, OBJPROP_STYLE, STYLE_SOLID);
            else
            ObjectSet(name, OBJPROP_STYLE, STYLE_DOT);
            
            ObjectSet(name, OBJPROP_COLOR, Col);        
            ObjectSet(name,OBJPROP_WIDTH,1);
          
         }
}