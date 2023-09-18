#include <Trade\Trade.mqh>
#property script_show_inputs
#property strict
CTrade trade;
double Bid;

void TworzenieTablicDlaPozycji(); // prototype function
void OtwarciePozycjiBuy();
void OtwarciePozyjiSell();


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
        int file_handle=FileOpen("trades.csv",FILE_READ|FILE_CSV|FILE_ANSI,",");    // open file "trades.csv"
        if(file_handle!=INVALID_HANDLE) 
        {
            
            Print("Poczatek Programu \n\n");
            string ZapisWszystkichDanych[120];                                                  // create an array for each variable in the file 
            string ZapisWalutyIKupna[120];                                           // creat an array for position
            for (int i = 0; i < ArraySize(ZapisWszystkichDanych) - 1; i++)                     // 
            {       
               
               ZapisWszystkichDanych[i] = FileReadString(file_handle);                         // overwriting each value from file into seperate array
               string modifiedName = StringReplace(ZapisWszystkichDanych[i], "\"", "");        // for each name in array """ is removed
            }
            for (int i = 0; i < ArraySize(ZapisWszystkichDanych) - 1; i += 2 )                 // 
            {
               ZapisWalutyIKupna[i] = ZapisWszystkichDanych[i] + ZapisWszystkichDanych[i + 1];
               Print ("Zapis Wszystkich Danych nr : " +  i + "   " + ZapisWszystkichDanych[i]);
               Print ("Zapis Waluty I Kupna nr=: " + i + "  " + ZapisWalutyIKupna[i]);
 
               OtwarciePozyjiBuy(0.01,"EURUSD",0.0,0.0,0.0,"",EURUSDBUY[i],ZapisWalutyIKupna[i],"EUR/USDBUY");
               OtwarciePozyjiSell(0.01,"EURUSD",0.0,0.0,0.0,"",EURUSDSELL[i],ZapisWalutyIKupna[i],"EUR/USDSELL");
               OtwarciePozyjiBuy(0.01,"GBPUSD",0.0,0.0,0.0,"",GBPUSDBUY[i],ZapisWalutyIKupna[i],"GBP/USDBUY");
               OtwarciePozyjiSell(0.01,"GBPUSD",0.0,0.0,0.0,"",GBPUSDSELL[i],ZapisWalutyIKupna[i],"GBP/USDSELL");
               OtwarciePozyjiBuy(0.01,"USDCAD",0.0,0.0,0.0,"",USDCADBUY[i],ZapisWalutyIKupna[i],"USD/CADBUY");
               OtwarciePozyjiSell(0.01,"USDCAD",0.0,0.0,0.0,"",USDCADSELL[i],ZapisWalutyIKupna[i],"USD/CADSELL");
               OtwarciePozyjiBuy(0.01,"USDCHF",0.0,0.0,0.0,"",USDCHFBUY[i],ZapisWalutyIKupna[i],"USD/CHFBUY");
               OtwarciePozyjiSell(0.01,"USDCHF",0.0,0.0,0.0,"",USDCHFSELL[i],ZapisWalutyIKupna[i],"USD/CHFSELL");
             }

            FileClose(file_handle);                                              // Close file
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


void OtwarciePozyjiBuy(double volume, string symbol, double price, double sl, double tp, string comment,bool &array,string &array2,string NazwaWalutyDane) 
   {
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

void OtwarciePozyjiSell(double volume, string symbol, double price, double sl, double tp, string comment,bool &array,string &array2,string NazwaWalutyDane) 
   {
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



