-- ============================================================
-- GEOGRAFÍA DE ESPAÑA
-- ============================================================

USE vinyl_vault;

SET NAMES utf8mb4;

-- ------------------------------------------------------------
-- SCHEMA
-- ------------------------------------------------------------

CREATE TABLE Comunidades (
    Nombre         VARCHAR(100) PRIMARY KEY,
    fecha_estatuto DATE         NOT NULL,
    Presidente     VARCHAR(100)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE Provincias (
    codigo_prov CHAR(2)      PRIMARY KEY,
    nombre      VARCHAR(100) NOT NULL,
    extension   DECIMAL(10,2),
    comunidad   VARCHAR(100) NOT NULL,
    CONSTRAINT fk_prov_com FOREIGN KEY (comunidad) REFERENCES Comunidades(Nombre)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE Localidades (
    cod_loc  CHAR(5)      PRIMARY KEY,
    nombre   VARCHAR(100) NOT NULL,
    num_hab  INT,
    cod_prov CHAR(2)      NOT NULL,
    CONSTRAINT fk_loc_prov FOREIGN KEY (cod_prov) REFERENCES Provincias(codigo_prov)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE Mar (
    cod_mar           CHAR(3)      PRIMARY KEY,
    nombre            VARCHAR(100) NOT NULL,
    profundidad_media DECIMAL(8,2)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Nota: al consultar esta tabla usar comillas invertidas: SELECT * FROM `Bañan`
CREATE TABLE `Bañan` (
    cod_mar  CHAR(3) NOT NULL,
    cod_prov CHAR(2) NOT NULL,
    km_costa DECIMAL(8,2),
    PRIMARY KEY (cod_mar, cod_prov),
    CONSTRAINT fk_ban_mar  FOREIGN KEY (cod_mar)  REFERENCES Mar(cod_mar),
    CONSTRAINT fk_ban_prov FOREIGN KEY (cod_prov) REFERENCES Provincias(codigo_prov)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------
-- SEED DATA
-- ------------------------------------------------------------

INSERT INTO Comunidades (Nombre, fecha_estatuto, Presidente) VALUES
('Andalucía',            '1981-12-30', 'Juan Manuel Moreno Bonilla'),
('Aragón',               '1982-08-16', 'Jorge Azcón Navarro'),
('Asturias',             '1981-12-30', 'Adrián Barbón Rodríguez'),
('Islas Baleares',       '1983-02-25', 'Marga Prohens'),
('Canarias',             '1982-08-16', 'Fernando Clavijo Batlle'),
('Cantabria',            '1981-12-30', 'María José Sáenz de Buruaga'),
('Castilla-La Mancha',   '1982-08-16', 'Emiliano García-Page'),
('Castilla y León',      '1983-02-25', 'Alfonso Fernández Mañueco'),
('Cataluña',             '1979-12-18', 'Salvador Illa'),
('Comunidad Valenciana', '1982-07-01', 'Carlos Mazón'),
('Extremadura',          '1983-02-25', 'María Guardiola'),
('Galicia',              '1981-04-06', 'Alfonso Rueda Valenzuela'),
('La Rioja',             '1982-06-09', 'Gonzalo Capellán de Miguel'),
('Madrid',               '1983-02-25', 'Isabel Díaz Ayuso'),
('Región de Murcia',     '1982-06-09', 'Fernando López Miras'),
('Navarra',              '1982-08-10', 'María Chivite'),
('País Vasco',           '1979-12-18', 'Imanol Pradales');

INSERT INTO Provincias (codigo_prov, nombre, extension, comunidad) VALUES
('01', 'Álava',                    3037.00, 'País Vasco'),
('02', 'Albacete',                14926.00, 'Castilla-La Mancha'),
('03', 'Alicante',                 5817.00, 'Comunidad Valenciana'),
('04', 'Almería',                  8774.00, 'Andalucía'),
('05', 'Ávila',                    8050.00, 'Castilla y León'),
('06', 'Badajoz',                 21766.00, 'Extremadura'),
('07', 'Illes Balears',            4992.00, 'Islas Baleares'),
('08', 'Barcelona',                7726.00, 'Cataluña'),
('09', 'Burgos',                  14291.00, 'Castilla y León'),
('10', 'Cáceres',                 19868.00, 'Extremadura'),
('11', 'Cádiz',                    7436.00, 'Andalucía'),
('12', 'Castellón',                6632.00, 'Comunidad Valenciana'),
('13', 'Ciudad Real',             19813.00, 'Castilla-La Mancha'),
('14', 'Córdoba',                 13771.00, 'Andalucía'),
('15', 'A Coruña',                 7950.00, 'Galicia'),
('16', 'Cuenca',                  17141.00, 'Castilla-La Mancha'),
('17', 'Girona',                   5910.00, 'Cataluña'),
('18', 'Granada',                 12531.00, 'Andalucía'),
('19', 'Guadalajara',             12190.00, 'Castilla-La Mancha'),
('20', 'Guipúzcoa',                1980.00, 'País Vasco'),
('21', 'Huelva',                  10128.00, 'Andalucía'),
('22', 'Huesca',                  15636.00, 'Aragón'),
('23', 'Jaén',                    13496.00, 'Andalucía'),
('24', 'León',                    15581.00, 'Castilla y León'),
('25', 'Lleida',                  12172.00, 'Cataluña'),
('26', 'La Rioja',                 5045.00, 'La Rioja'),
('27', 'Lugo',                     9856.00, 'Galicia'),
('28', 'Madrid',                   8028.00, 'Madrid'),
('29', 'Málaga',                   7308.00, 'Andalucía'),
('30', 'Murcia',                  11313.00, 'Región de Murcia'),
('31', 'Navarra',                 10391.00, 'Navarra'),
('32', 'Ourense',                  7273.00, 'Galicia'),
('33', 'Asturias',                10604.00, 'Asturias'),
('34', 'Palencia',                 8052.00, 'Castilla y León'),
('35', 'Las Palmas',               4066.00, 'Canarias'),
('36', 'Pontevedra',               4495.00, 'Galicia'),
('37', 'Salamanca',               12336.00, 'Castilla y León'),
('38', 'Santa Cruz de Tenerife',   3381.00, 'Canarias'),
('39', 'Cantabria',                5321.00, 'Cantabria'),
('40', 'Segovia',                  6949.00, 'Castilla y León'),
('41', 'Sevilla',                 14042.00, 'Andalucía'),
('42', 'Soria',                   10306.00, 'Castilla y León'),
('43', 'Tarragona',                6303.00, 'Cataluña'),
('44', 'Teruel',                  14810.00, 'Aragón'),
('45', 'Toledo',                  15368.00, 'Castilla-La Mancha'),
('46', 'Valencia',                10806.00, 'Comunidad Valenciana'),
('47', 'Valladolid',               8110.00, 'Castilla y León'),
('48', 'Vizcaya',                  2217.00, 'País Vasco'),
('49', 'Zamora',                  10561.00, 'Castilla y León'),
('50', 'Zaragoza',                17274.00, 'Aragón');

INSERT INTO Localidades (cod_loc, nombre, num_hab, cod_prov) VALUES
-- Álava
('01059', 'Vitoria-Gasteiz',               260000, '01'),
('01036', 'Llodio',                         18000, '01'),
('01002', 'Amurrio',                        10000, '01'),
-- Albacete
('02003', 'Albacete',                       175000, '02'),
('02037', 'Hellín',                          28000, '02'),
('02078', 'Villarrobledo',                   25000, '02'),
('02007', 'Almansa',                         25000, '02'),
-- Alicante
('03014', 'Alicante',                       335000, '03'),
('03065', 'Elche',                          230000, '03'),
('03133', 'Torrevieja',                     101000, '03'),
('03099', 'Orihuela',                        82000, '03'),
('03031', 'Benidorm',                        71000, '03'),
-- Almería
('04013', 'Almería',                        200000, '04'),
('04079', 'Roquetas de Mar',                 96000, '04'),
('04902', 'El Ejido',                        83000, '04'),
('04044', 'Vícar',                           28000, '04'),
-- Ávila
('05019', 'Ávila',                           57000, '05'),
('05015', 'Arévalo',                          8000, '05'),
('05014', 'Arenas de San Pedro',              7000, '05'),
-- Badajoz
('06015', 'Badajoz',                        151000, '06'),
('06083', 'Mérida',                          59000, '06'),
('06049', 'Don Benito',                      36000, '06'),
('06149', 'Villanueva de la Serena',         26000, '06'),
-- Illes Balears
('07040', 'Palma',                          430000, '07'),
('07027', 'Calvià',                          51000, '07'),
('07026', 'Eivissa',                         49000, '07'),
('07033', 'Manacor',                         43000, '07'),
-- Barcelona
('08019', 'Barcelona',                     1620000, '08'),
('08101', 'L\'Hospitalet de Llobregat',     257000, '08'),
('08015', 'Badalona',                       216000, '08'),
('08279', 'Terrassa',                       220000, '08'),
('08187', 'Sabadell',                       212000, '08'),
('08121', 'Mataró',                         128000, '08'),
-- Burgos
('09059', 'Burgos',                         176000, '09'),
('09217', 'Miranda de Ebro',                 37000, '09'),
('09014', 'Aranda de Duero',                 33000, '09'),
-- Cáceres
('10037', 'Cáceres',                         95000, '10'),
('10148', 'Plasencia',                       40000, '10'),
('10130', 'Navalmoral de la Mata',           17000, '10'),
-- Cádiz
('11012', 'Cádiz',                          116000, '11'),
('11021', 'Jerez de la Frontera',           212000, '11'),
('11004', 'Algeciras',                      121000, '11'),
('11031', 'San Fernando',                    95000, '11'),
('11030', 'El Puerto de Santa María',        88000, '11'),
-- Castellón
('12040', 'Castellón de la Plana',          171000, '12'),
('12135', 'Vila-real',                       51000, '12'),
('12033', 'Burriana',                        34000, '12'),
-- Ciudad Real
('13034', 'Ciudad Real',                     74000, '13'),
('13070', 'Puertollano',                     49000, '13'),
('13004', 'Alcázar de San Juan',             31000, '13'),
('13087', 'Valdepeñas',                      28000, '13'),
-- Córdoba
('14021', 'Córdoba',                        325000, '14'),
('14038', 'Lucena',                          44000, '14'),
('14055', 'Puente Genil',                    28000, '14'),
('14042', 'Montilla',                        23000, '14'),
-- A Coruña
('15030', 'A Coruña',                       245000, '15'),
('15078', 'Santiago de Compostela',          97000, '15'),
('15036', 'Ferrol',                          65000, '15'),
('15058', 'Narón',                           39000, '15'),
-- Cuenca
('16078', 'Cuenca',                          54000, '16'),
('16201', 'Tarancón',                        14000, '16'),
('16184', 'San Clemente',                     6000, '16'),
-- Girona
('17079', 'Girona',                         103000, '17'),
('17066', 'Figueres',                        46000, '17'),
('17095', 'Lloret de Mar',                   40000, '17'),
('17023', 'Blanes',                          39000, '17'),
-- Granada
('18087', 'Granada',                        232000, '18'),
('18140', 'Motril',                          60000, '18'),
('18016', 'Almuñécar',                       27000, '18'),
('18118', 'Loja',                            21000, '18'),
-- Guadalajara
('19130', 'Guadalajara',                     76000, '19'),
('19047', 'Azuqueca de Henares',             34000, '19'),
('19044', 'Cabanillas del Campo',             9000, '19'),
-- Guipúzcoa
('20069', 'Donostia-San Sebastián',         187000, '20'),
('20045', 'Irún',                            62000, '20'),
('20030', 'Errenteria',                      39000, '20'),
('20028', 'Eibar',                           27000, '20'),
-- Huelva
('21041', 'Huelva',                         143000, '21'),
('21042', 'Lepe',                            27000, '21'),
('21005', 'Almonte',                         23000, '21'),
('21049', 'Moguer',                          22000, '21'),
-- Huesca
('22125', 'Huesca',                          52000, '22'),
('22150', 'Monzón',                          17000, '22'),
('22048', 'Barbastro',                       17000, '22'),
('22130', 'Jaca',                            13000, '22'),
-- Jaén
('23050', 'Jaén',                           107000, '23'),
('23055', 'Linares',                         58000, '23'),
('23004', 'Andújar',                         36000, '23'),
('23092', 'Úbeda',                           34000, '23'),
-- León
('24089', 'León',                           122000, '24'),
('24115', 'Ponferrada',                      63000, '24'),
('24145', 'San Andrés del Rabanedo',         31000, '24'),
-- Lleida
('25120', 'Lleida',                         137000, '25'),
('25141', 'Mollerussa',                      14000, '25'),
('25072', 'Balaguer',                        16000, '25'),
-- La Rioja
('26089', 'Logroño',                        152000, '26'),
('26033', 'Calahorra',                       24000, '26'),
('26018', 'Arnedo',                          15000, '26'),
-- Lugo
('27028', 'Lugo',                            98000, '27'),
('27065', 'Viveiro',                         15000, '27'),
('27064', 'Vilalba',                         15000, '27'),
-- Madrid
('28079', 'Madrid',                        3300000, '28'),
('28092', 'Móstoles',                       207000, '28'),
('28005', 'Alcalá de Henares',              195000, '28'),
('28058', 'Fuenlabrada',                    193000, '28'),
('28074', 'Leganés',                        186000, '28'),
('28065', 'Getafe',                         181000, '28'),
('28007', 'Alcorcón',                       165000, '28'),
-- Málaga
('29067', 'Málaga',                         580000, '29'),
('29069', 'Marbella',                       145000, '29'),
('29095', 'Vélez-Málaga',                    78000, '29'),
('29051', 'Fuengirola',                      79000, '29'),
('29090', 'Torremolinos',                    69000, '29'),
-- Murcia
('30030', 'Murcia',                         460000, '30'),
('30016', 'Cartagena',                      215000, '30'),
('30024', 'Lorca',                           91000, '30'),
('30027', 'Molina de Segura',                71000, '30'),
-- Navarra
('31201', 'Pamplona',                       205000, '31'),
('31232', 'Tudela',                          36000, '31'),
('31050', 'Barañain',                        23000, '31'),
-- Ourense
('32054', 'Ourense',                        104000, '32'),
('32009', 'O Barco de Valdeorras',           14000, '32'),
('32084', 'Verín',                           14000, '32'),
-- Asturias
('33044', 'Oviedo',                         220000, '33'),
('33024', 'Gijón',                          271000, '33'),
('33004', 'Avilés',                          79000, '33'),
('33066', 'Siero',                           53000, '33'),
-- Palencia
('34120', 'Palencia',                        78000, '34'),
('34002', 'Aguilar de Campoo',                7000, '34'),
('34037', 'Guardo',                           7000, '34'),
-- Las Palmas
('35016', 'Las Palmas de Gran Canaria',     380000, '35'),
('35026', 'Telde',                          103000, '35'),
('35022', 'Santa Lucía de Tirajana',         70000, '35'),
-- Pontevedra
('36038', 'Pontevedra',                      83000, '36'),
('36057', 'Vigo',                           295000, '36'),
('36060', 'Vilagarcía de Arousa',            37000, '36'),
('36040', 'O Porriño',                       19000, '36'),
-- Salamanca
('37274', 'Salamanca',                      143000, '37'),
('37038', 'Béjar',                           13000, '37'),
('37162', 'Ciudad Rodrigo',                  13000, '37'),
-- Santa Cruz de Tenerife
('38038', 'Santa Cruz de Tenerife',         205000, '38'),
('38023', 'San Cristóbal de La Laguna',     153000, '38'),
('38006', 'Arona',                           82000, '38'),
-- Cantabria
('39075', 'Santander',                      172000, '39'),
('39088', 'Torrelavega',                     51000, '39'),
('39020', 'Castro Urdiales',                 32000, '39'),
-- Segovia
('40155', 'Segovia',                         52000, '40'),
('40063', 'Cuéllar',                         10000, '40'),
('40028', 'El Espinar',                       9000, '40'),
-- Sevilla
('41091', 'Sevilla',                        685000, '41'),
('41038', 'Dos Hermanas',                   136000, '41'),
('41004', 'Alcalá de Guadaíra',              74000, '41'),
('41060', 'Mairena del Aljarafe',            44000, '41'),
-- Soria
('42173', 'Soria',                           39000, '42'),
('42036', 'El Burgo de Osma',                 5000, '42'),
('42087', 'Ágreda',                           3000, '42'),
-- Tarragona
('43148', 'Tarragona',                      132000, '43'),
('43123', 'Reus',                           103000, '43'),
('43155', 'Tortosa',                         34000, '43'),
-- Teruel
('44216', 'Teruel',                          35000, '44'),
('44013', 'Alcañiz',                         16000, '44'),
('44060', 'Andorra',                          8000, '44'),
-- Toledo
('45168', 'Toledo',                          84000, '45'),
('45165', 'Talavera de la Reina',            83000, '45'),
('45074', 'Illescas',                        28000, '45'),
-- Valencia
('46250', 'Valencia',                       800000, '46'),
('46235', 'Torrent',                         82000, '46'),
('46131', 'Gandía',                          74000, '46'),
('46115', 'Paterna',                         67000, '46'),
-- Valladolid
('47186', 'Valladolid',                     296000, '47'),
('47095', 'Medina del Campo',                23000, '47'),
('47075', 'Laguna de Duero',                 22000, '47'),
-- Vizcaya
('48020', 'Bilbao',                         345000, '48'),
('48013', 'Barakaldo',                      100000, '48'),
('48044', 'Getxo',                           78000, '48'),
('48015', 'Basauri',                         40000, '48'),
-- Zamora
('49275', 'Zamora',                          62000, '49'),
('49022', 'Benavente',                       18000, '49'),
('49024', 'Toro',                            10000, '49'),
-- Zaragoza
('50297', 'Zaragoza',                       675000, '50'),
('50066', 'Calatayud',                       20000, '50'),
('50276', 'Utebo',                           18000, '50'),
('50009', 'Ejea de los Caballeros',          17000, '50');

INSERT INTO Mar (cod_mar, nombre, profundidad_media) VALUES
('CAN', 'Mar Cantábrico',    1730.00),
('ATL', 'Océano Atlántico',  3300.00),
('MED', 'Mar Mediterráneo',  1500.00);

-- Nota: usar backticks para consultar esta tabla: SELECT * FROM `Bañan`
INSERT INTO `Bañan` (cod_mar, cod_prov, km_costa) VALUES
-- Mar Cantábrico
('CAN', '15',   80.00),  -- A Coruña
('CAN', '27',  130.00),  -- Lugo
('CAN', '33',  340.00),  -- Asturias
('CAN', '39',  280.00),  -- Cantabria
('CAN', '48',  160.00),  -- Vizcaya
('CAN', '20',   90.00),  -- Guipúzcoa
-- Océano Atlántico
('ATL', '15',  390.00),  -- A Coruña (fachada atlántica)
('ATL', '36',  480.00),  -- Pontevedra
('ATL', '21',  130.00),  -- Huelva
('ATL', '11',  200.00),  -- Cádiz (fachada atlántica)
('ATL', '35',  610.00),  -- Las Palmas
('ATL', '38',  640.00),  -- Santa Cruz de Tenerife
-- Mar Mediterráneo
('MED', '07', 1428.00),  -- Illes Balears
('MED', '17',  258.00),  -- Girona
('MED', '08',   98.00),  -- Barcelona
('MED', '43',  220.00),  -- Tarragona
('MED', '12',  220.00),  -- Castellón
('MED', '46',  120.00),  -- Valencia
('MED', '03',  244.00),  -- Alicante
('MED', '30',  252.00),  -- Murcia
('MED', '04',  220.00),  -- Almería
('MED', '18',   70.00),  -- Granada
('MED', '29',  284.00),  -- Málaga
('MED', '11',   30.00);  -- Cádiz (fachada mediterránea/estrecho)
