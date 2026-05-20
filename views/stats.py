"""
views/stats.py
Analytics queries — domain counts, placement stats, leaderboards.
"""

from database.connection import Database


class StatsView:

    @staticmethod
    def domain_summary():
        """How many students per domain, placed count, avg GPA."""
        cursor = Database.get_cursor()
        cursor.execute("SELECT * FROM v_domain_count")
        return cursor.fetchall()

    @staticmethod
    def year_breakdown():
        cursor = Database.get_cursor()
        cursor.execute("SELECT * FROM v_year_breakdown")
        return cursor.fetchall()

    @staticmethod
    def top_companies():
        cursor = Database.get_cursor()
        cursor.execute("SELECT * FROM v_top_companies LIMIT 20")
        return cursor.fetchall()

    @staticmethod
    def cert_leaders():
        cursor = Database.get_cursor()
        cursor.execute("SELECT * FROM v_cert_leaders LIMIT 10")
        return cursor.fetchall()

    @staticmethod
    def competition_winners():
        cursor = Database.get_cursor()
        cursor.execute("SELECT * FROM v_competition_winners")
        return cursor.fetchall()

    @staticmethod
    def placement_stats():
        cursor = Database.get_cursor()
        cursor.execute(
            """SELECT domain,
                      COUNT(*) AS total,
                      SUM(placed) AS placed,
                      ROUND(100.0 * SUM(placed) / COUNT(*), 1) AS pct,
                      ROUND(AVG(CASE WHEN placed THEN placement_pkg END), 2) AS avg_pkg_lpa,
                      MAX(placement_pkg) AS max_pkg_lpa
               FROM students
               GROUP BY domain"""
        )
        return cursor.fetchall()

    @staticmethod
    def top_skills_per_domain():
        cursor = Database.get_cursor()
        cursor.execute(
            """SELECT s.domain, sk.skill_name, COUNT(*) AS cnt
               FROM student_skills ss
               JOIN students s  ON s.id  = ss.student_id
               JOIN skills   sk ON sk.id = ss.skill_id
               GROUP BY s.domain, sk.skill_name
               ORDER BY s.domain, cnt DESC"""
        )
        rows = cursor.fetchall()
        result = {}
        for r in rows:
            result.setdefault(r["domain"], []).append(
                {"skill": r["skill_name"], "count": r["cnt"]}
            )
        return result

    @staticmethod
    def overview_counts():
        cursor = Database.get_cursor()
        cursor.execute(
            """SELECT
                 COUNT(*) AS total_students,
                 SUM(domain='Consulting') AS consulting,
                 SUM(domain='Finance')    AS finance,
                 SUM(domain='Marketing')  AS marketing,
                 SUM(placed)              AS total_placed
               FROM students"""
        )
        return cursor.fetchone()
