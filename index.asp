<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Pizza Order Form</title>
  <link rel="stylesheet" href="style.css" />
  <style>
    .pizza-options label {
      display: inline-block;
      margin-right: 15px;
      text-align: center;
      cursor: pointer;
    }
    .pizza-options img {
      width: 100px;
      height: 100px;
      display: block;
      margin: 0 auto 5px;
      border-radius: 8px;
      border: 1px solid #ccc;
    }
    .total-price {
      position: fixed;
      bottom: 15px;
      right: 15px;
      padding: 12px 20px;
      background: #eee;
      border: 1px solid #ccc;
      border-radius: 8px;
      font-weight: bold;
      font-size: 18px;
      width: 180px;
      text-align: center;
      box-shadow: 1px 1px 5px rgba(0,0,0,0.1);
    }
  </style>
</head>
<body>
  <div class="container">
    <h1>Order Your Pizza</h1>
    <nav>
      <a href="index.asp">Place Order</a> |
      <a href="summary.asp">Order Summary</a>
    </nav>
    <form action="order.asp" method="post">

      <label>Name:</label>
      <input type="text" name="customerName" required />

      <label>Phone Number:</label>
      <input type="tel" name="phone" placeholder="05XX-XXX-XXXX" pattern="05[0-9]{2}-[0-9]{3}-[0-9]{4}" required />
      <small>Format: 05XX-XXX-XXXX</small>

      <label>Address:</label>
      <input type="text" name="address" required />

      <label>
        <input type="checkbox" name="rememberAddress" value="yes" />
        Remember my address for next time
      </label>

      <label>Choose Your Pizza (350 TL):</label>
      <div class="pizza-options">
        <label>
          <input type="radio" name="pizzaType" value="Margherita" required />
          <img src="margherita.jpg" alt="Margherita" />
          Margherita
        </label>
        <label>
          <input type="radio" name="pizzaType" value="Pepperoni" />
          <img src="pepperoni.jpg" alt="Pepperoni" />
          Pepperoni
        </label>
        <label>
          <input type="radio" name="pizzaType" value="Veggie" />
          <img src="veggie.jpg" alt="Veggie" />
          Veggie
        </label>
        <label>
          <input type="radio" name="pizzaType" value="Mixed" />
          <img src="mixed.jpg" alt="Mixed" />
          Mixed
        </label>
      </div>

      <label>Choose Size:</label>
      <select name="pizzaSize" required>
        <option value="Small">Small (+0 TL)</option>
        <option value="Medium">Medium (+50 TL)</option>
        <option value="Large">Large (+100 TL)</option>
      </select>

      <label>Extra Sauces (+10 TL each):</label>
      <div>
        <label><input type="checkbox" name="extraSauces" value="Honey Mustard" /> Honey Mustard</label><br>
        <label><input type="checkbox" name="extraSauces" value="Ranch" /> Ranch</label><br>
        <label><input type="checkbox" name="extraSauces" value="Blue Cheese" /> Blue Cheese</label>
      </div>

      <label>Extra Toppings (+10 TL each):</label>
      <div>
        <label><input type="checkbox" name="toppings" value="Sausage" /> Sausage</label>
        <label><input type="checkbox" name="toppings" value="Mushroom" /> Mushroom</label>
        <label><input type="checkbox" name="toppings" value="Olives" /> Olives</label>
        <label><input type="checkbox" name="toppings" value="Onion" /> Onion</label>
      </div>

      <label>Do you want a second pizza? (10% discount on second pizza):</label>
      <select name="secondPizza">
        <option value="None">No</option>
        <option value="Margherita">Margherita (350 TL)</option>
        <option value="Pepperoni">Pepperoni (350 TL)</option>
        <option value="Veggie">Veggie (350 TL)</option>
        <option value="Mixed">Mixed (350 TL)</option>
      </select>

      <label>Second Pizza Size:</label>
      <select name="secondPizzaSize">
        <option value="Small">Small (+0 TL)</option>
        <option value="Medium">Medium (+50 TL)</option>
        <option value="Large">Large (+100 TL)</option>
      </select>

      <label>Choose a Drink:</label>
      <select name="drink">
        <option value="Coke">Coke</option>
        <option value="Fanta">Fanta</option>
        <option value="Sprite">Sprite</option>
        <option value="Water">Water</option>
      </select>

      <label>Order Notes:</label>
      <textarea name="notes" placeholder="Anything else we should know?"></textarea>

      <input type="submit" value="Place Order" />
    </form>
  </div>

  <div class="total-price" id="totalPrice">
    <!-- ASP ile toplam fiyat buraya yazdırılacak -->
    <% 
      ' Başlangıç fiyatları
      Const basePrice = 350
      Dim pizzaPrice, pizzaSizePrice, extraSauceCount, extraToppingCount
      Dim secondPizzaPrice, secondPizzaSizePrice, secondPizzaDiscount
      Dim totalPrice

      ' Formdan gelen verileri oku
      pizzaPrice = basePrice
      pizzaSizePrice = 0
      extraSauceCount = 0
      extraToppingCount = 0
      secondPizzaPrice = 0
      secondPizzaSizePrice = 0
      secondPizzaDiscount = 0

      ' Pizza boyutuna göre fiyat ekle
      Select Case Request.Form("pizzaSize")
        Case "Medium"
          pizzaSizePrice = 50
        Case "Large"
          pizzaSizePrice = 100
      End Select

      ' Ekstra sos sayısı (çoklu checkbox)
      If IsArray(Request.Form("extraSauces")) Then
        extraSauceCount = UBound(Request.Form("extraSauces")) - LBound(Request.Form("extraSauces")) + 1
      ElseIf Request.Form("extraSauces") <> "" Then
        extraSauceCount = 1
      End If

      ' Ekstra malzeme sayısı
      If IsArray(Request.Form("toppings")) Then
        extraToppingCount = UBound(Request.Form("toppings")) - LBound(Request.Form("toppings")) + 1
      ElseIf Request.Form("toppings") <> "" Then
        extraToppingCount = 1
      End If

      ' İkinci pizza seçimi fiyatı
      If Request.Form("secondPizza") <> "None" And Request.Form("secondPizza") <> "" Then
        secondPizzaPrice = basePrice
        Select Case Request.Form("secondPizzaSize")
          Case "Medium"
            secondPizzaSizePrice = 50
          Case "Large"
            secondPizzaSizePrice = 100
        End Select
        secondPizzaDiscount = 0.1 ' %10 indirim
      End If

      ' Toplam fiyat hesapla
      totalPrice = (pizzaPrice + pizzaSizePrice + (extraSauceCount * 10) + (extraToppingCount * 10)) + _
                   ((secondPizzaPrice + secondPizzaSizePrice) * (1 - secondPizzaDiscount))

      Response.Write "Total Price: " & totalPrice & " TL"
    %>
  </div>
</body>
</html>
