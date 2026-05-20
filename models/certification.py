"""
models/certification.py
CRUD for certifications table.
"""

from database.connection import Database


class CertificationModel:

    @staticmethod
    def add(student_id, cert_name, issuing_body=None,
            issue_date=None, expiry_date=None, cert_url=None):
        cursor = Database.get_cursor()
        cursor.execute(
            """INSERT INTO certifications
               (student_id, cert_name, issuing_body, issue_date, expiry_date, cert_url)
               VALUES (%s,%s,%s,%s,%s,%s)""",
            (student_id, cert_name, issuing_body, issue_date, expiry_date, cert_url)
        )
        Database.commit()
        return cursor.lastrowid

    @staticmethod
    def get_by_student(student_id):
        cursor = Database.get_cursor()
        cursor.execute(
            "SELECT * FROM certifications WHERE student_id = %s ORDER BY issue_date DESC",
            (student_id,)
        )
        return cursor.fetchall()

    @staticmethod
    def get_by_cert_name(cert_name):
        cursor = Database.get_cursor()
        cursor.execute(
            """SELECT c.*, s.name AS student_name, s.domain
               FROM certifications c
               JOIN students s ON s.id = c.student_id
               WHERE c.cert_name LIKE %s""",
            (f"%{cert_name}%",)
        )
        return cursor.fetchall()

    @staticmethod
    def delete(cert_id):
        cursor = Database.get_cursor()
        cursor.execute("DELETE FROM certifications WHERE id = %s", (cert_id,))
        Database.commit()
        return cursor.rowcount
