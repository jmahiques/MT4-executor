#property copyright "jordi"
#property link      ""
#property version   "1.00"
#property strict

input int magicNumer = 1;
input bool testConnection = false;
input bool lookupAndSendOrders = true;

int maxRetries = 5;

int OnInit()
{  
   if (testConnection) {
      sendProbe();
   }
   
   if (lookupAndSendOrders) {
      
   }
   sendTickData();
   
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

void loopOrdes(string symbol,int magicNumber)
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
     
   }
}

void sendProbe()
{
   char data[];
   char result[];
   string headers;
   int i = 1;
   int status = -1;
   
   while (status != 200 && i <= 5) {
      status = WebRequest("POST", "http://localhost/public/probe", NULL, NULL, GetTickCount(), data, ArraySize(data), result, headers);
      Print("-------------------------------");
      Print("Status code: ", IntegerToString(status));
      Print("-------------------------------");
      i++;
   }
}

void sendTickData()
{
   string payload = StringConcatenate("I=", Symbol(), "&B=", Bid, "&A=", Ask, "&T=", TimeToString(TimeCurrent()));
   char payloadChar[];
   char result[];
   string headers = "Content-Type: application/x-www-form-urlencoded";
   int i = 1;
   int status = -1;
   
   StringToCharArray(payload, payloadChar);
   
   while (status != 200 && i <= 5) {
      status = WebRequest("POST", "http://localhost/public/tick", NULL, NULL, GetTickCount(), payloadChar, ArraySize(payloadChar), result, headers);
      Print("-----------------------------");
      Print("Payload: ", payload, " || Response code: ", status);
      Print("-----------------------------");
      i++;
   }
}