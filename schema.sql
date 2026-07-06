-- ============================================
-- Employees Database Schema
-- ============================================

DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS titles;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

CREATE TABLE departments (
    dept_no     CHAR(4)      PRIMARY KEY,
    dept_name   VARCHAR(40)  NOT NULL UNIQUE
);

CREATE TABLE employees (
    emp_no      INTEGER      PRIMARY KEY,
    birth_date  DATE         NOT NULL,
    first_name  VARCHAR(20)  NOT NULL,
    last_name   VARCHAR(20)  NOT NULL,
    gender      CHAR(1)      NOT NULL CHECK (gender IN ('M','F')),
    hire_date   DATE         NOT NULL
);

CREATE TABLE dept_manager (
    emp_no      INTEGER      NOT NULL,
    dept_no     CHAR(4)      NOT NULL,
    from_date   DATE         NOT NULL,
    to_date     DATE         NOT NULL,
    FOREIGN KEY (emp_no)  REFERENCES employees (emp_no)  ON DELETE CASCADE,
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no) ON DELETE CASCADE,
    PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE dept_emp (
    emp_no      INTEGER      NOT NULL,
    dept_no     CHAR(4)      NOT NULL,
    from_date   DATE         NOT NULL,
    to_date     DATE         NOT NULL,
    FOREIGN KEY (emp_no)  REFERENCES employees (emp_no)  ON DELETE CASCADE,
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no) ON DELETE CASCADE,
    PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE titles (
    emp_no      INTEGER      NOT NULL,
    title       VARCHAR(50)  NOT NULL,
    from_date   DATE         NOT NULL,
    to_date     DATE,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no) ON DELETE CASCADE,
    PRIMARY KEY (emp_no, title, from_date)
);

CREATE TABLE salaries (
    emp_no      INTEGER      NOT NULL,
    salary      INTEGER      NOT NULL,
    from_date   DATE         NOT NULL,
    to_date     DATE         NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no) ON DELETE CASCADE,
    PRIMARY KEY (emp_no, from_date)
);

-- ============================================
-- Load data (run this file with psql -f, or run
-- the \copy commands below manually in psql)
-- Adjust the path to match where your CSVs live.
-- ============================================

\copy departments FROM 'data/departments.csv' WITH (FORMAT csv, HEADER true);
\copy employees FROM 'data/employees.csv' WITH (FORMAT csv, HEADER true);
\copy dept_manager FROM 'data/dept_manager.csv' WITH (FORMAT csv, HEADER true);
\copy dept_emp FROM 'data/dept_emp.csv' WITH (FORMAT csv, HEADER true);
\copy titles FROM 'data/titles.csv' WITH (FORMAT csv, HEADER true);
\copy salaries FROM 'data/salaries.csv' WITH (FORMAT csv, HEADER true);

-- ============================================
-- Sanity check
-- ============================================
SELECT 'departments' AS table_name, COUNT(*) FROM departments
UNION ALL SELECT 'employees', COUNT(*) FROM employees
UNION ALL SELECT 'dept_manager', COUNT(*) FROM dept_manager
UNION ALL SELECT 'dept_emp', COUNT(*) FROM dept_emp
UNION ALL SELECT 'titles', COUNT(*) FROM titles
UNION ALL SELECT 'salaries', COUNT(*) FROM salaries;
