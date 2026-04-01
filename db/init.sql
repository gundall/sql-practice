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
('Comunidad de Madrid',  '1983-02-25', 'Isabel Díaz Ayuso'),
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
('28', 'Madrid',                   8028.00, 'Comunidad de Madrid'),
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
('01059', 'Vitoria-Gasteiz',              260000, '01'),
-- Albacete
('02003', 'Albacete',                     175000, '02'),
-- Alicante
('03014', 'Alicante',                     335000, '03'),
('03065', 'Elche',                        230000, '03'),
-- Almería
('04013', 'Almería',                      200000, '04'),
-- Ávila
('05019', 'Ávila',                         57000, '05'),
-- Badajoz
('06015', 'Badajoz',                      151000, '06'),
-- Illes Balears
('07040', 'Palma',                        430000, '07'),
-- Barcelona
('08019', 'Barcelona',                   1620000, '08'),
('08101', 'L\'Hospitalet de Llobregat',   257000, '08'),
('08015', 'Badalona',                     216000, '08'),
-- Burgos
('09059', 'Burgos',                       176000, '09'),
-- Cáceres
('10037', 'Cáceres',                       95000, '10'),
-- Cádiz
('11012', 'Cádiz',                        116000, '11'),
('11021', 'Jerez de la Frontera',         212000, '11'),
-- Castellón
('12040', 'Castellón de la Plana',        171000, '12'),
-- Ciudad Real
('13034', 'Ciudad Real',                   74000, '13'),
-- Córdoba
('14021', 'Córdoba',                      325000, '14'),
-- A Coruña
('15030', 'A Coruña',                     245000, '15'),
('15078', 'Santiago de Compostela',        97000, '15'),
-- Cuenca
('16078', 'Cuenca',                        54000, '16'),
-- Girona
('17079', 'Girona',                       103000, '17'),
-- Granada
('18087', 'Granada',                      232000, '18'),
-- Guadalajara
('19130', 'Guadalajara',                   76000, '19'),
-- Guipúzcoa
('20069', 'Donostia-San Sebastián',       187000, '20'),
-- Huelva
('21041', 'Huelva',                       143000, '21'),
-- Huesca
('22125', 'Huesca',                        52000, '22'),
-- Jaén
('23050', 'Jaén',                         107000, '23'),
-- León
('24089', 'León',                         122000, '24'),
-- Lleida
('25120', 'Lleida',                       137000, '25'),
-- La Rioja
('26089', 'Logroño',                      152000, '26'),
-- Lugo
('27028', 'Lugo',                          98000, '27'),
-- Madrid
('28079', 'Madrid',                      3300000, '28'),
-- Málaga
('29067', 'Málaga',                       580000, '29'),
-- Murcia
('30030', 'Murcia',                       460000, '30'),
-- Navarra
('31201', 'Pamplona',                     205000, '31'),
-- Ourense
('32054', 'Ourense',                      104000, '32'),
-- Asturias
('33044', 'Oviedo',                       220000, '33'),
('33024', 'Gijón',                        271000, '33'),
-- Palencia
('34120', 'Palencia',                      78000, '34'),
-- Las Palmas
('35016', 'Las Palmas de Gran Canaria',   380000, '35'),
-- Pontevedra
('36038', 'Pontevedra',                    83000, '36'),
('36057', 'Vigo',                         295000, '36'),
-- Salamanca
('37274', 'Salamanca',                    143000, '37'),
-- Santa Cruz de Tenerife
('38038', 'Santa Cruz de Tenerife',       205000, '38'),
-- Cantabria
('39075', 'Santander',                    172000, '39'),
-- Segovia
('40155', 'Segovia',                       52000, '40'),
-- Sevilla
('41091', 'Sevilla',                      685000, '41'),
-- Soria
('42173', 'Soria',                         39000, '42'),
-- Tarragona
('43148', 'Tarragona',                    132000, '43'),
-- Teruel
('44216', 'Teruel',                        35000, '44'),
-- Toledo
('45168', 'Toledo',                        84000, '45'),
-- Valencia
('46250', 'Valencia',                     800000, '46'),
-- Valladolid
('47186', 'Valladolid',                   296000, '47'),
-- Vizcaya
('48020', 'Bilbao',                       345000, '48'),
-- Zamora
('49275', 'Zamora',                        62000, '49'),
-- Zaragoza
('50297', 'Zaragoza',                     675000, '50');

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
