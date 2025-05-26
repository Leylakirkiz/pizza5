<%
If Request.Form("submit") <> "" Then
    Dim phone, password
    phone = Request.Form("phone")
    password = Request.Form("password")

    ' Dummy login logic (you can expand this)
    If (phone = "0555-555-5555" And password = "1234") Or _
   (phone = "0544-444-4444" And password = "abcd") Then
    Session("loggedIn") = True
    Session("phone") = phone
    Response.Redirect "order.asp"
Else
    loginError = "Invalid phone number or password."
End If

End If
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Login</title>
  <style>
    body {
      font-family: 'Segoe UI', sans-serif;
      background: #f4f4f9;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }
    .login-box {
      background: white;
      padding: 40px;
      border-radius: 12px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.15);
      width: 350px;
    }
    h2 {
      text-align: center;
      margin-bottom: 25px;
      color: #d62828;
    }
    label, input {
      display: block;
      width: 100%;
      margin-bottom: 15px;
    }
    input[type="text"], input[type="password"] {
      padding: 10px;
      border: 1px solid #ccc;
      border-radius: 8px;
    }
    .submit-btn {
      background: #d62828;
      color: white;
      border: none;
      padding: 12px;
      border-radius: 8px;
      cursor: pointer;
      font-weight: bold;
      transition: background 0.3s;
    }
    .submit-btn:hover {
      background: #a61e1e;
    }
    .error {
      color: red;
      text-align: center;
    }
  </style>
</head>
<body>
  <div class="login-box">
    <h2>Pizza Login</h2>
    <% If errorMsg <> "" Then %>
      <div class="error"><%= errorMsg %></div>
    <% End If %>
    <form method="post">
      <label>Phone Number: 0555-555-5555</label>
      <input type="text" name="phone" placeholder="05XX-XXX-XXXX" required />

      <label>Password: 1234</label>
      <input type="password" name="password" required />

      <input type="submit" name="submit" value="Log In" class="submit-btn" />
    </form>
  </div>
</body>
</html>
