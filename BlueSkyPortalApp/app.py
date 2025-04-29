from flask import Flask, render_template, request, redirect, url_for, session
import pyodbc
import bcrypt

app = Flask(__name__)
app.secret_key = 'BlueSky_Portal_Application'  # Set a secure secret key!

# Database connection
def get_db_connection():
    conn = pyodbc.connect(
        'DRIVER={ODBC Driver 17 for SQL Server};'
        'SERVER=GAMINGPC;'
        'DATABASE=BlueSkyPortal;'
        'Trusted_Connection=yes;'
    )
    return conn

# Route: Login Page
@app.route('/', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        email = request.form['email']
        password = request.form['password'].encode('utf-8')

        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT Id, PasswordHash, FullName FROM Users WHERE Email = ?", email)
        user = cursor.fetchone()

        if user and bcrypt.checkpw(password, user.PasswordHash.encode('utf-8')):
            session['user_id'] = user.Id
            session['user_name'] = user.FullName
            return redirect(url_for('dashboard'))
        else:
            return render_template('login.html', error="Invalid email or password.")

    return render_template('login.html')

# Route: Dashboard Page
@app.route('/dashboard')
def dashboard():
    if 'user_id' not in session:
        return redirect(url_for('login'))

    user_id = session['user_id']

    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT GradYear, GPA, ACTScore, ApplicationStatus FROM Applications WHERE UserId = ?", user_id)
    application = cursor.fetchone()

    return render_template('dashboard.html', name=session['user_name'], application=application)

# Route: Logout
@app.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('login'))

if __name__ == '__main__':
    app.run(debug=True)
