-- ============================================================
--  SRCC Student Domain Tracker — Database Schema
--  MySQL 8.0+
-- ============================================================

CREATE DATABASE IF NOT EXISTS srcc_tracker
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE srcc_tracker;

-- ------------------------------------------------------------
-- STUDENTS
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS students (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    name            VARCHAR(100)    NOT NULL,
    roll_no         VARCHAR(20)     UNIQUE NOT NULL,
    email           VARCHAR(120)    UNIQUE NOT NULL,
    phone           VARCHAR(15),
    year            TINYINT         NOT NULL COMMENT '1=First, 2=Second, 3=Third',
    programme       ENUM('B.Com(H)', 'B.Com', 'BA(H) Economics', 'M.Com') NOT NULL,
    domain          ENUM('Consulting', 'Finance', 'Marketing') NOT NULL,
    gpa             DECIMAL(4,2)    CHECK (gpa BETWEEN 0.00 AND 10.00),
    linkedin_url    VARCHAR(255),
    placed          BOOLEAN         DEFAULT FALSE,
    placement_pkg   DECIMAL(10,2)   COMMENT 'Annual CTC in LPA',
    created_at      TIMESTAMP       DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP       DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ------------------------------------------------------------
-- SKILLS  (many-to-many via junction)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS skills (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    skill_name  VARCHAR(80) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS student_skills (
    student_id  INT NOT NULL,
    skill_id    INT NOT NULL,
    PRIMARY KEY (student_id, skill_id),
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
    FOREIGN KEY (skill_id)   REFERENCES skills(id)   ON DELETE CASCADE
);

-- ------------------------------------------------------------
-- INTERNSHIPS
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS internships (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    student_id      INT             NOT NULL,
    company_name    VARCHAR(120)    NOT NULL,
    role            VARCHAR(100)    NOT NULL,
    domain_type     ENUM('Consulting', 'Finance', 'Marketing', 'Other') NOT NULL,
    start_date      DATE            NOT NULL,
    end_date        DATE,
    stipend_pm      DECIMAL(8,2)    COMMENT 'Monthly stipend in INR',
    is_ppo          BOOLEAN         DEFAULT FALSE COMMENT 'Pre-placement offer received',
    description     TEXT,
    created_at      TIMESTAMP       DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE
);

-- ------------------------------------------------------------
-- CERTIFICATIONS
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS certifications (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    student_id      INT             NOT NULL,
    cert_name       VARCHAR(150)    NOT NULL,
    issuing_body    VARCHAR(100),
    issue_date      DATE,
    expiry_date     DATE,
    cert_url        VARCHAR(255),
    created_at      TIMESTAMP       DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE
);

-- ------------------------------------------------------------
-- COMPETITIONS / CASE CHALLENGES
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS competitions (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    student_id      INT             NOT NULL,
    comp_name       VARCHAR(150)    NOT NULL,
    organiser       VARCHAR(100),
    result          ENUM('Winner','Runner-up','Finalist','Participant') NOT NULL,
    comp_date       DATE,
    domain_type     ENUM('Consulting', 'Finance', 'Marketing', 'General'),
    created_at      TIMESTAMP       DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE
);

-- ============================================================
--  VIEWS  — analytics helpers
-- ============================================================

-- Domain head-count
CREATE OR REPLACE VIEW v_domain_count AS
    SELECT domain, COUNT(*) AS total_students,
           SUM(placed) AS placed_count,
           ROUND(AVG(gpa), 2) AS avg_gpa
    FROM students
    GROUP BY domain;

-- Year-wise breakdown
CREATE OR REPLACE VIEW v_year_breakdown AS
    SELECT year, domain, COUNT(*) AS total
    FROM students
    GROUP BY year, domain
    ORDER BY year, domain;

-- Top internship companies per domain
CREATE OR REPLACE VIEW v_top_companies AS
    SELECT i.domain_type, i.company_name, COUNT(*) AS intern_count,
           SUM(i.is_ppo) AS ppo_count
    FROM internships i
    GROUP BY i.domain_type, i.company_name
    ORDER BY i.domain_type, intern_count DESC;

-- Students with most certifications
CREATE OR REPLACE VIEW v_cert_leaders AS
    SELECT s.name, s.roll_no, s.domain, COUNT(c.id) AS cert_count
    FROM students s
    LEFT JOIN certifications c ON c.student_id = s.id
    GROUP BY s.id
    ORDER BY cert_count DESC;

-- Competition winners
CREATE OR REPLACE VIEW v_competition_winners AS
    SELECT s.name, s.domain, comp.comp_name, comp.organiser,
           comp.result, comp.comp_date
    FROM competitions comp
    JOIN students s ON s.id = comp.student_id
    WHERE comp.result IN ('Winner', 'Runner-up')
    ORDER BY comp.comp_date DESC;
