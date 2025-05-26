<%
Function ShowMultipleValues(field)
    Dim val, i, result
    val = Request.Form(field)
    If IsArray(val) Then
        For i = 0 To UBound(val)
            result = result & val(i) & ", "
        Next
        result = Left(result, Len(result) - 2)
    Else
        result = val
    End If
    ShowMultipleValues = result
End Function
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Order Summary</title>
  <style>
    body {
      font-family: 'Segoe UI', sans-serif;
      background: #f9f9f9;
      padding: 40px;
    }
    .summary {
      background: #fff;
      padding: 30px;
      border-radius: 12px;
      max-width: 700px;
      margin: auto;
      box-shadow: 0 4px 10px rgba(0,0,0,0.1);
    }
    h2 {
      text-align: center;
      color: #d62828;
    }
    .info {
      margin-top: 20px;
      line-height: 1.6;
    }
    .highlight {
      background: #ffe8cc;
      padding: 10px;
      border-radius: 8px;
      text-align: center;
      margin-top: 30px;
      font-weight: bold;
      font-size: 18px;
    }
  </style>
</head>
<body>
  <div class="summary">
    <h2>Order Summary</h2>
    <div class="info">
      <strong>Name:</strong> <%= Session("customerName") %><br />
      <strong>Phone:</strong> <%= Session("phone") %><br />
      <strong>Address:</strong> <%= Session("address") %><br />
      <strong>Pizza:</strong> <%= Session("pizzaType") %> - <%= Session("pizzaSize") %><br />
      <strong>Sauces:</strong> <%= ShowMultipleValues("extraSauces") %><br />
      <strong>Toppings:</strong> <%= ShowMultipleValues("toppings") %><br />
      <strong>Second Pizza:</strong> <%= Session("secondPizza") %> - <%= Session("secondPizzaSize") %><br />
      <strong>Drink:</strong> <%= Session("drink") %><br />
      <strong>Notes:</strong> <%= Session("notes") %><br />
    </div>
    <div class="highlight">
      Estimated delivery time: 45 minutes.<br />
      🍕 Enjoy your meal!
    </div>
  </div>
</body>
</html>
