#property copyright "jordi"
#property link      ""
#property version   "1.00"
#property strict

input int magicNumer = 1;
input bool lookupAndSendOrders = true;
input string baseUrl = "http://localhost";

int maxRetries = 5;

int OnInit()
{  
   if (!sendProbe()) {
      Print("Could not establish connection with the backend.");
      return(INIT_FAILED);
   }
   
   if (!sendCreateInstrument()) {
       Print("Could not create the instrument in the backend.");
       return(INIT_FAILED);
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

bool sendProbe()
{
   char data[];
   char result[];
   string headers;
   int i = 1;
   int status = -1;
   string url = StringConcatenate(baseUrl, "/probe");
   
   while (status != 200 && i <= 5) {
      status = WebRequest("POST", url, NULL, NULL, GetTickCount(), data, ArraySize(data), result, headers);
      Print("-------------------------------");
      Print("Status code: ", IntegerToString(status));
      Print("-------------------------------");
      i++;
   }
   
   return status == 200;
}

void sendTickData()
{
   string payload = StringConcatenate("I=", Symbol(), "&B=", Bid, "&A=", Ask, "&T=", TimeToString(TimeCurrent()));
   char payloadChar[];
   char result[];
   string headers = "Content-Type: application/x-www-form-urlencoded";
   int i = 1;
   int status = -1;
   string url = StringConcatenate(baseUrl, "/tick");
   
   StringToCharArray(payload, payloadChar);
   
   while (status != 200 && i <= 5) {
      status = WebRequest("POST", url, NULL, NULL, GetTickCount(), payloadChar, ArraySize(payloadChar), result, headers);
      Print("-----------------------------");
      Print("Payload: ", payload, " || Response code: ", status);
      Print("-----------------------------");
      i++;
   }
}

bool sendCreateInstrument()
{
   string payload = StringConcatenate("N=", Symbol(), "&D=", Digits);
   char payloadChar[];
   char result[];
   string headers = "Content-Type: application/x-www-form-urlencoded";
   int i = 1;
   int status = -1;
   string url = StringConcatenate(baseUrl, "/instrument/create");
   
   StringToCharArray(payload, payloadChar);
   
   while (status != 200 && i <= 5) {
      status = WebRequest("POST", url, NULL, NULL, GetTickCount(), payloadChar, ArraySize(payloadChar), result, headers);
      Print("-----------------------------");
      Print("Payload: ", payload, " || Response code: ", status);
      Print("-----------------------------");
      i++;
   }
   
   return status == 200;
}