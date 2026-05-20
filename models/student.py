"""
models/student.py
CRUD operations for the students table.
"""

from database.connection import Database


class StudentModel:

    # ── CREATE ────────────────────────────────────────────────────────────────
    @staticmethod
    def create(name, roll_no, email, phone, year, programme, domain,
               gpa=None, linkedin_url=None):
        sql = """
            INSERT INTO students
                (name, roll_no, email, phone, year, programme, domain, gpa, linkedin_url)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
        """
        cursor = Database.get_cursor()
        cursor.execute(sql, (name, roll_no, email, phone, year,
                             programme, domain, gpa, linkedin_url))
        Database.commit()
        return cursor.lastrowid

    # ── READ ──────────────────────────────────────────────────────────────────
    @staticmethod
    def get_all():
        cursor = Database.get_cursor()
        cursor.execute("SELECT * FROM students ORDER BY domain, year, name")
        return cursor.fetchall()

    @staticmethod
    def get_by_id(student_id):
        cursor = Database.get_cursor()
        cursor.execute("SELECT * FROM students WHERE id = %s", (student_id,))
        return cursor.fetchone()

    @staticmethod
    def get_by_domain(domain):
        cursor = Database.get_cursor()
        cursor.execute(
            "SELECT * FROM students WHERE domain = %s ORDER BY year, name",
            (domain,)
        )
        return cursor.fetchall()

    @staticmethod
    def search(keyword):
        cursor = Database.get_cursor()
        like = f"%{keyword}%"
        cursor.execute(
            """SELECT * FROM students
               WHERE name LIKE %s OR roll_no LIKE %s OR email LIKE %s""",
            (like, like, like)
        )
        return cursor.fetchall()

    @staticmethod
    def get_with_skills(student_id):
        cursor = Database.get_cursor()
        cursor.execute(
            """SELECT sk.skill_name FROM skills sk
               JOIN student_skills ss ON ss.skill_id = sk.id
               WHERE ss.student_id = %s""",
            (student_id,)
        )
        return [r["skill_name"] for r in cursor.fetchall()]

    @staticmethod
    def get_full_profile(student_id):
        """Return student dict + nested internships, certs, competitions."""
        student = StudentModel.get_by_id(student_id)
        if not student:
            return None
        cursor = Database.get_cursor()

        cursor.execute(
            "SELECT * FROM internships WHERE student_id = %s ORDER BY start_date DESC",
            (student_id,)
        )
        student["internships"] = cursor.fetchall()

        cursor.execute(
            "SELECT * FROM certifications WHERE student_id = %s ORDER BY issue_date DESC",
            (student_id,)
        )
        student["certifications"] = cursor.fetchall()

        cursor.execute(
            "SELECT * FROM competitions WHERE student_id = %s ORDER BY comp_date DESC",
            (student_id,)
        )
        student["competitions"] = cursor.fetchall()

        student["skills"] = StudentModel.get_with_skills(student_id)
        return student

    # ── UPDATE ────────────────────────────────────────────────────────────────
    @staticmethod
    def update(student_id, **kwargs):
        allowed = {"name", "email", "phone", "year", "programme",
                   "domain", "gpa", "linkedin_url", "placed", "placement_pkg"}
        fields = {k: v for k, v in kwargs.items() if k in allowed}
        if not fields:
            return 0
        set_clause = ", ".join(f"{k} = %s" for k in fields)
        values = list(fields.values()) + [student_id]
        cursor = Database.get_cursor()
        cursor.execute(
            f"UPDATE students SET {set_clause} WHERE id = %s", values
        )
        Database.commit()
        return cursor.rowcount

    @staticmethod
    def mark_placed(student_id, package_lpa):
        cursor = Database.get_cursor()
        cursor.execute(
            "UPDATE students SET placed = TRUE, placement_pkg = %s WHERE id = %s",
            (package_lpa, student_id)
        )
        Database.commit()
        return cursor.rowcount

    @staticmethod
    def add_skill(student_id, skill_name):
        cursor = Database.get_cursor()
        cursor.execute(
            "INSERT IGNORE INTO skills (skill_name) VALUES (%s)", (skill_name,)
        )
        cursor.execute("SELECT id FROM skills WHERE skill_name = %s", (skill_name,))
        skill_id = cursor.fetchone()["id"]
        cursor.execute(
            "INSERT IGNORE INTO student_skills (student_id, skill_id) VALUES (%s,%s)",
            (student_id, skill_id)
        )
        Database.commit()

    # ── DELETE ────────────────────────────────────────────────────────────────
    @staticmethod
    def delete(student_id):
        cursor = Database.get_cursor()
        cursor.execute("DELETE FROM students WHERE id = %s", (student_id,))
        Database.commit()
        return cursor.rowcount
