CREATE TABLE IF NOT EXISTS "members" (
	"id" UUID NOT NULL UNIQUE,
	"full_name" VARCHAR(255) NOT NULL,
	"email" VARCHAR(255) NOT NULL UNIQUE,
	"faculty" VARCHAR(255) NOT NULL,
	"member_type" VARCHAR(20) NOT NULL CHECK(member_type IN ('Student', 'Lecturer', 'Researcher')),
	"join_date" DATE NOT NULL,
	"password_hash" VARCHAR(255) NOT NULL,
	PRIMARY KEY("id")
);

CREATE TABLE IF NOT EXISTS "categories" (
	"category_id" UUID NOT NULL UNIQUE,
	"category_name" VARCHAR(100) NOT NULL UNIQUE,
	PRIMARY KEY("category_id")
);

CREATE TABLE IF NOT EXISTS "books" (
	"book_id" UUID NOT NULL UNIQUE,
	"title" VARCHAR(255) NOT NULL,
	"author" VARCHAR(255) NOT NULL,
	"isbn" VARCHAR(20) NOT NULL UNIQUE,
	"copies_available" INTEGER NOT NULL CHECK(copies_available >= 0),
	"category_id" UUID NOT NULL,
	PRIMARY KEY("book_id")
);

CREATE TABLE IF NOT EXISTS "staff" (
	"staff_id" UUID NOT NULL UNIQUE,
	"full_name" VARCHAR(255) NOT NULL,
	"role" VARCHAR(20) NOT NULL CHECK(role IN ('Administrator', 'Librarian')),
	"email" VARCHAR(255) NOT NULL UNIQUE,
	"password_hash" VARCHAR(255) NOT NULL,
	PRIMARY KEY("staff_id")
);

CREATE TABLE IF NOT EXISTS "loans" (
	"loan_id" UUID NOT NULL,
	"loan_date" DATE NOT NULL,
	"due_date" DATE NOT NULL,
	"return_date" DATE,
	"member_id" UUID NOT NULL,
	"staff_id" UUID NOT NULL,
	"book_id" UUID NOT NULL,
	PRIMARY KEY("loan_id")
);

ALTER TABLE "books"
ADD FOREIGN KEY("category_id") REFERENCES "categories"("category_id")
ON UPDATE NO ACTION ON DELETE RESTRICT;

ALTER TABLE "loans"
ADD FOREIGN KEY("member_id") REFERENCES "members"("id")
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE "loans"
ADD FOREIGN KEY("staff_id") REFERENCES "staff"("staff_id")
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE "loans"
ADD FOREIGN KEY("book_id") REFERENCES "books"("book_id")
ON UPDATE NO ACTION ON DELETE NO ACTION;
