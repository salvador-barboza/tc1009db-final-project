BEGIN TRANSACTION;
USE hospital;

insert into Paciente values (1281486, 'Sebasti·n Carmona MartÌnez', '1997-10-18');
insert into Paciente values (01139431, 'Marlon Omar Lopez Aguilar', '1998-04-03');

insert into Doctor values (01187752, 'Salvador Barboza');


insert into Medicamento values (1, 'Tressvin', 'Sertralina', 'ifa CELTICS', '50 mg');
insert into Medicamento values (2, 'Tim ASF', 'Quetiapina', 'ASOFARMA', '100 mg');
insert into Medicamento values (3, 'Farmaxetina', 'Fluroxetina', 'ifa CELTICS', '20 mg');


insert into RecetaMedica
values (1, 'Diluir en agua una vez al dia con o sin alimento, debe ser en la maÒana o en la noche', 7, 1, 50.0);
insert into RecetaMedica values (2, 'Tragar sin masticar con o sin alimento una vez al dia', 5, 1, 100.0);
insert into RecetaMedica
values (3, 'Diluir en agua una vez al dia con o sin alimento, debe ser en la maÒana o en la noche', 7, 1, 50.0);
insert into RecetaMedica values (4, 'Debe de consumirse durante o despues de una comida', 7, 1, 20.0);


insert into MedicamentosPorReceta VALUES (1, 1);
insert into MedicamentosPorReceta VALUES (1, 2);
insert into MedicamentosPorReceta VALUES (1, 3);
insert into MedicamentosPorReceta VALUES (2, 1);
insert into MedicamentosPorReceta VALUES (3, 1);

Insert into InstanciaPrueba values (1, '2018-02-20', 11, 1);
Insert into InstanciaPrueba values (2, '2018-02-20', 13, 1);
Insert into InstanciaPrueba values (3, '2018-02-27', 11, 1);
Insert into InstanciaPrueba values (4, '2018-02-27', 10, 1);

Insert into Respuestas VALUES (1, 1, 2);
Insert into Respuestas VALUES (2, 1, 3);
Insert into Respuestas VALUES (3, 1, 1);
Insert into Respuestas VALUES (4, 1, 2);
Insert into Respuestas VALUES (5, 1, 3);
Insert into Respuestas VALUES (1, 2, 3);
Insert into Respuestas VALUES (2, 2, 2);
Insert into Respuestas VALUES (3, 2, 1);
Insert into Respuestas VALUES (4, 2, 3);
Insert into Respuestas VALUES (5, 2, 4);
Insert into Respuestas VALUES (1, 3, 1);
Insert into Respuestas VALUES (2, 3, 2);
Insert into Respuestas VALUES (3, 3, 1);
Insert into Respuestas VALUES (4, 3, 3);
Insert into Respuestas VALUES (5, 3, 4);
Insert into Respuestas VALUES (1, 4, 2);
Insert into Respuestas VALUES (2, 4, 2);
Insert into Respuestas VALUES (3, 4, 2);
Insert into Respuestas VALUES (4, 4, 1);
Insert into Respuestas VALUES (5, 4, 3);

insert into Consulta values (1, '2018-02-20', '8:30',
                             'El paciente presenta dificultad para concentrarse adem·s de pÈrdida de peso y agitaciÛn motora',
                             103.2, 1.92, 01187752, 1281486, 1, 1);

insert into Consulta values (2, '2018-02-20', '9:30',
                             'El paciente presenta transtorno de ansiedad social, se ha comprobado que no es una alteraciÛn causada por sustancias ajenas al paciente',
                             110.3, 1.90, 01187752, 01139431, 2, 2);

insert into Consulta values
  (3, '2018-02-27', '8:30', 'El paciente presenta un cuadro leve de agitaciÛn motora adem·s ha mantenido su peso',
   103.2, 1.92, 01187752, 1281486, 3, 3);

insert into Consulta values
  (4, '2018-02-27', '9:30', 'El paciente presenta transtorno de ansiedad social, especÌficamente al hablar en p˙blico',
   110.3, 1.90, 01187752, 01139431, 4, 4);

insert into DiagnosticoConsulta values (1, 1);
insert into DiagnosticoConsulta values (2, 2);
insert into DiagnosticoConsulta values (3, 3);
insert into DiagnosticoConsulta values (4, 4);

COMMIT;