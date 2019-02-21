CREATE SEQUENCE s_Student;
CREATE SEQUENCE s_Professor; 
CREATE SEQUENCE s_StudCourse; 
CREATE SEQUENCE s_Journal;
CREATE SEQUENCE s_Application;
CREATE SEQUENCE s_Group;
CREATE SEQUENCE s_Form;
CREATE SEQUENCE s_Certificate;
CREATE SEQUENCE s_ExamType;
CREATE SEQUENCE s_Instructor;


CREATE TABLE "Студент" (
	"id_студента" INT DEFAULT NEXTVAL ('s_Student') UNIQUE,
	"Группа" int NOT NULL,
	"Анкета" int NOT NULL,
	"Количество_пропусков" int NOT NULL,
	"Состояние_оплаты_за_курс" char(30) NOT NULL,
	CONSTRAINT Студент_pk PRIMARY KEY ("id_студента","Анкета")
);


CREATE TABLE "Преподаватель" (
	"id_преподавателя" INT DEFAULT NEXTVAL ('s_Professor') UNIQUE,
	"Фамилия" char(20) NOT NULL,
	"Имя" char(20) NOT NULL,
	"Отчество" char(20) NOT NULL,
	"Категории_обучения" char(10) NOT NULL,
	"Наличие_частных занятий" bool NOT NULL,
	"Зарплата" float NOT NULL,
	"Адресс_проживения" char(30) NOT NULL,
	"Высшее_образование" char(20) NOT NULL,
	CONSTRAINT Преподаватель_pk PRIMARY KEY ("id_преподавателя")
);


CREATE TABLE "Курс_обучения" (
	"id_курса" INT DEFAULT NEXTVAL ('s_StudCourse') UNIQUE,
	"Категория_курса" char NOT NULL,
	"Стоимость" int NOT NULL,
	"Продолжительность" int NOT NULL,
	CONSTRAINT Курс_обучения_pk PRIMARY KEY ("id_курса")
);


CREATE TABLE "Журнал" (
	"id_журнала" INT DEFAULT NEXTVAL ('s_Journal') UNIQUE,
	"Студент" int NOT NULL,
	"Экзамен" int NOT NULL,
	"Дата_прохождения" DATE NOT NULL,
	"Набранный_балл" int NOT NULL,
	"Инструктор" int NOT NULL,
	CONSTRAINT Журнал_pk PRIMARY KEY ("id_журнала")
);


CREATE TABLE "Заявка_в_автошколу" (
	"id_заявки" INT DEFAULT NEXTVAL ('s_Application'),
	"Анкета" INT NOT NULL,
	"Необходимая_категория" char(1) NOT NULL,
	CONSTRAINT Заявка_в_автошколу_pk PRIMARY KEY ("id_заявки","Анкета")
);

CREATE TABLE "Группа" (
	"id_группы" INT DEFAULT NEXTVAL ('s_Group') UNIQUE,
	"Номер_группы" int NOT NULL,
	"Количество_учащихся" int NOT NULL,
	"Курс" int NOT NULL,
	"Дата_начала" DATE NOT NULL,
	"Расписание_занятий" char(30) NOT NULL,
	"Преподаватель" int NOT NULL,
	CONSTRAINT Группа_pk PRIMARY KEY ("id_группы")
);


CREATE TABLE "Анкета_студента" (
	"id_анкеты" INT DEFAULT NEXTVAL ('s_Form'),
	"Фамилия" char(20) NOT NULL,
	"Имя" char(20) NOT NULL,
	"Отчество" char(20) NOT NULL,
	"Дата_рождения" DATE NOT NULL,
	"Адресс_проживания" char(30) NOT NULL,
	"Место_учебы/работы" varchar NOT NULL,
	CONSTRAINT Анкета_студента_pk PRIMARY KEY ("id_анкеты")
);



CREATE TABLE "Свидетельство_об_окончании" (
	"id_свидетельства" INT DEFAULT NEXTVAL ('s_Certificate'),
	"Пройденный_курс" int NOT NULL,
	"Студент" int NOT NULL,
	"Результат_экзамена" int NOT NULL UNIQUE,
	CONSTRAINT Свидетельство_об_окончании_pk PRIMARY KEY ("id_свидетельства","Студент")
);



CREATE TABLE "Тип_экзамена" (
	"id_экзамена" INT DEFAULT NEXTVAL ('s_ExamType'),
	"Категория_экзамена" char(20) NOT NULL,
	"Система_оценивания" char(20) NOT NULL,
	"Стоимость" float NOT NULL,
	CONSTRAINT Экзамен_pk PRIMARY KEY ("id_экзамена")
);

CREATE TABLE "Инструктор" (
	"id_инструктора" INT DEFAULT NEXTVAL ('s_Instructor'),
	"Фамилия" char(20) NOT NULL,
	"Имя" char(20) NOT NULL,
	"Отчество" char(20) NOT NULL,
	"Опыт_работы(в_месяцах)" int,
	"Опыт_вождения(в_месяцах)" int,
	"Категория_транспорта" char(10) NOT NULL,
	"Зарплата" float,
	CONSTRAINT Инструктор_pk PRIMARY KEY ("id_инструктора")
);


ALTER TABLE "Студент" ADD CONSTRAINT "Студент_fk0" FOREIGN KEY ("Анкета") REFERENCES "Анкета_студента"("id_анкеты");
ALTER TABLE "Студент" ADD CONSTRAINT "Студент_fk1" FOREIGN KEY ("Группа") REFERENCES "Группа"("id_группы");

ALTER TABLE "Группа" ADD CONSTRAINT "Группа_fk1" FOREIGN KEY ("Преподаватель") REFERENCES "Преподаватель"("id_преподавателя");

ALTER TABLE "Группа" ADD CONSTRAINT "Группа_fk0" FOREIGN KEY ("Курс") REFERENCES "Курс_обучения"("id_курса");

ALTER TABLE "Журнал" ADD CONSTRAINT "Журнал_fk0" FOREIGN KEY ("Студент") REFERENCES "Студент"("id_студента");
ALTER TABLE "Журнал" ADD CONSTRAINT "Журнал_fk1" FOREIGN KEY ("Инструктор") REFERENCES "Инструктор"("id_инструктора");
ALTER TABLE "Журнал" ADD CONSTRAINT "Журнал_fk3" FOREIGN KEY ("Экзамен") REFERENCES "Тип_экзамена"("id_экзамена");

ALTER TABLE "Заявка_в_автошколу" ADD CONSTRAINT "Заявка_в_автошколу_fk0" FOREIGN KEY ("Анкета") REFERENCES "Анкета_студента"("id_анкеты");

ALTER TABLE "Свидетельство_об_окончании" ADD CONSTRAINT "Свидетельство_об_окончании_fk0" FOREIGN KEY ("Пройденный_курс") REFERENCES "Курс_обучения"("id_курса");
ALTER TABLE "Свидетельство_об_окончании" ADD CONSTRAINT "Свидетельство_об_окончании_fk1" FOREIGN KEY ("Студент") REFERENCES "Студент"("id_студента");
ALTER TABLE "Свидетельство_об_окончании" ADD CONSTRAINT "Свидетельство_об_окончании_fk2" FOREIGN KEY ("Результат_экзамена") REFERENCES "Журнал"("id_журнала");

--ALTER TABLE "Инструктор" ADD CONSTRAINT "Инструктор_fk0" FOREIGN KEY ("id_инструктора") REFERENCES "Журнал"("Инструктор");




