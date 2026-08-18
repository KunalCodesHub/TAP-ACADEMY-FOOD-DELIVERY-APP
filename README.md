# 🍔 TAP Academy Food Delivery App

A full-stack Food Delivery Web Application built with **Java Servlets**, **JSP**, **MySQL**, and **Bootstrap**. Features complete customer ordering flow, admin dashboard, and Razorpay payment integration.

---

## ✨ Features

### 👤 Customer
- User registration & login with session management
- Browse restaurants and menus
- Add items to cart with quantity control
- Place orders with Cash on Delivery or Online Payment
- View order history and details
- Update profile information

### 🛠️ Admin
- Secure admin-only dashboard
- View dashboard statistics
- Manage all orders (update status)
- View all registered users
- View all restaurants

### 💳 Payment
- **Cash on Delivery (COD)** — instant order placement
- **Online Payment** — Razorpay integration (Test Mode)

---

## 🛠️ Tech Stack

| Layer         | Technology                          |
|---------------|-------------------------------------|
| Backend       | Java Servlets (Jakarta EE)          |
| Frontend      | JSP (Pure Scriptlets), HTML5, CSS3  |
| UI Framework  | Bootstrap 5.3.0                     |
| Database      | MySQL 8+                            |
| Server        | Apache Tomcat 10.1.52               |
| JDK           | Java 21                             |
| JSON Library  | Gson 2.10.1                         |
| Payment       | Razorpay REST API                   |

---

## 📂 Project Structure
<pre>
  TAP-ACADEMY-FOOD-DELIVERY-APP/
  ├── src/main/java/
  │ ├── dao/ # DAO interfaces
  │ │ └── impl/ # DAO implementations
  │ ├── entity/ # POJO entities
  │ ├── servlets/ # HTTP request handlers
  │ └── util/ # DBConnection utility
  ├── src/main/webapp/
  │ ├── admin/ # Admin panel JSPs
  │ ├── css/ # Stylesheets
  │ ├── js/ # JavaScript files
  │ ├── IMG/ # Static images
  │ ├── includes/ # Reusable header/footer
  │ ├── WEB-INF/
  │ │ ├── lib/ # JAR dependencies
  │ │ └── web.xml
  │ └── *.jsp # Customer-facing pages
  └── README.md
</pre>

---

## 🗄️ Database Schema

The application uses 5 core tables:
- `users` — customer & admin accounts
- `restaurants` — restaurant listings
- `menu` — food items per restaurant
- `orders` — order records
- `order_items` — items within each order

---

## ⚙️ Setup Instructions

### Prerequisites
- JDK 21
- Apache Tomcat 10.1.52
- MySQL 8+
- Eclipse IDE (Enterprise Edition)

### Installation

1. **Clone the repository**
```
  bash
  git clone https://github.com/KunalCodesHub/TAP-ACADEMY-FOOD-DELIVERY-APP.git
  ```
2. **Import into Eclipse**
  ```
  * File → Import → Existing Projects into Workspace
  * Select the cloned folder
  ```
3. **Create MySQL database**
  ```
  CREATE DATABASE deliveryapp;
  ```
4. **Configure database credentials**
  ```
  Open src/main/java/util/DBConnection.java
  Replace YOUR_DB_PASSWORD with your MySQL password
  ```
5. **Configure Razorpay (optional)**
  ```
  Open src/main/java/servlets/CreatePaymentOrderServlet.java
  Replace YOUR_RAZORPAY_KEY_ID and YOUR_RAZORPAY_KEY_SECRET with your keys from Razorpay Dashboard
  ```
6. **Deploy to Tomcat**
  ```
  Right-click project → Run As → Run on Server
  Select Apache Tomcat 10.1
  ```
7. **Access the app**
  ```
  http://localhost:8080/TAP-ACADEMY-FOOD-DELIVERY-APP/
  ```
### 🔐 Security Notes
- Never commit real database passwords or API keys
- Placeholder values are used in the repository
- Replace with actual credentials only in local environment

### 📸 Screenshots
Coming soon...

### 👨‍💻 Author
Kunal
GitHub: @KunalCodesHub

### 📝 License
This project is for educational purposes as part of the TAP Academy curriculum.
---

---

### To upload:
1. Go to your GitHub repo
2. Click **"Add file" → "Create new file"**
3. Name it `README.md`
4. Paste the entire content above
5. Scroll down → **Commit changes**

Or if you already have a `README.md`, click the pencil icon and replace everything with the above.

Tell me when done — then GitHub deployment is 100% complete and we can resume **Razorpay Step 4** whenever you're ready.
