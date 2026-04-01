-- ============================================================
-- VINYL VAULT - Music Store Sample Database
-- ============================================================

USE vinyl_vault;

-- ------------------------------------------------------------
-- SCHEMA
-- ------------------------------------------------------------

CREATE TABLE genres (
    id          INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(50)  NOT NULL UNIQUE,
    description VARCHAR(255)
);

CREATE TABLE artists (
    id          INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(100) NOT NULL,
    country     VARCHAR(60),
    formed_year SMALLINT,
    biography   TEXT
);

CREATE TABLE albums (
    id           INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    artist_id    INT UNSIGNED NOT NULL,
    genre_id     INT UNSIGNED NOT NULL,
    title        VARCHAR(150) NOT NULL,
    release_year SMALLINT,
    price        DECIMAL(6,2) NOT NULL,
    stock        SMALLINT     NOT NULL DEFAULT 0,
    CONSTRAINT fk_albums_artist FOREIGN KEY (artist_id) REFERENCES artists(id),
    CONSTRAINT fk_albums_genre  FOREIGN KEY (genre_id)  REFERENCES genres(id)
);

CREATE TABLE customers (
    id         INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(60)  NOT NULL,
    last_name  VARCHAR(60)  NOT NULL,
    email      VARCHAR(120) NOT NULL UNIQUE,
    city       VARCHAR(80),
    joined_at  DATE         NOT NULL DEFAULT (CURRENT_DATE)
);

CREATE TABLE orders (
    id          INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    customer_id INT UNSIGNED NOT NULL,
    ordered_at  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status      ENUM('pending','shipped','delivered','cancelled') NOT NULL DEFAULT 'pending',
    CONSTRAINT fk_orders_customer FOREIGN KEY (customer_id) REFERENCES customers(id)
);

CREATE TABLE order_items (
    id         INT UNSIGNED     AUTO_INCREMENT PRIMARY KEY,
    order_id   INT UNSIGNED     NOT NULL,
    album_id   INT UNSIGNED     NOT NULL,
    quantity   TINYINT UNSIGNED NOT NULL DEFAULT 1,
    unit_price DECIMAL(6,2)     NOT NULL,
    CONSTRAINT fk_items_order FOREIGN KEY (order_id) REFERENCES orders(id),
    CONSTRAINT fk_items_album FOREIGN KEY (album_id) REFERENCES albums(id)
);

-- ------------------------------------------------------------
-- SEED DATA
-- ------------------------------------------------------------

INSERT INTO genres (name, description) VALUES
('Rock',       'Guitar-driven music spanning classic to alternative'),
('Jazz',       'Improvisational American art form'),
('Electronic', 'Synthesizer and machine-based music'),
('Hip-Hop',    'Rhythm and poetry originating in New York'),
('Classical',  'Western art music from the common practice period'),
('Soul / R&B', 'Rhythm and blues with gospel influences');

INSERT INTO artists (name, country, formed_year, biography) VALUES
('Pink Floyd',            'UK',  1965, 'Pioneering British psychedelic and prog-rock band.'),
('Miles Davis',           'USA', 1944, 'Trumpeter and bandleader who shaped jazz history.'),
('Daft Punk',             'FR',  1993, 'French electronic duo known for futuristic house music.'),
('Kendrick Lamar',        'USA', 2003, 'Pulitzer Prize-winning rapper from Compton, CA.'),
('Nina Simone',           'USA', 1954, 'Classically trained pianist and civil rights activist.'),
('Radiohead',             'UK',  1985, 'British alternative rock band known for experimental sound.'),
('John Coltrane',         'USA', 1955, 'Influential saxophonist and composer in jazz.'),
('The Prodigy',           'UK',  1990, 'British big beat and rave act from Essex.'),
('Stevie Wonder',         'USA', 1961, 'Multi-instrumentalist Motown legend.'),
('Johann Sebastian Bach', 'DE',  1703, 'Baroque composer of unparalleled contrapuntal works.');

