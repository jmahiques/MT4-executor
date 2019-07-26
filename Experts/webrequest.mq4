#property copyright "jordi"
#property link      ""
#property version   "1.00"
#property strict

input magicNumer = 1;
input testConnection = false;

int OnInit()
{  
   if (testConnection) {
      sendProbe();
   }
   return(INIT_SUCCEEDED);
}

void OnDeinit(const int reason)
{
    
}

void OnTick()
{
    
}

void OnChartEvent(const int id, const long &lparam, const double &dparam, const string &sparam)
{
    
}

void retrieveOrders(string symbol,int magicNumber)
{
   for(int i = 0; i < OrdersTotal(); i++) {
      if (!OrderSelect(i, SELECT_BY_POS)) {
         continue;
      }

      if (OrderCloseTime() != 0) {
         continue;
      }
      
      if (OrderSymbol() != Symbol() || OrderMagicNumber() != magicNumber) {
         continue;
      }
      
      OrderInformation* order = createOrderInformation();
      drawerHelper.drawLines(order);
   }
}

void sendProbe()
{
   char data[];
   char result[];
   string headers;
   
   int status = WebRequest("POST", "http://localhost/public/probe", NULL, NULL, GetTickCount(), data, ArraySize(data), result, headers);
   Print("-------------------------------");
   Print("Status code: ", IntegerToString(status));
   Print("-------------------------------");
}