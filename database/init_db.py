"""
database/init_db.py
Creates the schema and seeds sample SRCC data.
Run once: python database/init_db.py
"""

import os
import mysql.connector
from dotenv import load_dotenv

load_dotenv()

# ── Schema SQL (inline so the file is self-contained) ────────────────────────
SCHEMA = open(os.path.join(os.path.dirname(__file__), "schema.sql")).read()

# ── Seed Data ─────────────────────────────────────────────────────────────────
SEED_STUDENTS = [
    ("Aarav Mehta",    "22BC001", "aarav@srcc.edu",   "9876543210", 2, "B.Com(H)",       "Consulting", 8.9,  "https://linkedin.com/in/aaravmehta",  False, None),
    ("Priya Sharma",   "22BC002", "priya@srcc.edu",   "9876543211", 2, "B.Com(H)",       "Finance",    9.1,  "https://linkedin.com/in/priyasharma", True,  14.5),
    ("Rohan Gupta",    "23BC003", "rohan@srcc.edu",   "9876543212", 1, "B.Com(H)",       "Marketing",  7.8,  None,                                  False, None),
    ("Sneha Iyer",     "21BC004", "sneha@srcc.edu",   "9876543213", 3, "B.Com(H)",       "Consulting", 9.3,  "https://linkedin.com/in/snehaiyer",   True,  18.0),
    ("Karan Verma",    "21BC005", "karan@srcc.edu",   "9876543214", 3, "B.Com",          "Finance",    8.4,  "https://linkedin.com/in/karanverma",  True,  12.0),
    ("Ananya Reddy",   "22BC006", "ananya@srcc.edu",  "9876543215", 2, "BA(H) Economics","Consulting", 8.7,  "https://linkedin.com/in/ananyareddy", False, None),
    ("Vikram Singh",   "23BC007", "vikram@srcc.edu",  "9876543216", 1, "B.Com(H)",       "Marketing",  7.5,  None,                                  False, None),
    ("Nisha Kapoor",   "21BC008", "nisha@srcc.edu",   "9876543217", 3, "M.Com",          "Finance",    9.6,  "https://linkedin.com/in/nishakapoor",  True,  22.0),
    ("Dev Malhotra",   "22BC009", "dev@srcc.edu",     "9876543218", 2, "B.Com(H)",       "Consulting", 8.2,  "https://linkedin.com/in/devmalhotra",  False, None),
    ("Tanya Bose",     "23BC010", "tanya@srcc.edu",   "9876543219", 1, "B.Com",          "Marketing",  8.0,  None,                                  False, None),
]

SEED_SKILLS = [
    "Excel", "PowerPoint", "Python", "SQL", "Financial Modelling",
    "Case Frameworks", "Market Research", "SEO", "Data Analysis",
    "Valuation", "Business Strategy", "Digital Marketing",
]

SEED_INTERNSHIPS = [
    (1, "McKinsey & Company", "Business Analyst Intern",   "Consulting", "2023-05-01", "2023-07-31", 80000, False),
    (2, "Goldman Sachs",      "Summer Analyst",            "Finance",    "2023-06-01", "2023-08-15", 90000, True),
    (3, "HUL",                "Marketing Intern",          "Marketing",  "2023-04-01", "2023-06-30", 25000, False),
    (4, "BCG",                "Consulting Intern",         "Consulting", "2022-05-01", "2022-07-31", 85000, True),
    (5, "ICICI Bank",         "Credit Analyst Intern",     "Finance",    "2022-06-01", "2022-08-31", 30000, False),
    (6, "Bain & Company",     "Associate Consultant Intern","Consulting","2023-05-15", "2023-07-15", 75000, False),
    (9, "Deloitte",           "Strategy Intern",           "Consulting", "2023-06-01", "2023-08-31", 60000, False),
]

SEED_CERTS = [
    (1, "CFA Level 1",          "CFA Institute",       "2023-01-15", None),
    (2, "CFA Level 2",          "CFA Institute",       "2023-06-10", None),
    (2, "Bloomberg Market Concepts", "Bloomberg",      "2022-09-01", None),
    (4, "Case Interview Prep",  "Coursera",            "2022-03-20", None),
    (5, "Financial Modelling",  "CFI",                 "2022-11-05", "2025-11-05"),
    (8, "CMA",                  "ICMAI",               "2023-04-18", None),
    (6, "Google Analytics",     "Google",              "2023-02-14", "2024-02-14"),
]