INSERT INTO albums (artist_id, genre_id, title, release_year, price, stock) VALUES
(1,  1, 'The Dark Side of the Moon',       1973, 24.99, 14),
(1,  1, 'Wish You Were Here',              1975, 21.99,  8),
(2,  2, 'Kind of Blue',                    1959, 19.99, 20),
(2,  2, 'Bitches Brew',                    1970, 22.99,  5),
(3,  3, 'Discovery',                       2001, 26.99, 18),
(3,  3, 'Random Access Memories',          2013, 29.99, 12),
(4,  4, 'To Pimp a Butterfly',             2015, 23.99, 10),
(4,  4, 'DAMN.',                           2017, 21.99, 15),
(5,  6, 'I Put a Spell on You',            1965, 18.99,  6),
(6,  1, 'OK Computer',                     1997, 22.99, 11),
(6,  1, 'Kid A',                           2000, 21.99,  9),
(7,  2, 'A Love Supreme',                  1965, 20.99, 16),
(8,  3, 'Music for the Jilted Generation', 1994, 18.99,  7),
(9,  6, 'Songs in the Key of Life',        1976, 27.99,  4),
(10, 5, 'The Well-Tempered Clavier',       1722, 15.99,  3);

INSERT INTO customers (first_name, last_name, email, city, joined_at) VALUES
('Alice',  'Moreau',   'alice.moreau@email.com',   'Paris',     '2023-01-15'),
('Ben',    'Hartley',  'ben.hartley@email.com',    'London',    '2023-03-02'),
('Carla',  'Vega',     'carla.vega@email.com',     'Madrid',    '2023-04-18'),
('Dmitri', 'Sokolov',  'dmitri.sokolov@email.com', 'Moscow',    '2023-06-07'),
('Emma',   'Fischer',  'emma.fischer@email.com',   'Berlin',    '2023-07-22'),
('Fabio',  'Conti',    'fabio.conti@email.com',    'Rome',      '2023-09-11'),
('Grace',  'Kim',      'grace.kim@email.com',      'Seoul',     '2024-01-03'),
('Hassan', 'Ali',      'hassan.ali@email.com',     'Cairo',     '2024-02-14'),
('Ingrid', 'Olsen',    'ingrid.olsen@email.com',   'Oslo',      '2024-03-30'),
('Jorge',  'Santos',   'jorge.santos@email.com',   'Sao Paulo', '2024-05-09');

INSERT INTO orders (customer_id, ordered_at, status) VALUES
(1,  '2024-01-10 09:15:00', 'delivered'),
(1,  '2024-03-05 14:22:00', 'delivered'),
(2,  '2024-01-20 11:00:00', 'delivered'),
(3,  '2024-02-14 16:45:00', 'shipped'),
(4,  '2024-02-28 08:30:00', 'delivered'),
(5,  '2024-03-15 10:10:00', 'delivered'),
(6,  '2024-04-01 13:00:00', 'pending'),
(7,  '2024-04-10 09:45:00', 'shipped'),
(8,  '2024-05-01 12:30:00', 'delivered'),
(9,  '2024-05-20 15:00:00', 'cancelled'),
(10, '2024-06-01 11:11:00', 'delivered'),
(2,  '2024-06-15 14:00:00', 'pending');

INSERT INTO order_items (order_id, album_id, quantity, unit_price) VALUES
(1,  1,  1, 24.99),
(1,  3,  1, 19.99),
(2,  6,  1, 29.99),
(3,  5,  2, 26.99),
(4,  7,  1, 23.99),
(4,  9,  1, 18.99),
(5,  12, 1, 20.99),
(6,  10, 1, 22.99),
(6,  11, 1, 21.99),
(7,  4,  1, 22.99),
(8,  8,  1, 21.99),
(9,  2,  1, 21.99),
(9,  13, 1, 18.99),
(10, 14, 1, 27.99),
(11, 15, 2, 15.99),
(12, 6,  1, 29.99),
(12, 5,  1, 26.99);
