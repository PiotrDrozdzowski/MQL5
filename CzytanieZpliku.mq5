
#property script_show_inputs

void OnStart()
  {

   
   
   int file_handle=FileOpen("abc.csv",FILE_READ|FILE_CSV|FILE_ANSI,",");
   if(file_handle!=INVALID_HANDLE)
     {
      Print("plik otwarty");
      
      int str_size = FileReadInteger(file_handle,INT_VALUE);
      string file_content = FileReadString(file_handle,str_size); // Odczyt zawartości pliku
      

   Print("Zawartość pliku ", "abc.csv", ":\n", file_content); // Wyświetlenie zawartości pliku
   FileClose(file_handle); // Zamknięcie pliku
     }
   else
      Print("File open failed, error ",GetLastError());
  }