SEED_COMPETITIONS = [
    (4, "Consult Club IIM-A",    "IIM Ahmedabad", "Winner",      "2022-10-15", "Consulting"),
    (1, "BCG Strategy Challenge","BCG India",     "Finalist",    "2023-02-20", "Consulting"),
    (2, "NSE Stock Pitch",       "NSE India",     "Runner-up",   "2023-03-05", "Finance"),
    (3, "HUL L.I.M.E.",         "HUL",           "Participant",  "2023-01-20", "Marketing"),
    (8, "IIM Finance Conclave",  "IIM Calcutta",  "Winner",      "2022-11-30", "Finance"),
]


def run_schema(cursor):
    """Execute each statement in schema.sql individually."""
    # Split on semicolons, skip blank/comment-only chunks
    statements = [s.strip() for s in SCHEMA.split(";") if s.strip()]
    for stmt in statements:
        if stmt.upper().startswith("--") or not stmt:
            continue
        cursor.execute(stmt)
    print("  ✔  Schema created / updated.")


def seed(cursor, conn):
    # Students
    cursor.executemany(
        """INSERT IGNORE INTO students
           (name, roll_no, email, phone, year, programme, domain,
            gpa, linkedin_url, placed, placement_pkg)
           VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)""",
        SEED_STUDENTS,
    )
    print(f"  ✔  {cursor.rowcount} students inserted.")

    # Skills
    cursor.executemany(
        "INSERT IGNORE INTO skills (skill_name) VALUES (%s)",
        [(s,) for s in SEED_SKILLS],
    )

    # Student–skill links (simplified: student 1 gets first 4 skills, etc.)
    skill_map = {1: [1,2,6,9], 2: [1,2,5,10], 3: [3,7,11,12],
                 4: [2,6,9,11], 5: [1,5,8,10], 6: [6,9,11,3],
                 7: [7,12,3,4], 8: [1,5,10,4], 9: [6,9,3,8], 10: [7,11,12,3]}
    rows = [(sid, skid) for sid, skids in skill_map.items() for skid in skids]
    cursor.executemany(
        "INSERT IGNORE INTO student_skills (student_id, skill_id) VALUES (%s,%s)", rows
    )

    # Internships
    cursor.executemany(
        """INSERT IGNORE INTO internships
           (student_id, company_name, role, domain_type,
            start_date, end_date, stipend_pm, is_ppo)
           VALUES (%s,%s,%s,%s,%s,%s,%s,%s)""",
        SEED_INTERNSHIPS,
    )

    # Certifications
    cursor.executemany(
        """INSERT IGNORE INTO certifications
           (student_id, cert_name, issuing_body, issue_date, expiry_date)
           VALUES (%s,%s,%s,%s,%s)""",
        SEED_CERTS,
    )

    # Competitions
    cursor.executemany(
        """INSERT IGNORE INTO competitions
           (student_id, comp_name, organiser, result, comp_date, domain_type)
           VALUES (%s,%s,%s,%s,%s,%s)""",
        SEED_COMPETITIONS,
    )

    conn.commit()
    print("  ✔  Seed data inserted.")


def main():
    print("\n🏫  SRCC Student Tracker — Database Initialiser\n")
    cfg = {
        "host":     os.getenv("DB_HOST", "localhost"),
        "user":     os.getenv("DB_USER", "root"),
        "password": os.getenv("DB_PASSWORD", ""),
    }
    try:
        # Connect without specifying DB first (to create it)
        conn = mysql.connector.connect(**cfg)
        cursor = conn.cursor()
        cursor.execute(f"CREATE DATABASE IF NOT EXISTS {os.getenv('DB_NAME','srcc_tracker')} "
                       "CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci")
        cursor.execute(f"USE {os.getenv('DB_NAME','srcc_tracker')}")
        conn.commit()

        run_schema(cursor)
        seed(cursor, conn)
        print("\n✅  Database ready. Run:  python main.py\n")
    except Exception as e:
        print(f"\n❌  Init failed: {e}\n")
        raise
    finally:
        cursor.close()
        conn.close()


if __name__ == "__main__":
    main()
