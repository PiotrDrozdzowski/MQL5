#include <Trade\Trade.mqh>
#property script_show_inputs
#property strict
CTrade trade;
double Bid;

void TworzenieTablicDlaPozycji(); // prototype function
void OtwarciePozycjiBuy();
void OtwarciePozyjiSell();
void ArrayCompare();

void OnStart()
{

bool EURUSDSELL[120];                       // dawanie wartosci false dla konkretnej waluty   
TworzenieTablicDlaPozycji(EURUSDSELL);     // wartosc tablic musi byc taka sama jak "ZapisWszystkichDanych"
bool EURUSDBUY[120];                        
TworzenieTablicDlaPozycji(EURUSDBUY);
bool GBPUSDBUY[120];
TworzenieTablicDlaPozycji(GBPUSDBUY);
bool GBPUSDSELL[120];
TworzenieTablicDlaPozycji(GBPUSDSELL);
bool USDCADBUY[120];
TworzenieTablicDlaPozycji(USDCADBUY);
bool USDCADSELL[120];
TworzenieTablicDlaPozycji(USDCADSELL);
bool USDCHFBUY[120];
TworzenieTablicDlaPozycji(USDCHFBUY);
bool USDCHFSELL[120];
TworzenieTablicDlaPozycji(USDCHFSELL);

   while(!IsStopped())                                                           // user decide when program should be close, now program starts each 10 seconds 
   { 
        int file_handle = FileOpen("trades.csv",FILE_READ|FILE_CSV|FILE_ANSI,",");    // open file "trades.csv"
        int file_handle1 = FileOpen("trades1.csv",FILE_READ|FILE_CSV|FILE_ANSI,",");
        if(file_handle != INVALID_HANDLE && file_handle1 != INVALID_HANDLE) 
        {
            
            Print("Poczatek Programu \n\n");
            string ZapisWszystkichDanych[120];                                                  // create an array for each variable in the file 
            string ZapisWalutyIKupna[120];  
            string ZapisWszystkichDanychTrades1[120];
            string ZapisWalutyIKupnaTrades1[120]; 
            string ZamknietePozycje[120];                                        // creat an array for position
            for (int i = 0; i < ArraySize(ZapisWszystkichDanych) - 1; i++)                     // 
            {       
               
               ZapisWszystkichDanych[i] = FileReadString(file_handle);                         // overwriting each value from file into seperate array
               string modifiedName = StringReplace(ZapisWszystkichDanych[i], "\"", "");        // for each name in array """ is removed
               
               ZapisWszystkichDanychTrades1[i] = FileReadString(file_handle1);
               string modifiedNameTrades1 = StringReplace(ZapisWszystkichDanychTrades1[i], "\"","");
               
               
            }
            
            for (int i = 0; i < ArraySize(ZapisWszystkichDanych) - 1; i += 2 )                 // 
            {
               ZapisWalutyIKupna[i] = ZapisWszystkichDanych[i] + ZapisWszystkichDanych[i + 1];
               
               //Print ("Zapis Wszystkich Danych nr : " +  i + "   " + ZapisWszystkichDanych[i]);
               Print ("Zapis Waluty I Kupna nr=: " + i + "  " + ZapisWalutyIKupna[i]);
               
               ZapisWalutyIKupnaTrades1[i] = ZapisWszystkichDanychTrades1[i] + ZapisWszystkichDanychTrades1[i + 1];
               
               //Print ("Zapis Wszystkich Danych z Trades 1 nr : " + i + "  " + ZapisWszystkichDanychTrades1[i]);
               Print ("Zapis Waluty i Kupna Trades 1 nr : " + i + "  " + ZapisWalutyIKupnaTrades1[i]);
               
               ArrayCompare(ZapisWalutyIKupna,ZapisWalutyIKupnaTrades1,ZamknietePozycje);
               
               OtwarciePozyjiBuy(0.01,"EURUSD",EURUSDBUY[i],ZapisWalutyIKupna[i],"EUR/USDBUY");
               OtwarciePozyjiSell(0.01,"EURUSD",EURUSDSELL[i],ZapisWalutyIKupna[i],"EUR/USDSELL");
               OtwarciePozyjiBuy(0.01,"GBPUSD",GBPUSDBUY[i],ZapisWalutyIKupna[i],"GBP/USDBUY");
               OtwarciePozyjiSell(0.01,"GBPUSD",GBPUSDSELL[i],ZapisWalutyIKupna[i],"GBP/USDSELL");
               OtwarciePozyjiBuy(0.01,"USDCAD",USDCADBUY[i],ZapisWalutyIKupna[i],"USD/CADBUY");
               OtwarciePozyjiSell(0.01,"USDCAD",USDCADSELL[i],ZapisWalutyIKupna[i],"USD/CADSELL");
               OtwarciePozyjiBuy(0.01,"USDCHF",USDCHFBUY[i],ZapisWalutyIKupna[i],"USD/CHFBUY");
               OtwarciePozyjiSell(0.01,"USDCHF",USDCHFSELL[i],ZapisWalutyIKupna[i],"USD/CHFSELL");
             }

            FileClose(file_handle);
            FileClose(file_handle1);                                                          // Close file
        }
         
        else
        {
            Print("File open failed, error ",GetLastError());
        }
   Sleep(30000);                                                                 // Wait 30 seconds before next check
   }
}



void TworzenieTablicDlaPozycji(bool &array[])
   {
      for (int i=0; i < ArraySize(array); ++i)
      {
         array[i] = false;
      }
   }


void OtwarciePozyjiBuy(double volume, string symbol,bool &array,string &array2,string NazwaWalutyDane) 
   {
       double price = 0.0;
       double sl = 0.0;
       double tp = 0.0;
       string comment = "";
       
       CTrade buy;
       if (array2 == NazwaWalutyDane && array == false)
       {
          if (buy.Buy(volume, symbol, price, sl, tp, comment)) 
          {
              array = true;  // if position EURUSD BUY is open write this in array
              Print ("Pozycja " + NazwaWalutyDane + " jest otwarta!");
          }
        }    
    }

void OtwarciePozyjiSell(double volume, string symbol,bool &array,string &array2,string NazwaWalutyDane) 
   {
       double price = 0.0;
       double sl = 0.0;
       double tp = 0.0;
       string comment = "";
       
       CTrade sell;
       if (array2 == NazwaWalutyDane && array == false)
       {
          if (sell.Sell(volume, symbol, price, sl, tp, comment)) 
          {
              array = true;  // if position EURUSD BUY is open write this in array
              Print ("Pozycja " + NazwaWalutyDane + " jest otwarta!");
          }
        }    
    }

void ArrayCompare(string &array1[], string &array2[],string &array3[])
{
   int k = 0;
   for(int i=0; i<ArraySize(array1); i++)
   {
      bool found = false;
      for(int j=0; j<ArraySize(array2); j++)
      {
         if(array1[i] == array2[j]) 
         {
            found = true;
            break;
         }
      }
      if(!found)
      {
        array3[k] = array1[i];
        Print(array3[k]);
        k++;
      }
   }
}







