
CREATE DATABASE Special_School
USE Special_School

-- (טבלת משתמשים (הורים / מנהלים
CREATE TABLE Users
(
 u_id INT IDENTITY(1,1) PRIMARY KEY, -- קוד משתמש ייחודי לכל משתמש
 u_email VARCHAR(100) UNIQUE NOT NULL, -- אימייל להתחברות
 -- יש לבצע גיבוב (hashing) לסיסמאות במערכות אמיתיות
 u_password VARCHAR(100) NOT NULL, -- סיסמה
 u_phone VARCHAR(20), -- טלפון
 u_role VARCHAR(20) NOT NULL, -- סוג משתמש (Parent / Admin)
 created_at DATETIME DEFAULT GETDATE() -- תאריך יצירת חשבון
)

INSERT INTO Users VALUES
('parent1@gmail.com','1234','0501111111','Parent',GETDATE()), -- הורה 1
('parent2@gmail.com','1234','0502222222','Parent',GETDATE()), -- הורה 2
('parent3@gmail.com','1234','0503333333','Parent',GETDATE()), -- הורה 3
('parent4@gmail.com','1234','0504444444','Parent',GETDATE()), -- הורה 4
('parent5@gmail.com','1234','0505555555','Parent',GETDATE()), -- הורה 5
('parent6@gmail.com','1234','0506666666','Parent',GETDATE()), -- הורה 6
('parent7@gmail.com','1234','0507777777','Parent',GETDATE()), -- הורה 7
('parent8@gmail.com','1234','0508888888','Parent',GETDATE()), -- הורה 8
('parent9@gmail.com','1234','0509999999','Parent',GETDATE()), -- הורה 9
('admin@gmail.com','admin123','0510000000','Admin',GETDATE()) -- מנהל


-- רמות תפקודיות
CREATE TABLE Levels
(
 level_code INT IDENTITY(1,1) PRIMARY KEY, -- קוד רמה
 l_type VARCHAR(50) NOT NULL UNIQUE -- שם הרמה
)

INSERT INTO Levels VALUES
('Needs Support'), -- צריך עזרה רבה
('Partially Independent'), -- עצמאות חלקית
('Independent') -- עצמאי


-- תלמידים
CREATE TABLE Students
(
 student_id INT IDENTITY(1,1) PRIMARY KEY, -- קוד תלמיד
 s_first_name VARCHAR(25) NOT NULL, -- שם פרטי
 s_last_name VARCHAR(25) NOT NULL, -- שם משפחה
 s_level_code INT FOREIGN KEY REFERENCES Levels(level_code), -- רמה תפקודית
 s_u_id INT FOREIGN KEY REFERENCES Users(u_id), -- לאיזה הורה שייך
 s_want_volunteer BIT DEFAULT 0 -- האם רוצה מתנדב
)

INSERT INTO Students VALUES
('Noa','Levi',1,1,1),    -- תלמידה עם צורך בעזרה רבה + רוצה מתנדב
('Rivka','Kohen',2,2,0), -- עצמאות חלקית + לא רוצה מתנדב
('Yael','Mizrahi',3,3,1), -- תלמידה עצמאית + רוצה מתנדב
('Tamar','David',2,4,1), -- עצמאות חלקית + רוצה מתנדב
('Leah','Ben-Ami',1,5,0), -- צורך בעזרה רבה + לא רוצה מתנדב
('Miriam','Katz',3,6,1), -- עצמאית + רוצה מתנדב
('Hadas','Levi',2,7,0), -- עצמאות חלקית + לא רוצה מתנדב
('Sarah','Goldberg',3,8,1), -- עצמאית + רוצה מתנדב
('Esther','Cohen',1,9,1), -- צורך בעזרה רבה + רוצה מתנדב
('Rachel','David',2,4,1) -- עצמאות חלקית + רוצה מתנדב


-- מקצועות
CREATE TABLE Professions
(
 profession_id INT IDENTITY(1,1) PRIMARY KEY, -- קוד מקצוע
 p_name VARCHAR(50) NOT NULL UNIQUE-- שם מקצוע
)

INSERT INTO Professions VALUES
('Reading'), -- קריאה
('Writing'), -- כתיבה
('Math'), -- חשבון
('English'), -- אנגלית
('Listening Comprehension'), -- הבנת הנשמע
('Reading Comprehension') -- הבנת הנקרא


-- (שיעורים (מקצוע + רמה
CREATE TABLE Lessons
(
 lesson_id INT IDENTITY(1,1) PRIMARY KEY, -- קוד שיעור
 l_profession_id INT FOREIGN KEY REFERENCES Professions(profession_id), -- מקצוע
 l_level_code INT FOREIGN KEY REFERENCES Levels(level_code), -- רמה
 lesson_topic VARCHAR(200) NOT NULL -- נושא
)

INSERT INTO Lessons VALUES
-- מקצוע: Reading (קריאה)
(1,1,'Recognizing Letters'),    -- רמה Needs Support – זיהוי אותיות בסיסי
(1,2,'Reading Words'),          -- רמה Partially Independent – קריאת מילים
(1,3,'Reading Stories'),        -- רמה Independent – קריאת סיפורים

-- מקצוע: Writing (כתיבה)
(2,1,'Letter Tracing'),         -- רמה Needs Support – עקיבת אותיות
(2,2,'Writing Words'),          -- רמה Partially Independent – כתיבת מילים
(2,3,'Writing Sentences'),      -- רמה Independent – כתיבת משפטים

-- מקצוע: Math (חשבון)
(3,1,'Counting Numbers'),       -- רמה Needs Support – ספירה בסיסית
(3,2,'Addition'),               -- רמה Partially Independent – חיבור
(3,3,'Multiplication'),         -- רמה Independent – כפל

-- מקצוע: English (אנגלית)
(4,1,'Recognizing Letters'),    -- רמה Needs Support – זיהוי אותיות
(4,2,'Basic Vocabulary'),       -- רמה Partially Independent – אוצר מילים בסיסי
(4,3,'Simple Sentences'),       -- רמה Independent – משפטים פשוטים

-- מקצוע: Listening Comprehension (הבנת הנשמע)
(5,1,'Listening to Words'),     -- רמה Needs Support – הקשבה למילים
(5,2,'Listening to Short Stories'), -- רמה Partially Independent – הקשבה לסיפורים קצרים
(5,3,'Answering Questions'),    -- רמה Independent – מענה על שאלות

-- מקצוע: Reading Comprehension (הבנת הנקרא)
(6,1,'Read Simple Sentences'),  -- רמה Needs Support – קריאה פשוטה
(6,2,'Read Paragraphs'),        -- רמה Partially Independent – קריאת פסקאות
(6,3,'Analyze Texts')           -- רמה Independent – ניתוח טקסטים



-- התקדמות תלמידים
CREATE TABLE Student_Progress
(
 progress_id INT IDENTITY(1001,1) PRIMARY KEY,             -- קוד התקדמות
 sp_student_id INT FOREIGN KEY REFERENCES Students(student_id), -- תלמיד
 sp_lesson_id INT FOREIGN KEY REFERENCES Lessons(lesson_id),     -- שיעור
 sp_status VARCHAR(20) CHECK (sp_status IN ('Not Started','In Progress','Completed')),  -- מצב התקדמות: Not Started/ In Progress / Completed
 sp_score INT,    -- ציון שהושג בשיעור
 sp_last_update DATETIME DEFAULT GETDATE()    -- עדכון אחרון
)

INSERT INTO Student_Progress VALUES
(1,1,'Completed',90,GETDATE()),     -- השיעור הושלם בהצלחה ציון 90
(1,2,'Not Started',NULL,GETDATE()), -- לא התחיל שיעור-אין ציון
(2,3,'In Progress',85,GETDATE()),   -- נמצא בתהליך השיעור ציון 85
(3,4,'Not Started',NULL,GETDATE()), -- לא התחיל שיעור-אין ציון
(4,5,'Completed',95,GETDATE()),     -- השיעור הושלם בהצלחה ציון 95
(5,6,'In Progress',NULL,GETDATE()), -- נמצא בתהליך השיעור אין ציון
(6,7,'Completed',80,GETDATE()),     -- השיעור הושלם בהצלחה ציון 80
(7,8,'Completed',88,GETDATE()),     -- השיעור הושלם בהצלחה ציון 88
(8,9,'Not Started',NULL,GETDATE()), -- לא התחיל שיעור-אין ציון
(9,10,'Completed',92,GETDATE());    -- השיעור הושלם בהצלחה ציון 92

-- הזמנות 
CREATE TABLE Orders
(
 order_id INT IDENTITY(1,1) PRIMARY KEY,   -- קוד הזמנה ייחודי
 o_user_id INT FOREIGN KEY REFERENCES Users(u_id), -- (מי ביצע את ההזמנה (הורה
 o_student_id INT FOREIGN KEY REFERENCES Students(student_id), -- עבור איזה תלמיד
 o_date DATETIME DEFAULT GETDATE()             -- תאריך ההזמנה
)

INSERT INTO Orders VALUES
(1,1,GETDATE()),  -- הורה 1 (parent1@gmail.com) קנה מקצוע עבור Noa Levi
(2,2,GETDATE()),  -- הורה 2 (parent2@gmail.com) קנה מקצוע עבור Rivka Kohen
(3,3,GETDATE()),  -- הורה 3 (parent3@gmail.com) קנה מקצוע עבור Yael Mizrahi
(4,4,GETDATE()),  -- הורה 4 (parent4@gmail.com) קנה מקצוע עבור Tamar David
(5,5,GETDATE()),  -- הורה 5 (parent5@gmail.com) קנה מקצוע עבור Leah Ben-Ami
(6,6,GETDATE()),  -- הורה 6 (parent6@gmail.com) קנה מקצוע עבור Miriam Katz
(7,7,GETDATE()),  -- הורה 7 (parent7@gmail.com) קנה מקצוע עבור Hadas Levi
(8,8,GETDATE()),  -- הורה 8 (parent8@gmail.com) קנה מקצוע עבור Sarah Goldberg
(4,10,GETDATE())  -- הורה 4 (parent4@gmail.com) קנה מקצוע עבור Rachel David


-- פירוט הזמנה / Order Details
CREATE TABLE Order_Items
(
 order_item_id INT IDENTITY(1,1) PRIMARY KEY, -- קוד פריט 
 oi_order_id INT FOREIGN KEY REFERENCES Orders(order_id), -- מזהה הזמנה 
 oi_profession_id INT FOREIGN KEY REFERENCES Professions(profession_id) -- מקצוע שנרכש 
)

INSERT INTO Order_Items VALUES
(1,1), -- קנו קריאה / Reading
(2,3), -- קנו חשבון / Math
(3,2), -- קנו קריאה / Reading
(4,4), -- קנו אנגלית / English
(5,5), -- קנו הבנת הנשמע / Listening Comprehension
(6,6), -- קנו הבנת הנקרא / Reading Comprehension
(7,1), -- קנו קריאה / Reading
(8,3), -- קנו חשבון / Math
(9,2)  -- קנו כתיבה / Writing



-- טבלת מתנדבים / Volunteers Table
CREATE TABLE Volunteers
(
 volunteer_id INT IDENTITY(1,1) PRIMARY KEY, -- קוד מתנדב 
 v_first_name VARCHAR(25), -- שם פרטי 
 v_last_name VARCHAR(25), -- שם משפחה 
 v_age INT CHECK ( v_age >= 16) -- גיל מינימלי 16 
)

INSERT INTO Volunteers VALUES
('David','Cohen',18), -- מתנדב צעיר
('Moshe','Biton',30), -- מתנדב מנוסה
('Yaakov','Shapira',25), -- מתנדב
('Rina','Goldberg',17), -- מתנדבת צעירה
('Sara','Goldberg',22), -- מתנדבת
('Miriam','Katz',28), -- מתנדבת 
('Eli','Moshe',35), -- מתנדב
('Hannah','Cohen',20) -- מתנדבת עם 2 התנדבויות


-- טבלת שיבוץ מתנדבים
CREATE TABLE Volunteering
(
 volunteering_id INT IDENTITY(1,1) PRIMARY KEY, -- קוד ייחודי לכל שיבוץ 
 v_volunteer_id INT FOREIGN KEY REFERENCES Volunteers(volunteer_id), -- מזהה המתנדב/ת
 v_student_id INT FOREIGN KEY REFERENCES Students(student_id), -- מזהה התלמיד/ה שמקבל את המתנדב
 v_volunteer_date DATE NOT NULL, -- תאריך שבו המתנדב/ת מגיע/ה
 v_status VARCHAR(20) DEFAULT 'execute'   --  (execute)שובץ / בוצע(assigned) 
)

INSERT INTO Volunteering VALUES
(1,1,'2026-05-31','assigned'),  -- נועה לוי שובץ לה המתנדב דוד כהן
(2,3,'2026-05-01','assigned'),  -- יעל מזרחי שובץ לה המתנדב משה ביטון
(3,4,'2026-02-02',DEFAULT),     -- לתמר דוד בוצע ההתנדבות עם יעקוב שפירא
(4,9,'2026-06-03','assigned'),  -- לאסתר כהן שובצה לה המתנדבת רינה גולדברג
(5,6,'2026-04-03',DEFAULT),     -- למרים כץ שובץ המתנדב אלי משה
(6,10,'2026-03-04',DEFAULT),    --  רחל דוד שובצה לה המתנדבת חנה כהן
(6,8,'2026-04-24','assigned')   -- שרה גולדברג שובצה לה המתנדבת חנה כהן


-- מניעת התנגשויות
CREATE UNIQUE INDEX idx_volunteer_schedule
ON Volunteering(v_volunteer_id, v_volunteer_date) -- יצירת אינדקס ייחודי על המתנדב ותאריך ההתנדבות 
                                              -- מונע מצב שבו מתנדב/ת שובץ/ה לשני תלמידים באותו יום


-- שאילתות
-- 1. תלמידים עם הכי הרבה שיעורים שהושלמו
SELECT S.s_first_name, S.s_last_name, COUNT(*) AS completed_lessons
FROM Students S
JOIN Student_Progress SP ON S.student_id = SP.sp_student_id
WHERE SP.sp_status = 'Completed'
GROUP BY S.s_first_name, S.s_last_name
ORDER BY completed_lessons DESC


-- 2. מתנדבים שמשובצים ליותר מתלמיד אחד
SELECT V.v_first_name, V.v_last_name, COUNT(*) AS num_students
FROM Volunteers V
JOIN Volunteering Vol ON V.volunteer_id = Vol.v_volunteer_id
GROUP BY V.v_first_name, V.v_last_name
HAVING COUNT(*) > 1


-- 3. המקצועות הנרכשים ביותר לפי כמות הזמנות
SELECT P.p_name, COUNT(*) AS times_purchased
FROM Order_Items OI
JOIN Professions P ON OI.oi_profession_id = P.profession_id
GROUP BY P.p_name
ORDER BY times_purchased DESC


-- 4. תלמידים עם ציון מעל 85, ממוין מהגבוה לנמוך
SELECT S.s_first_name, S.s_last_name, L.lesson_topic, SP.sp_score
FROM Students S
JOIN Student_Progress SP ON S.student_id = SP.sp_student_id
JOIN Lessons L ON SP.sp_lesson_id = L.lesson_id
WHERE SP.sp_score > 85
ORDER BY SP.sp_score DESC


-- 5. כמה תלמידים יש בכל רמה תפקודית
SELECT L.l_type, COUNT(*) AS num_students
FROM Students S
JOIN Levels L ON S.s_level_code = L.level_code
GROUP BY L.l_type


-- 6. הורים שעדיין לא ביצעו אף הזמנה
SELECT U.u_email, U.u_phone
FROM Users U
WHERE U.u_role = 'Parent'
AND U.u_id NOT IN (SELECT o_user_id FROM Orders)


-- 7. מתנדבים שטרם שובצו לאף תלמיד
SELECT V.v_first_name, V.v_last_name, V.v_age
FROM Volunteers V
WHERE V.volunteer_id NOT IN (SELECT v_volunteer_id FROM Volunteering)


-- 8. ממוצע ציונים לפי רמה תפקודית
-- משווה בין הרמות – האם תלמידים עצמאיים יותר משיגים ציונים גבוהים יותר?
SELECT L.l_type, AVG(SP.sp_score) AS avg_score
FROM Students S
JOIN Levels L ON S.s_level_code = L.level_code
JOIN Student_Progress SP ON S.student_id = SP.sp_student_id
WHERE SP.sp_score IS NOT NULL
GROUP BY L.l_type
ORDER BY avg_score DESC


-- 9. תלמידים שממתינים להתנדבות שטרם בוצעה
SELECT S.s_first_name, S.s_last_name,
       V.v_first_name AS volunteer_first,
       V.v_last_name AS volunteer_last,
       Vol.v_volunteer_date
FROM Students S
JOIN Volunteering Vol ON S.student_id = Vol.v_student_id
JOIN Volunteers V ON Vol.v_volunteer_id = V.volunteer_id
WHERE Vol.v_status = 'assigned'
ORDER BY Vol.v_volunteer_date


-- 10. סיכום פעילות לכל הורה – מספר ילדים והזמנות
-- נותנת תמונה מלאה על מעורבות ההורים במערכת, ממוין לפי כמות הזמנות
SELECT U.u_email,
       COUNT(DISTINCT S.student_id) AS num_children,
       COUNT(DISTINCT O.order_id) AS num_orders
FROM Users U
LEFT JOIN Students S ON U.u_id = S.s_u_id
LEFT JOIN Orders O ON U.u_id = O.o_user_id
WHERE U.u_role = 'Parent'
GROUP BY U.u_email
ORDER BY num_orders DESC
GO


--שאילתה מהמורה(בחינה) בהצלחה!! 
--מקצוע שיש ממנו הכי הרבה שיעורים
SELECT TOP 1 WITH TIES l_profession_id , COUNT(l_profession_id) AS 'AMOUNT'
FROM Lessons 
GROUP BY l_profession_id
ORDER BY COUNT(l_profession_id) DESC

GO
-- פרוצדורה
-- פרוצדורה לשיבוץ מתנדב חדש לתלמיד
CREATE PROCEDURE AssignVolunteer
    @v_volunteer_id INT,
    @v_student_id INT,
    @v_volunteer_date DATE
AS
BEGIN
    IF NOT EXISTS (
        SELECT 1 
        FROM Volunteering 
        WHERE v_volunteer_id = @v_volunteer_id 
        AND v_volunteer_date = @v_volunteer_date
    )
    BEGIN
        INSERT INTO Volunteering (v_volunteer_id, v_student_id, v_volunteer_date)
        VALUES (@v_volunteer_id, @v_student_id, @v_volunteer_date)
       PRINT 'המתנדב שובץ בהצלחה'
    END
    ELSE
    BEGIN
        PRINT 'שגיאה: המתנדב כבר משובץ בתאריך זה'
    END
END;
GO
EXEC AssignVolunteer 5, 2, '2026-07-01'
GO

-- פונקציה
-- פונקציה זו מביאה סיכום לכל משתמש את הילדים שהזמינה עבורם
CREATE FUNCTION dbo.GetStudentsByParent(@u_id INT)
RETURNS NVARCHAR(500)
AS
BEGIN
    DECLARE @names NVARCHAR(500) = ''

    -- בדיקה אם ההורה קיים
    IF NOT EXISTS (SELECT 1 FROM Users 
    WHERE u_id = @u_id AND u_role = 'Parent') RETURN 'הורה לא נמצא'
    SELECT @names = @names + s_first_name + ' ' + s_last_name + ', '
    FROM Students
    WHERE s_u_id = @u_id

    -- הסרת הפסיק האחרון
    SET @names = LEFT(@names, LEN(@names) - 1)
    RETURN @names
END
GO


-- שימוש דוגמא
-- הורה ספציפי
SELECT dbo.GetStudentsByParent(4) AS students_names
-- כל ההורים עם ילדיהם
SELECT u_email, dbo.GetStudentsByParent(u_id) AS students_names
FROM Users
WHERE u_role = 'Parent'
GO


-- טריגר
-- Student_Progress -עידכון אוטומטי בכל פעם של שינוי שורה ב 
CREATE TRIGGER trg_UpdateStudentProgress
ON Student_Progress
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON

    -- עדכון תאריך עדכון אחרון
    UPDATE Student_Progress
    SET sp_last_update = GETDATE()
    FROM inserted i
    WHERE Student_Progress.progress_id = i.progress_id

    -- הדפסת הודעה על השינוי
    IF UPDATE(sp_status)
        PRINT 'סטטוס שיעור עודכן'

    IF UPDATE(sp_score)
        PRINT 'ציון עודכן'
END
GO

UPDATE Student_Progress 
SET sp_status = 'Completed', sp_score = 95 
WHERE progress_id = 1001
GO

-- קונסטרקטור
-- מוודא הגיון בין ציון לסטטוס, מונע הכנסת ציון מחוץ לטווח 0–100
IF EXISTS (
    SELECT 1 FROM sys.check_constraints
    WHERE name = 'chk_score_with_status'
)
BEGIN
    ALTER TABLE Student_Progress DROP CONSTRAINT chk_score_with_status
END
GO

ALTER TABLE Student_Progress
ADD CONSTRAINT chk_score_with_status
CHECK (
    (sp_status = 'Not Started' AND sp_score IS NULL)
    OR
    (sp_status IN ('In Progress', 'Completed') 
    AND
    (sp_score IS NULL OR (sp_score >= 0 AND sp_score <= 100)))
)
GO





