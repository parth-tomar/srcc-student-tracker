# SRCC Student Domain Tracker

A Python + MySQL system to track **SRCC (Shri Ram College of Commerce)** students pursuing **Consulting**, **Finance**, and **Marketing** domains — including their skills, internships, certifications, and placement status.

---

## Features

- Track students across 3 domains: **Consulting**, **Finance**, **Marketing**
- Store student profiles: year, GPA, skills, LinkedIn, email
- Log **internships** with company, role, duration, and stipend
- Record **certifications** (CFA, CMA, case prep, etc.)
- **Statistics dashboard**: domain-wise counts, top skills, placement rates
- Clean **CLI menu** for full CRUD operations
- **SQL views** for quick analytics queries

---

## Tech Stack

| Layer | Tech |
|---|---|
| Language | Python 3.10+ |
| Database | MySQL 8.0+ |
| ORM | Raw SQL via `mysql-connector-python` |
| Config | `.env` via `python-dotenv` |
| CLI | Rich (terminal UI) |

---

## Setup

### 1. Clone the repo
```bash
git clone https://github.com/yourusername/srcc-student-tracker.git
cd srcc-student-tracker
```

### 2. Install dependencies
```bash
pip install -r requirements.txt
```

### 3. Configure MySQL
Create a `.env` file in the root:
```
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=yourpassword
DB_NAME=srcc_tracker
```

### 4. Initialize the database
```bash
python database/init_db.py
```
This creates all tables, views, and seeds sample data.

### 5. Run the app
```bash
python main.py
```

---

## Project Structure

```
srcc_tracker/
├── main.py                  # Entry point & CLI menu
├── requirements.txt
├── .env.example
├── database/
│   ├── connection.py        # DB connection manager
│   ├── init_db.py           # Schema creation + seeder
│   └── schema.sql           # Full SQL schema
├── models/
│   ├── student.py           # Student CRUD
│   ├── internship.py        # Internship CRUD
│   └── certification.py     # Certification CRUD
├── views/
│   └── stats.py             # Analytics & reports
└── controllers/
    └── menu.py              # CLI controller
```

---

## Sample Queries

```sql
-- How many students per domain?
SELECT domain, COUNT(*) AS total FROM students GROUP BY domain;

-- Top companies hiring SRCC consultants
SELECT company_name, COUNT(*) FROM internships
JOIN students ON students.id = internships.student_id
WHERE students.domain = 'Consulting'
GROUP BY company_name ORDER BY COUNT(*) DESC;

-- Students with CFA certification
SELECT s.name, s.domain FROM students s
JOIN certifications c ON c.student_id = s.id
WHERE c.cert_name LIKE '%CFA%';
```

---

## Screenshots

> Note: All the data and information are hypothetical and do not represent any real person.
<img width="1351" height="366" alt="screenshot_1" src="https://github.com/user-attachments/assets/8be9e1c4-c573-4f47-846d-d51c4dc1b29a" />
<img width="1351" height="508" alt="screenshot_2" src="https://github.com/user-attachments/assets/88df795a-20c6-4296-8fb3-fb2c5e706a65" />
<img width="1357" height="511" alt="screenshot_3" src="https://github.com/user-attachments/assets/31d141cf-218b-4454-a340-5fd1c5658da1" />
<img width="808" height="421" alt="screenshot_4" src="https://github.com/user-attachments/assets/83575703-94bf-4d35-833a-99df68348b22" />

---

## Contributing

Pull requests welcome. For major changes, open an issue first.

---

## 📄 License

MIT
