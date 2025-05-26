<%@ Language="VBScript" %>
<%
If Session("loggedIn") <> True Then
    Response.Redirect "login.asp"
End If
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Pizza Order</title>
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
    <form action="summary.asp" method="post" id="pizzaForm">

      <label>Name:</label>
      <input type="text" name="customerName" required />

      <label>Phone Number:</label>
      <input type="tel" name="phone" required />

      <label>Address:</label>
      <input type="text" name="address" required />

      <label>Choose Your Pizza (350 TL):</label>
      <div class="pizza-options">
        <label>
          <input type="radio" name="pizzaType" value="Margherita" required onclick="updatePrice()" />
          <img src="images/margherita.jpg" alt="Margherita" />
          Margherita
        </label>
        <label>
          <input type="radio" name="pizzaType" value="Pepperoni" onclick="updatePrice()" />
          <img src="images/pepperoni.jpg" alt="Pepperoni" />
          Pepperoni
        </label>
        <label>
          <input type="radio" name="pizzaType" value="Veggie" onclick="updatePrice()" />
          <img src="images/veggie.jpg" alt="Veggie" />
          Veggie
        </label>
        <label>
          <input type="radio" name="pizzaType" value="Mixed" onclick="updatePrice()" />
          <img src="images/mixed.jpg" alt="Mixed" />
          Mixed
        </label>
      </div>

      <label>Choose Size:</label>
      <select name="pizzaSize" onchange="updatePrice()" required>
        <option value="Small">Small (+0 TL)</option>
        <option value="Medium">Medium (+50 TL)</option>
        <option value="Large">Large (+100 TL)</option>
      </select>

      <label>Extra Sauces (+10 TL each):</label>
      <div>
        <label><input type="checkbox" name="extraSauces" value="Honey Mustard" onclick="updatePrice()" /> Honey Mustard</label><br>
        <label><input type="checkbox" name="extraSauces" value="Ranch" onclick="updatePrice()" /> Ranch</label><br>
        <label><input type="checkbox" name="extraSauces" value="Blue Cheese" onclick="updatePrice()" /> Blue Cheese</label>
      </div>

      <label>Extra Toppings (+10 TL each):</label>
      <div>
        <label><input type="checkbox" name="toppings" value="Sausage" onclick="updatePrice()" /> Sausage</label>
        <label><input type="checkbox" name="toppings" value="Mushroom" onclick="updatePrice()" /> Mushroom</label>
        <label><input type="checkbox" name="toppings" value="Olives" onclick="updatePrice()" /> Olives</label>
        <label><input type="checkbox" name="toppings" value="Onion" onclick="updatePrice()" /> Onion</label>
      </div>

      <label>Do you want a second pizza? (10% discount):</label>
      <select name="secondPizza" onchange="updatePrice()">
        <option value="None">No</option>
        <option value="Margherita">Margherita (350 TL)</option>
        <option value="Pepperoni">Pepperoni (350 TL)</option>
        <option value="Veggie">Veggie (350 TL)</option>
        <option value="Mixed">Mixed (350 TL)</option>
      </select>

      <label>Second Pizza Size:</label>
      <select name="secondPizzaSize" onchange="updatePrice()">
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

  <div class="total-price" id="totalPrice">Total: 0 TL</div>

  <script>
    function updatePrice() {
      let total = 0;

      // Base pizza
      const pizzaSelected = document.querySelector('input[name="pizzaType"]:checked');
      if (pizzaSelected) total += 350;

      // Size
      const size = document.querySelector('select[name="pizzaSize"]').value;
      if (size === "Medium") total += 50;
      else if (size === "Large") total += 100;

      // Sauces
      const sauces = document.querySelectorAll('input[name="extraSauces"]:checked');
      total += sauces.length * 10;

      // Toppings
      const toppings = document.querySelectorAll('input[name="toppings"]:checked');
      total += toppings.length * 10;

      // Second pizza
      const secondPizza = document.querySelector('select[name="secondPizza"]').value;
      if (secondPizza !== "None") {
        let secondPizzaPrice = 350;
        const secondSize = document.querySelector('select[name="secondPizzaSize"]').value;
        if (secondSize === "Medium") secondPizzaPrice += 50;
        else if (secondSize === "Large") secondPizzaPrice += 100;
        secondPizzaPrice *= 0.9; // 10% discount
        total += secondPizzaPrice;
      }

      document.getElementById("totalPrice").innerText = "Total: " + total.toFixed(0) + " TL";
    }

    // Call updatePrice once on load
    window.onload = updatePrice;
  </script>
</body>
</html>
