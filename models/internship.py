"""
models/internship.py
CRUD for internships table.
"""

from database.connection import Database


class InternshipModel:

    @staticmethod
    def add(student_id, company_name, role, domain_type,
            start_date, end_date=None, stipend_pm=None, is_ppo=False, description=None):
        cursor = Database.get_cursor()
        cursor.execute(
            """INSERT INTO internships
               (student_id, company_name, role, domain_type,
                start_date, end_date, stipend_pm, is_ppo, description)
               VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s)""",
            (student_id, company_name, role, domain_type,
             start_date, end_date, stipend_pm, is_ppo, description)
        )
        Database.commit()
        return cursor.lastrowid

    @staticmethod
    def get_by_student(student_id):
        cursor = Database.get_cursor()
        cursor.execute(
            "SELECT * FROM internships WHERE student_id = %s ORDER BY start_date DESC",
            (student_id,)
        )
        return cursor.fetchall()

    @staticmethod
    def get_by_company(company_name):
        cursor = Database.get_cursor()
        cursor.execute(
            "SELECT i.*, s.name AS student_name, s.domain FROM internships i "
            "JOIN students s ON s.id = i.student_id "
            "WHERE i.company_name LIKE %s",
            (f"%{company_name}%",)
        )
        return cursor.fetchall()

    @staticmethod
    def get_ppo_list():
        cursor = Database.get_cursor()
        cursor.execute(
            """SELECT i.company_name, i.role, s.name, s.domain
               FROM internships i
               JOIN students s ON s.id = i.student_id
               WHERE i.is_ppo = TRUE
               ORDER BY i.company_name"""
        )
        return cursor.fetchall()

    @staticmethod
    def delete(internship_id):
        cursor = Database.get_cursor()
        cursor.execute("DELETE FROM internships WHERE id = %s", (internship_id,))
        Database.commit()
        return cursor.rowcount
