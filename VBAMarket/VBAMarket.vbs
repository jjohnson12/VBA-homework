Sub ticker()

'Jason Johnson'

' Create a script that will loop through all the stocks for one year for each run and take the following information.

Dim ws As Worksheet
Dim starting_ws As Worksheet
Dim lastrow As Long
Dim current_stock_end, current_stock_start, current_stock_begin_price, current_stock_end_price, start_ticker_list As Integer
Dim stock_change_percent As Double
Dim current_volume As Variant

' LOOP THROUGH ALL SHEETS

For Each ws In Worksheets
ws.Activate


lastrow = Cells(Rows.Count, 1).End(xlUp).Row

current_stock_start = 2
current_stock_end = 0
start_ticker_list = 1
current_stock_begin_price = 0
current_stock_end_price = 0
stock_change = 0
stock_change_percent = 0
current_volume = 0
max_percent_change = 0
min_percent_change = 0
greatest_volume = 0

'Create column headers

    Cells(1, 9).Value = "Ticker"
    Cells(1, 10).Value = "Yearly Change"
    Cells(1, 11).Value = "Percentage Change"
    Cells(1, 12).Value = "Total Stock Volume"
    Cells(2, 14).Value = "Greatest % Increase"
    Cells(3, 14).Value = "Greatest % Decrease"
    Cells(4, 14).Value = "Greatest TotalVolume"
    Cells(1, 15).Value = "Ticker"
    Cells(1, 16).Value = "Value"

  ' Set a variable for specifying the column of interest

  ' Loop through rows in the column
  For i = 2 To lastrow

    ' Searches for when the value of the next cell is different than that of the current cell
    
    If Cells(i + 1, 1).Value <> Cells(i, 1).Value Then
     
     ' set the last row of the current stock'
      current_stock_end = i

      ' advance the cell to put the ticker name into, so that this will advance one cell at a time'
      start_ticker_list = start_ticker_list + 1

' write the ticker name into the new list'
        Cells(start_ticker_list, 9) = Cells(i, 1).Value

' Yearly change from opening price at the beginning of a given year to the closing price at the end of that year.

    current_stock_begin_price = Cells(current_stock_start, 6).Value
    current_stock_end_price = Cells(current_stock_end, 6).Value

   stock_change = current_stock_end_price - current_stock_begin_price

'write the change into the list'
      Cells(start_ticker_list, 10).Value = stock_change

' ' The percent change from opening price at the beginning of a given year to the closing price at the end of that year.
      If current_stock_begin_price = 0 Then
        stock_change_percent = 0
      Else
       stock_change_percent = (stock_change / current_stock_begin_price)
      End If
    
 'write the percent change into the list'
      
      Cells(start_ticker_list, 11) = Format(stock_change_percent, "Percent")
         
' ' The total stock volume of the stock.
    For j = current_stock_start To current_stock_end
        If Cells(j - 1, 1).Value = Cells(j, 1).Value Then
        volume = Cells(j, 7).Value
        current_volume = current_volume + volume
        End If
        Next j
        
    If Cells(start_ticker_list, 11) > max_percent_change Then
      Cells(2, 15).Value = Cells(i, 1)
      Cells(2, 16).Value = Cells(start_ticker_list, 11)
      Cells(2, 16).Value = Format(stock_change_percent, "Percent")
      max_percent_change = Cells(start_ticker_list, 11)
    End If

     If Cells(start_ticker_list, 11) < min_percent_change Then
      Cells(3, 15).Value = Cells(i, 1)
      Cells(3, 16).Value = Cells(start_ticker_list, 11)
      Cells(3, 16).Value = Format(stock_change_percent, "Percent")
      min_percent_change = Cells(start_ticker_list, 11)
    End If

 'write the volume into the list'

      Cells(start_ticker_list, 12) = current_volume

    If Cells(start_ticker_list, 12) > greatest_volume Then
      Cells(4, 15) = Cells(i, 1)
      Cells(4, 16) = Cells(start_ticker_list, 12)
      greatest_volume = Cells(start_ticker_list, 12)
    End If
      
'update the ticker start row and reset the other items

        current_stock_start = i + 1
        current_stock_begin_price = 0
        current_stock_end_price = 0
        stock_change = 0
        current_volume = 0
        
    End If

  Next i
  
current_stock_start = 2
start_ticker_list = 1
  
' You should also have conditional formatting that will highlight positive change in green and negative change in red.
    lastrow_percent = Cells(Rows.Count, 10).End(xlUp).Row
    
    For i = 2 To lastrow_percent
        
        If Cells(i, 10).Value < 0 Then
        
   'Set the Font color to Red
            Cells(i, 10).Interior.ColorIndex = 3
    
        Else
        
  ' Set the Font Color to Green
            Cells(i, 10).Interior.ColorIndex = 4
    
        End If
        
    Next i
    
 Next ws

End Sub
