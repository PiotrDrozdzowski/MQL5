#include <Trade\Trade.mqh>
#property script_show_inputs
#property strict
CTrade trade;


void TworzenieTablicy(int &array){
   for (int i = 0; i < 10 ; i++){
      array = i * i;
      Print(array);
   }

}


void ZaawansowanaFunkcja(string a){
   TworzenieTablicy();
}


void OnStart()
{
   int Tablica;
   //ZaawansowanaFunkcja(5);
   

}
   

