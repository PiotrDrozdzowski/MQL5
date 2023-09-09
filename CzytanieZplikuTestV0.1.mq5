#property script_show_inputs
#property strict



void OnStart()
  {

   int i = 0;

   while(!IsStopped())     // user decide when program should be close, now program starts each 10 seconds 
      { 
         int file_handle=FileOpen("abc.csv",FILE_READ|FILE_CSV|FILE_ANSI,","); // open file
            if(file_handle!=INVALID_HANDLE) 
              {
                  Print("plik otwarty");
                  string myArray[10]; // creat an array for each variable in the file 
                  for (i = 0; i < ArraySize(myArray); i++) // 
                  {
                     myArray[i] = "variable_" + IntegerToString(i);
                     myArray[i] = FileReadString(file_handle); // overwriting each value from file into seperate array
                     Print (myArray[i]); // test array      
                     if (myArray[i] == ";EUR/USD")  // if some array contains string name EUR/USD, open an position
                        {
                           Print (myArray[i]);
                           double Open1 = iOpen("EURUSD",PERIOD_H1,1);
                      
                                        
                        }
                    
                     else
                        {
                           Print ("Array "+(i)+" no read");   
                        }
                     
                   }
                    
                                  
                  FileClose(file_handle); // Close file
              }
            
            else
               {
                  Print("File open failed, error ",GetLastError());
               }
      Sleep(10000); // Wait 10 seconds before next check
      }
   }
