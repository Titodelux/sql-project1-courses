CREATE TABLE "users" (
  "id" uuid PRIMARY KEY,
  "first_name" varchar,
  "second_name" varchar,
  "email" varchar,
  "password" varchar(25),
  "age" int,
  "role_id" int
);

CREATE TABLE "courses" (
  "id" uuid PRIMARY KEY,
  "title" varchar,
  "description" text,
  "level_id" int
);

CREATE TABLE "student_courses" (
  "id" uuid PRIMARY KEY,
  "student_id" uuid,
  "course_id" uuid,
  "score" int,
  "percent_complete" int,
  "review" text
);

CREATE TABLE "courses_videos" (
  "id" uuid PRIMARY KEY,
  "course_id" uuid,
  "title" varchar,
  "url" varchar
);

CREATE TABLE "courses_categories" (
  "id" uuid PRIMARY KEY,
  "course_id" uuid,
  "category_id" int
);

CREATE TABLE "level" (
  "id" serial PRIMARY KEY,
  "level" varchar
);

CREATE TABLE "categories" (
  "id" serial PRIMARY KEY,
  "name" varchar
);

CREATE TABLE "teachers_courses" (
  "id" uuid PRIMARY KEY,
  "teacher_id" uuid,
  "course_id" uuid
);

CREATE TABLE "roles" (
  "id" serial PRIMARY KEY,
  "name" varchar
);

ALTER TABLE "courses_videos" ADD FOREIGN KEY ("course_id") REFERENCES "courses" ("id");

ALTER TABLE "courses_categories" ADD FOREIGN KEY ("course_id") REFERENCES "courses" ("id");

ALTER TABLE "courses_categories" ADD FOREIGN KEY ("category_id") REFERENCES "categories" ("id");

ALTER TABLE "users" ADD FOREIGN KEY ("role_id") REFERENCES "roles" ("id");

ALTER TABLE "teachers_courses" ADD FOREIGN KEY ("course_id") REFERENCES "courses" ("id");

ALTER TABLE "student_courses" ADD FOREIGN KEY ("course_id") REFERENCES "courses" ("id");

ALTER TABLE "student_courses" ADD FOREIGN KEY ("student_id") REFERENCES "users" ("id");

ALTER TABLE "teachers_courses" ADD FOREIGN KEY ("teacher_id") REFERENCES "users" ("id");

ALTER TABLE "courses" ADD FOREIGN KEY ("level_id") REFERENCES "level" ("id");

insert into roles ("name") values ('Student'), ('Teacher')
insert into roles ("name") values ('Admin')

insert into users(id,first_name, second_name,email,"password",age,role_id)
values ('638811b9-9fff-4fcf-8269-ba6df506acfa', 'angel', 'perez', 'angel@gmail.com',1234,18,3),
        ('42f10e15-1fa1-4353-bfb0-782b5630629b', 'paola', 'lopez', 'paola@gmail.com', 4321, 18, 1),
        ('bec2bef7-c7f1-487e-aed7-79baf0639160', 'sahid', 'kick', 'sahid@gmail.com', 3412, 22, 2)

insert into level ("level")
values ('begginer'), ('intermediate'), ('advanced')

insert into courses (id, title, description, level_id)
values ('7c111fc2-96ef-401a-8bf5-8c600069a6b8', 'aeronautics', 'course where you will learn the basics of aeronautics!', 1),
        ('8c4e38e8-811e-40f5-a5bc-f8b0ed28164a', 'python advanced', 'recommended course for python experts', 3),
        ('25231210-6ecd-4dcc-b900-241a80596a2e', 'pc electronics', 'for those who want to learn about how their pc works!', 2)

insert into categories ("name")
values ('technology'), ('electronics'), ('programming'), ('physics'), ('aeronautic')

insert into courses_categories (id, course_id, category_id)
values ('be872575-70fd-4753-8a97-010060c14524', '25231210-6ecd-4dcc-b900-241a80596a2e', 2),
        ('8c7e5708-0a3b-4f87-9c64-c6f7e722a402', '8c4e38e8-811e-40f5-a5bc-f8b0ed28164a', 3),
        ('a999b4b5-fb28-4265-9884-6221231224a6', '7c111fc2-96ef-401a-8bf5-8c600069a6b8', 4),
        ('705766ed-9e56-48f1-ba03-2ab2aee938ea', '7c111fc2-96ef-401a-8bf5-8c600069a6b8', 5)
        
insert into courses_videos (id, course_id, title, url)
values ('2fce0e09-2281-40ce-8fb2-0a2b586c77e1', '7c111fc2-96ef-401a-8bf5-8c600069a6b8', 'first class aeronautics','/:id'),
        ('9beb00a3-1188-4aa8-8857-e566fb50bf02', '8c4e38e8-811e-40f5-a5bc-f8b0ed28164a', 'first class python', '/:id'),
        ('0919af3b-86e7-41e7-a24a-5a553daa77e9', '25231210-6ecd-4dcc-b900-241a80596a2e', 'first class pc electronics', '/:id')

insert into teachers_courses (id, teacher_id, course_id)
values ('f068ee14-d875-4f90-98a8-753d67010463', 'bec2bef7-c7f1-487e-aed7-79baf0639160','7c111fc2-96ef-401a-8bf5-8c600069a6b8'),
        ('63287bd6-59cf-454d-83d8-e3fa785a4349', 'bec2bef7-c7f1-487e-aed7-79baf0639160','8c4e38e8-811e-40f5-a5bc-f8b0ed28164a'),
        ('a07fa46d-22df-4843-a8ed-67be4dbf308a', 'bec2bef7-c7f1-487e-aed7-79baf0639160','25231210-6ecd-4dcc-b900-241a80596a2e')

insert into student_courses (id, student_id, course_id, percent_complete)
values ('58bb59a5-6496-4034-95fc-7af1dfeb3c2a', '638811b9-9fff-4fcf-8269-ba6df506acfa', '7c111fc2-96ef-401a-8bf5-8c600069a6b8', 50),
        ('3ef1f355-e6c6-4d98-b553-c0758b7bc4a9', '42f10e15-1fa1-4353-bfb0-782b5630629b', '8c4e38e8-811e-40f5-a5bc-f8b0ed28164a', 40),
        ('7dab9512-71c3-4cde-bbd3-f515a1444966', 'bec2bef7-c7f1-487e-aed7-79baf0639160', '8c4e38e8-811e-40f5-a5bc-f8b0ed28164a', 20)

select courses.title as course, categories."name" as category, "level"."level" as level,
        users.first_name as teacher, cv.title as video_title, sc.student_id  as student_id
from courses
inner join courses_categories as cc on courses.id = cc.course_id
inner join categories 				on cc.category_id = categories.id 
inner join "level" 					on courses.level_id = "level".id
inner join courses_videos as cv 	on courses.id = cv.course_id
inner join teachers_courses as tc 	on courses.id = tc.course_id
inner join users					on users.id = tc.teacher_id
inner join student_courses as sc 	on courses.id = sc.course_id




