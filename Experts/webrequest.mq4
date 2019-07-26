#property copyright "jordi"
#property link      ""
#property version   "1.00"
#property strict

int OnInit()
{
   char data[];
   char result[];
   string headers;
   
   int status = WebRequest("POST", "http://localhost/public/", NULL, NULL, GetTickCount(), data, ArraySize(data), result, headers);
   Print("-------------------------------");
   Print("Status code: ", IntegerToString(status), " || Response body: ", CharArrayToString(result));
   Print("-------------------------------");
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