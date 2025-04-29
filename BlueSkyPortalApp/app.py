from flask import Flask, render_template, request, redirect, url_for, session
import psycopg2
import bcrypt

app = Flask(__name__)
app.secret_key = 'BlueSky_Portal_Application'  # Set a secure secret key!

# Database connection
def get_db_connection():
    conn = psycopg2.connect(
        host="dpg-d083pes9c44c73bg9vu0-a.virginia-postgres.render.com",
        database="bluesky_portal_db",
        user="bluesky_portal_db_user",
        password="oSHzbsY0i15XuypJwin5bMxoCEdLBKC7",
        port=5432,
        sslmode='require'
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
        cursor.execute('SELECT * FROM "Users" WHERE "Email" = %s', (email,))
        user = cursor.fetchone()
        conn.close()

        if user and bcrypt.checkpw(password, user[2].encode('utf-8')):  # user[2] is PasswordHash
            session['user_id'] = user[0]  # user[0] is Id
            session['user_name'] = user[3]  # user[3] is FullName
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
    cursor.execute('SELECT "GradYear", "GPA", "ACTScore", "ApplicationStatus" FROM "Applications" WHERE "UserId" = %s', (user_id,))
    application = cursor.fetchone()
    conn.close()

    return render_template('dashboard.html', name=session['user_name'], application=application)

# Route: Logout
@app.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('login'))

if __name__ == "__main__":
    from os import environ
    port = int(environ.get("PORT", 5000))
    app.run(host="0.0.0.0", port=port)
