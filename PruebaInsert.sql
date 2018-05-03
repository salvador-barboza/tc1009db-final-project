BEGIN TRANSACTION;
USE Hospital;
GO;

insert into Prueba values (1, 'Escala de ansiedad de Hamilton');
GO;

insert into PreguntasPrueba values(1, 1, 1,'Estado de animo ansioso', 'Preocupaciones, anticipación de lo peor, aprensión (anticipación temerosa), irritabilidad');
insert into PreguntasPrueba values(2, 1, 2,'Tensión', 'Sensación de tensión, imposibilidad de relajarse, reacciones con sobresalto, llanto fácil, temblores,
sensación de inquietud.');
insert into PreguntasPrueba values(3, 1, 3,'Temores', 'A la oscuridad, a los desconocidos, a quedarse solo, a los animales grandes, al tráfico, a las multitudes.');
insert into PreguntasPrueba values(4, 1, 4,'Insomnio', 'Dificultad para dormirse, sueño interrumpido, sueño insatisfactorio y cansancio al despertar.');
insert into PreguntasPrueba values(5, 1, 5,'Intelectual (cognitivo)','Dificultad para concentrarse, mala memoria.');
insert into PreguntasPrueba values(6, 1, 6,'Estado de animo deprimido', 'Pérdida de interés, insatisfacción en las diversiones,
depresión, despertar prematuro, cambios de humor
durante el día.')
insert into PreguntasPrueba values(7, 1, 7,'Síntomas somáticos generales (musculares)', 'Dolores y molestias musculares, rigidez muscular,
contracciones musculares, sacudidas clónicas, crujir de dientes, voz temblorosa. ')
insert into PreguntasPrueba values(8, 1, 8,'Síntomas somáticos generales (sensoriales)', 'Zumbidos de oídos, visión borrosa, sofocos y escalofríos,
sensación de debilidad, sensación de hormigueo.')
insert into PreguntasPrueba values(9, 1, 9,'Síntomas cardiovasculares.', 'Taquicardia, palpitaciones, dolor en el pecho, latidos
vasculares, sensación de desmayo, extrasístole.')
insert into PreguntasPrueba values(10, 1, 10,'Síntomas respiratorios.', 'Opresión o constricción en el pecho, sensación de ahogo,
suspiros, disnea.')
insert into PreguntasPrueba values(11, 1, 11,'Síntomas gastrointestinales.', 'Dificultad para tragar, gases, dispepsia: dolor antes y
después de comer, sensación de ardor, sensación de estómago lleno, vómitos acuosos, vómitos, sensación de estómago vacío, digestión lenta, borborigmos (ruido intestinal), diarrea, pérdida de peso, estreñimiento.')
insert into PreguntasPrueba values(12, 1, 12,'Síntomas genitourinarios.', 'Micción frecuente, micción urgente, amenorrea, menorragia, aparición de la frigidez, eyaculación precoz, ausencia de erección, impotencia. ')
insert into PreguntasPrueba values(13, 1, 13,'Síntomas autónomos.', 'Boca seca, rubor, palidez, tendencia a sudar, vértigos, cefaleas de tensión, piloerección (pelos de punta)')
insert into PreguntasPrueba values(14, 1, 14,'Comportamiento en la entrevista (general y fisiológico)', 'Tenso, no relajado, agitación nerviosa: manos, dedos cogidos, apretados, tics, enrollar un pañuelo; inquietud; pasearse de un lado a otro, temblor de manos, ceño fruncido, cara tirante, aumento del tono muscular, suspiros, palidez facial. Tragar saliva, eructar, taquicardia de reposo, frecuencia respiratoria por encima de 20 res/min, sacudidas enérgicas de tendones, temblor, pupilas dilatadas, exoftalmos (proyección anormal del globo del ojo), sudor, tics en los párpados.')
COMMIT;