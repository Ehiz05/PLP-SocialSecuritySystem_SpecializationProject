from flask import Flask, request, jsonify
from flask_cors import CORS
import mysql.connector
import stripe

app = Flask(__name__)
CORS(app)

# Stripe API Configuration
stripe.api_key = "your_stripe_secret_key"

# Database Connection
db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="password",
    database="SocialSecuritySystem"
)
cursor = db.cursor(dictionary=True)

# User Registration
@app.route('/register', methods=['POST'])
def register():
    data = request.json
    query = "INSERT INTO Users (name, email, password, role) VALUES (%s, %s, %s, %s)"
    cursor.execute(query, (data['name'], data['email'], data['password'], data['role']))
    db.commit()
    return jsonify({"message": "User registered successfully!"}), 201

# User Login
@app.route('/login', methods=['POST'])
def login():
    data = request.json
    query = "SELECT * FROM Users WHERE email=%s AND password=%s"
    cursor.execute(query, (data['email'], data['password']))
    user = cursor.fetchone()
    if user:
        return jsonify({"user": user})
    return jsonify({"message": "Invalid credentials"}), 401

# Create Service Request
@app.route('/request-service', methods=['POST'])
def request_service():
    data = request.json
    query = "INSERT INTO Services (user_id, service_name) VALUES (%s, %s)"
    cursor.execute(query, (data['user_id'], data['service_name']))
    db.commit()
    return jsonify({"message": "Service requested successfully!"}), 201

# Get Transactions
@app.route('/transactions/<int:user_id>', methods=['GET'])
def get_transactions(user_id):
    query = "SELECT * FROM Transactions WHERE user_id=%s"
    cursor.execute(query, (user_id,))
    transactions = cursor.fetchall()
    return jsonify({"transactions": transactions})

# Make Payment
@app.route('/make-payment', methods=['POST'])
def make_payment():
    data = request.json
    try:
        # Stripe Payment
        charge = stripe.Charge.create(
            amount=int(data['amount'] * 100),  # Amount in cents
            currency="usd",
            source=data['token'],
            description=data['description']
        )

        # Insert into Transactions Table
        query = "INSERT INTO Transactions (user_id, amount, transaction_type, description) VALUES (%s, %s, 'debit', %s)"
        cursor.execute(query, (data['user_id'], data['amount'], data['description']))
        db.commit()

        # Update Balance
        query = "UPDATE Users SET balance = balance - %s WHERE id = %s"
        cursor.execute(query, (data['amount'], data['user_id']))
        db.commit()

        return jsonify({"message": "Payment successful!"})
    except Exception as e:
        return jsonify({"error": str(e)}), 400

if __name__ == '__main__':
    app.run(debug=True)
