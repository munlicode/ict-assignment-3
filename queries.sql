-- ============================================================
-- QUERY 1: INSERT
-- Purpose: Registers a new library member (Aliya Bekova, Humanities).
--          All NOT NULL columns are filled, and the email must be UNIQUE.
-- Result:  1 row inserted. Members table: 20 -> 21 records.
-- ============================================================
INSERT INTO members (id, full_name, email, faculty, member_type, join_date, password_hash) VALUES ('10000000-0000-4000-8000-000000000009', 'Aliya Bekova', 'a.bekova@university.example', 'Humanities', 'Student', '2026-10-20', 'hash_demo_m009');

-- ============================================================
-- QUERY 2: Basic SELECT
-- Purpose: Lists all registered members with their contact and type details.
--          password_hash is left out on purpose (sensitive data).
-- Result:  21 rows (after Query 1). First 5 shown:
-- ============================================================
SELECT full_name, email, faculty, member_type FROM members;
-- | full_name         | email                          | faculty          | member_type |
-- |-------------------|--------------------------------|------------------|-------------|
-- | Aruzhan Sarsenova | a.sarsenova@university.example | Computer Science | Student     |
-- | Timur Bekov       | t.bekov@university.example     | Computer Science | Student     |
-- | Alina Kassymova   | a.kassymova@university.example | Mathematics      | Student     |
-- | Nurlan Dauletov   | n.dauletov@university.example  | Humanities       | Student     |
-- | Madi Seitkali     | m.seitkali@university.example  | Engineering      | Student     |
-- ... (21 rows in total, first 5 shown)

-- ============================================================
-- QUERY 3: SELECT with WHERE
-- Purpose: Finds only the students of the Computer Science faculty
--          (filter with two conditions combined by AND).
-- Result:  4 rows.
-- ============================================================
SELECT full_name, faculty, join_date FROM members WHERE member_type = 'Student' AND faculty = 'Computer Science';
-- | full_name           | faculty          | join_date  |
-- |---------------------|------------------|------------|
-- | Aruzhan Sarsenova   | Computer Science | 2025-09-01 |
-- | Timur Bekov         | Computer Science | 2025-09-01 |
-- | Bota Zhunusova      | Computer Science | 2025-09-01 |
-- | Ruslan Abdrakhmanov | Computer Science | 2026-09-01 |
-- (4 rows)

-- ============================================================
-- QUERY 4: JOIN (loans + members + books + staff)
-- Purpose: Shows who currently holds which book and which librarian
--          processed the loan. Loans stores only IDs, so the JOINs follow
--          the foreign keys to get names and titles. return_date IS NULL
--          means the book has not been returned yet.
-- Result:  13 open loans, ordered by due date. First 5 shown:
-- ============================================================
SELECT 
    m.full_name AS member, 
    b.title AS book, 
    l.due_date, 
    s.full_name AS processed_by 
FROM loans l 
JOIN members m ON l.member_id = m.id
JOIN books b ON l.book_id = b.book_id
JOIN staff s ON l.staff_id = s.staff_id
WHERE l.return_date IS NULL
ORDER BY l.due_date;
-- | member             | book                                | due_date   | processed_by      |
-- |--------------------|-------------------------------------|------------|-------------------|
-- | Madi Seitkali      | Engineering Mechanics               | 2026-10-09 | Zhanna Tleuova    |
-- | Dana Ismailova     | Linear Algebra and Its Applications | 2026-10-12 | Zhanna Tleuova    |
-- | Yerzhan Kaliyev    | Calculus                            | 2026-10-15 | Zhanna Tleuova    |
-- | Laura Mukhametova  | Crime and Punishment                | 2026-10-16 | Saule Nurgaliyeva |
-- | Dr. Erlan Zhakupov | Database System Concepts            | 2026-10-19 | Saule Nurgaliyeva |
-- ... (13 rows in total, first 5 shown)

-- ============================================================
-- QUERY 5: UPDATE
-- Purpose: Changes a member's email (members may modify their own contact
--          details). The WHERE clause limits the change to one row;
--          without it, every member's email would be overwritten.
-- Result:  1 row updated. Aruzhan Sarsenova's email is now
--          aruzhan.sarsenova@university.example
-- ============================================================
UPDATE members SET email = 'aruzhan.sarsenova@university.example' WHERE id = '10000000-0000-4000-8000-000000000001';
