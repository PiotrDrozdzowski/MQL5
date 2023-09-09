#include <Trade\Trade.mqh>
#property script_show_inputs
struct TradeData
{
   string pair;
   string action;
};
TradeData tradeArray[];
void OnStart()
  {
   
   int i = 0;
  
   int file_handle=FileOpen("abc.csv",FILE_READ|FILE_CSV|FILE_ANSI,",");
   if(file_handle!=INVALID_HANDLE)
     {
         string line;
         while (FileIsEnding(file_handle) == false )
         {
            line=FileReadString(file_handle);
            string splitArray[];
            StringSplit(line, ',', splitArray);
            
            if (ArraySize(splitArray) == 2)
            {
               
               TradeData trade;
               trade.pair = splitArray[0];
               trade.action = splitArray[1];
               ArrayResize(tradeArray, ArraySize(tradeArray) + 1);
               tradeArray[ArraySize(tradeArray) -1] = trade;
            }
            
         }
    
   
   
 
   FileClose(file_handle); // Zamknięcie pliku
   }
   else
        {
            Print("File open failed, error ",GetLastError());
        }
     
     
   for (int i = 0; i < ArraySize(tradeArray); i++)
{
    Print("Pair:", tradeArray[i].pair, ", Action:", tradeArray[i].action);
}
}


  
  
  
  
  
  
  
  