create schema MusicCollab;

CREATE TABLE user (
    user_id INT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(255) NOT NULL UNIQUE,
    date_of_birth DATE,
    gender_code INT
);

CREATE INDEX idx_username ON user (username);

CREATE TABLE subscription (
    subscription_id INT PRIMARY KEY,
    interval_unit VARCHAR(50) NOT NULL,
    plan VARCHAR(50) NOT NULL
);

ALTER TABLE subscription MODIFY COLUMN interval_unit VARCHAR(50) NULL;


CREATE TABLE workspace (
    workspace_id INT PRIMARY KEY,
    workspace_name VARCHAR(250) NOT NULL,
    subscription_id INT,
    owner_id INT NOT NULL,
    created_at DATETIME NOT NULL,
    deleted_at DATETIME,
    FOREIGN KEY (owner_id)
        REFERENCES user (user_id),
    FOREIGN KEY (subscription_id)
        REFERENCES subscription (subscription_id)
);
ALTER TABLE workspace MODIFY COLUMN subscription_id int Not NULL;
CREATE TABLE invoice (
    invoice_id INT PRIMARY KEY,
    workspace_id INT NOT NULL,
    status VARCHAR(50) NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    FOREIGN KEY (workspace_id)
        REFERENCES workspace (workspace_id)
);

alter table invoice add column amount int not null;
alter table invoice add column currency varchar(10) not null;

CREATE TABLE user_workspace_mapping (
    user_id INT,
    workspace_id INT,
    joined_at DATETIME NOT NULL,
    left_at DATETIME,
    status VARCHAR(50) NOT NULL,
    role VARCHAR(50),
    PRIMARY KEY (user_id , workspace_id),
    FOREIGN KEY (user_id)
        REFERENCES user (user_id),
    FOREIGN KEY (workspace_id)
        REFERENCES workspace (workspace_id)
);

CREATE TABLE project (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(255) NOT NULL,
    saved_status INT,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    deleted_at DATETIME,
    workspace_id INT NOT NULL,
    FOREIGN KEY (workspace_id)
        REFERENCES workspace (workspace_id)
);

CREATE TABLE album (
    album_id INT PRIMARY KEY,
    album_name VARCHAR(255) NOT NULL,
    cover_photo_url VARCHAR(255),
    published_at DATETIME,
    unpublished_at DATETIME,
    published_status VARCHAR(100)
);

CREATE TABLE track (
    track_id INT PRIMARY KEY,
    track_name VARCHAR(255) NOT NULL,
    project_id INT NOT NULL,
    album_id INT,
    cover_photo_url VARCHAR(255),
    published_at DATETIME,
    unpublished_at DATETIME,
    published_status VARCHAR(100),
    FOREIGN KEY (project_id)
        REFERENCES project (project_id),
    FOREIGN KEY (album_id)
        REFERENCES album (album_id)
);

CREATE TABLE album_user_mapping (
    album_id INT,
    user_id INT,
    FOREIGN KEY (album_id)
        REFERENCES album (album_id),
    FOREIGN KEY (user_id)
        REFERENCES user (user_id),
    PRIMARY KEY (album_id , user_id)
);

CREATE TABLE recording (
    recording_id INT PRIMARY KEY,
    recoridng_name VARCHAR(255),
    recording_status INT,
    recording_url VARCHAR(500),
    project_id INT NOT NULL,
    start_time TIMESTAMP,
    end_time TIMESTAMP,
    volume INT,
    FOREIGN KEY (project_id)
        REFERENCES project (project_id)
);

CREATE TABLE effect (
    effect_id INT PRIMARY KEY,
    effect_name VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE recording_effect_mapping (
    recording_id INT,
    effect_id INT,
    FOREIGN KEY (recording_id)
        REFERENCES recording (recording_id),
    FOREIGN KEY (effect_id)
        REFERENCES effect (effect_id),
    PRIMARY KEY (recording_id , effect_id)
);

INSERT INTO user (user_id, username, first_name, last_name, email, date_of_birth, gender_code)
VALUES
    (654647897, 'eminem', 'Marshall', 'Mathers', 'eminem@shady.com', '1972-10-17', 1),
	(656667686, 'sade', 'Sade', 'Adu', 'sade@music.com', '1959-01-16', 2),
    (697071727, 'erykahbadu', 'Erykah', 'Badu', 'erykahbadu@music.com', '1971-02-26', 2),
    (737475767, 'mobbdeep', 'Mobb', 'Deep', 'mobbdeep@music.com', '1974-04-05', 1),
    (778081828, 'ledzeppelin', 'Led', 'Zeppelin', 'ledzeppelin@music.com', '1968-09-25', 1),
    (838485868, 'icecube', 'Ice', 'Cube', 'icecube@music.com', '1969-06-15', 1),
    (878889909, 'nasirjones', 'Nasir', 'Jones', 'nasirjones@music.com', '1973-09-14', 1),
    (919293949, 'outkast', 'OutKast', '', 'outkast@music.com', '1975-05-29', 1),
    (959697989, 'beastieboys', 'Beastie', 'Boys', 'beastieboys@music.com', '1961-06-14', 1),
    (991001011, 'pinkfloyd', 'Pink', 'Floyd', 'pinkfloyd@music.com', '1965-12-28', 1),
    (102103104, 'thebeatles', 'The', 'Beatles', 'thebeatles@music.com', '1940-10-09', 1),
    (108109110, 'rollingstones', 'Rolling', 'Stones', 'rollingstones@music.com', '1943-07-26', 1),
    (111112113, 'kendricklamar', 'Kendrick', 'Lamar', 'kendricklamar@music.com', '1987-06-17', 1),
    (114115116, 'jayz', 'Jay', 'Z', 'jayz@music.com', '1969-12-04', 1),
    (120121122, 'drdre', 'Dr.', 'Dre', 'drdre@music.com', '1965-02-18', 1),
    (123124125, 'davidbowie', 'David', 'Bowie', 'davidbowie@music.com', '1947-01-08', 1),
    (126127128, 'queenband', 'Queen', '', 'queenband@music.com', '1946-09-05', 1),
    (129130131, 'elvispresley', 'Elvis', 'Presley', 'elvispresley@music.com', '1935-01-08', 1),
    (132133134, 'acdc', 'AC/DC', '', 'acdc@music.com', '1955-07-09', 1),
    (123456780, 'ladygaga', 'Stefani', 'Germanotta', 'ladygaga@music.com', '1986-03-28', 2),
    (987654321, 'johnlegend', 'John', 'Stephens', 'johnlegend@gmail.com', '1978-12-28', 1),
    (121314151, 'shakira', 'Shakira', 'Mebarak', 'shakira@music.com', '1977-02-02', 2),
    (161718192, 'justinbieber', 'Justin', 'Bieber', 'justinbieber@music.com', '1994-03-01', 1),
    (202122232, 'arianagrande', 'Ariana', 'Grande', 'arianagrande@music.com', '1993-06-26', 2),
    (252627282, 'katyperry', 'Katy', 'Perry', 'katyperry@music.com', '1984-10-25', 2),
    (293031323, 'drake', 'Drake', 'Graham', 'drake@music.com', '1986-10-24', 1),
    (333435363, 'beyonce', 'Beyoncé', 'Knowles', 'beyonce@music.com', '1981-09-04', 2),
    (373839404, 'rihanna', 'Rihanna', 'Fenty', 'rihanna@music.com', '1988-02-20', 2),
    (414243444, 'selenagomez', 'Selena', 'Gomez', 'selenagomez@music.com', '1992-07-22', 2),
    (454647484, 'usher', 'Usher', 'Raymond', 'usher@music.com', '1978-10-14', 1),
    (495051525, 'nickiminaj', 'Nicki', 'Minaj', 'nickiminaj@music.com', '1982-12-08', 2),
    (535455565, 'maroon5', 'Adam', 'Levine', 'adam@maroon5.com', '1979-03-18', 1),
    (575859606, 'taylorgang', 'Wiz', 'Khalifa', 'wizkhalifa@music.com', '1987-09-08', 1);


INSERT INTO subscription (subscription_id, interval_unit, plan)
VALUES
    (0, null, 'Basic'),
    (1, 'Yearly', 'Premium'),
    (2, 'Monthly', 'Premium');


INSERT INTO workspace (workspace_id, workspace_name, subscription_id, owner_id, created_at, deleted_at)
VALUES
    (465465133, 'Sade and Drake Collaboration', 1, 656667686, '2020-12-06', NULL),
    (465465134, 'Erykah Badu and Rihanna Project', 1, 697071727, '2023-12-07', NULL),
    (465465135, 'Mobb Deep Studio Sessions', 1, 737475767, '2022-12-08', NULL),
    (465465136, 'Led Zeppelin Greatest Hits Remaster', 1, 778081828, '2023-12-09', NULL),
    (465465137, 'Ice Cube and Beyoncé Melody Fusion', 1, 838485868, '2023-12-10', NULL),
    (465465138, 'Nasir Jones Album Experiment', 1, 878889909, '2021-12-11', NULL),
    (465465139, 'OutKast Collaborative Workspace', 1, 919293949, '2023-12-12', NULL),
    (465465140, 'Beastie Boys Mixtape Production', 1, 959697989, '2023-12-13', NULL),
    (465465141, 'Pink Floyd Reunion Project', 1, 991001011, '2023-12-14', '2023-12-20'),
    (465465142, 'The Beatles Unreleased Tracks', 1, 102103104, '2023-12-15', NULL),
    (465465143, 'Rolling Stones Legacy Compilation', 1, 108109110, '2023-12-16', NULL),
    (465465144, 'Kendrick Lamar Studio 2023', 1, 111112113, '2022-12-17', NULL),
    (465465145, 'Jay-Z and Nicki Minaj Rap Summit', 1, 114115116, '2023-12-18', NULL),
    (465465146, 'Dr. Dre Music Production Hub', 1, 120121122, '2020-12-19', NULL),
    (465465147, 'David Bowie Tribute Project', 1, 123124125, '2023-12-20', NULL),
    (465465148, 'Queen Band Collaboration Center', 1, 126127128, '2020-12-21', '2023-12-21'),
    (465465149, 'Elvis Presley Remastered Tracks', 1, 129130131, '2023-12-22', NULL),
    (465465150, 'AC/DC Rock Legends Gathering', 1, 132133134, '2020-12-23', NULL),
    (465465151, 'Lady Gaga and Usher Performance', 1, 123456780, '2023-12-24', NULL),
    (465465152, 'John Legend Soulful Creations', 1, 987654321, '2023-12-25', NULL),
    (465465153, 'Shakira Latin Music Showcase', 1, 121314151, '2023-12-26', NULL);

UPDATE workspace
SET subscription_id = 0
WHERE owner_id IN (123456780, 987654321);


INSERT INTO invoice (invoice_id, workspace_id, status, payment_method, amount, currency)
VALUES
    (753951852, 465465133, 'paid', 'PayPal', 200, 'USD'),
    (753951853, 465465134, 'pending', 'credit card', 200, 'USD'),
    (753951854, 465465150, 'paid', 'PayPal', 150, 'USD'),
    (753951855, 465465136, 'pending', 'credit card', 250, 'USD'),
    (753951856, 465465137, 'pending', 'credit card', 300, 'USD'),
    (753951857, 465465143, 'paid', 'PayPal', 180, 'USD'),
    (753951858, 465465139, 'pending', 'credit card', 220, 'USD'),
    (753951859, 465465140, 'paid', 'PayPal', 170, 'USD'),
    (753951860, 465465141, 'paid', 'PayPal', 270, 'USD'),
    (753951861, 465465142, 'pending', 'credit card', 190, 'USD'),
    (753951862, 465465143, 'paid', 'PayPal', 210, 'USD'),
    (753951863, 465465144, 'pending', 'credit card', 160, 'USD'),
    (753951864, 465465133, 'paid', 'PayPal', 240, 'USD'),
    (753951865, 465465146, 'paid', 'PayPal', 280, 'USD'),
    (753951866, 465465147, 'pending', 'credit card', 300, 'USD'),
    (753951867, 465465148, 'pending', 'credit card', 200, 'USD'),
    (753951868, 465465149, 'paid', 'PayPal', 220, 'USD'),
    (753951869, 465465150, 'paid', 'PayPal', 260, 'USD'),
    (753951870, 465465151, 'pending', 'credit card', 180, 'USD'),
    (753951871, 465465152, 'paid', 'PayPal', 190, 'USD'),
    (753951872, 465465133, 'pending', 'credit card', 250, 'USD');


INSERT INTO user_workspace_mapping (user_id, workspace_id, joined_at, left_at, status, role)
VALUES
    -- Sade and Drake Collaboration workspace
    (656667686, 465465133, '2020-12-06', NULL, 'active', 'singer'), -- Sade
    (293031323, 465465133, '2020-12-06', '2021-12-06', 'inactive', 'singer'), -- Drake

    -- Erykah Badu and Rihanna Project workspace
    (697071727, 465465134, '2023-12-07', NULL, 'active', 'singer'), -- Erykah Badu
    -- Add more instances for other users in the Erykah Badu and Rihanna Project workspace
    
    -- Mobb Deep Studio Sessions workspace
    (737475767, 465465135, '2022-12-08', NULL, 'active', 'singer'), -- Mobb Deep
    -- Add more instances for other users in the Mobb Deep Studio Sessions workspace
    
    -- Led Zeppelin Greatest Hits Remaster workspace
    (778081828, 465465136, '2023-12-09', NULL, 'active', 'singer'), -- Led Zeppelin
    -- Add more instances for other users in the Led Zeppelin Greatest Hits Remaster workspace
    
    -- Ice Cube and Beyoncé Melody Fusion workspace
    (838485868, 465465137, '2023-12-10', NULL, 'active', 'singer'), -- Ice Cube
    -- Add more instances for other users in the Ice Cube and Beyoncé Melody Fusion workspace
    
    -- Nasir Jones Album Experiment workspace
    (878889909, 465465138, '2021-12-11', NULL, 'active', 'singer'), -- Nasir Jones
    -- Add more instances for other users in the Nasir Jones Album Experiment workspace
    
    -- OutKast Collaborative Workspace
    (919293949, 465465139, '2023-12-12', NULL, 'active', 'singer'), -- OutKast
    -- Add more instances for other users in the OutKast Collaborative Workspace
    
    -- Beastie Boys Mixtape Production workspace
    (959697989, 465465140, '2023-12-13', NULL, 'active', 'singer'), -- Beastie Boys
    -- Add more instances for other users in the Beastie Boys Mixtape Production workspace
    
    -- Pink Floyd Reunion Project workspace
    (991001011, 465465141, '2023-12-14', '2023-12-20', 'inactive', 'singer'), -- Pink Floyd
    -- Add more instances for other users in the Pink Floyd Reunion Project workspace
    
    -- The Beatles Unreleased Tracks workspace
    (102103104, 465465142, '2023-12-15', NULL, 'active', 'singer'), -- The Beatles
    -- Add more instances for other users in The Beatles Unreleased Tracks workspace
    
    -- Rolling Stones Legacy Compilation workspace
    (108109110, 465465143, '2023-12-16', NULL, 'active', 'singer'), -- Rolling Stones
    -- Add more instances for other users in the Rolling Stones Legacy Compilation workspace
    
    -- Kendrick Lamar Studio 2023 workspace
    (111112113, 465465144, '2022-12-17', NULL, 'active', 'singer'), -- Kendrick Lamar
    -- Add more instances for other users in the Kendrick Lamar Studio 2023 workspace
    
    -- Jay-Z and Nicki Minaj Rap Summit workspace
    (114115116, 465465145, '2023-12-18', NULL, 'active', 'singer'), -- Jay-Z
    -- Add more instances for other users in the Jay-Z and Nicki Minaj Rap Summit workspace
    
    -- Dr. Dre Music Production Hub workspace
    (120121122, 465465146, '2020-12-19', NULL, 'active', 'singer'), -- Dr. Dre
    -- Add more instances for other users in the Dr. Dre Music Production Hub workspace
    
    -- David Bowie Tribute Project workspace
    (123124125, 465465147, '2023-12-20', NULL, 'active', 'singer'), -- David Bowie
    -- Add more instances for other users in the David Bowie Tribute Project workspace
    
    -- Queen Band Collaboration Center workspace
    (126127128, 465465148, '2020-12-21', '2023-12-21', 'inactive', 'singer'), -- Queen Band
    -- Add more instances for other users in the Queen Band Collaboration Center workspace
    
    -- Elvis Presley Remastered Tracks workspace
    (129130131, 465465149, '2023-12-22', NULL, 'active', 'singer'), -- Elvis Presley
    -- Add more instances for other users in the Elvis Presley Remastered Tracks workspace
    
    -- AC/DC Rock Legends Gathering workspace
    (132133134, 465465150, '2020-12-23', NULL, 'active', 'singer'), -- AC/DC
    -- Add more instances for other users in the AC/DC Rock Legends Gathering workspace
    
    -- Lady Gaga and Usher Performance workspace
    (123456780, 465465151, '2023-12-24', NULL, 'active', 'singer'), -- Lady Gaga
    -- Add more instances for other users in the Lady Gaga and Usher Performance workspace
    
    -- John Legend Soulful Creations workspace
    (987654321, 465465152, '2023-12-25', NULL, 'active', 'singer'), -- John Legend
    -- Add more instances for other users in the John Legend Soulful Creations workspace
    
    -- Shakira Latin Music Showcase workspace
    (121314151, 465465153, '2023-12-26', NULL, 'active', 'singer'); -- Shakira
    -- Add more instances for other users in the Shakira Latin Music Showcase workspace
    
    INSERT INTO effect (effect_id, effect_name) VALUES
    (1, 'Echo'),
    (2, 'Reverb'),
    (3, 'Chorus'),
    (4, 'Flanger'),
    (5, 'Phaser'),
    (6, 'Delay'),
    (7, 'Distortion'),
    (8, 'Compression'),
    (9, 'Tremolo'),
    (10, 'Wah-Wah');
    
INSERT INTO project (project_id, project_name, saved_status, created_at, updated_at, deleted_at, workspace_id) VALUES
    (1, 'No Ordinary Love', 100, '2023-12-06', '2023-12-06', NULL, 465465133),
    (2, 'Love on the Brain', 100, '2023-12-07', '2023-12-07', NULL, 465465134),
    (3, 'Shook Ones, Pt. II', 100, '2023-12-08', '2023-12-08', NULL, 465465135),
    (4, 'Stairway to Heaven', 100, '2023-12-09', '2023-12-09', NULL, 465465136),
    (5, 'Crazy in Love', 100, '2023-12-10', '2023-12-10', NULL, 465465137),
    (6, 'The Message', 0, '2023-12-11', '2023-12-11', NULL, 465465138),
    (7, 'Ms. Jackson', 100, '2023-12-12', '2023-12-12', NULL, 465465139),
    (8, 'Intergalactic', 0, '2023-12-13', '2023-12-13', NULL, 465465140),
    (9, 'Comfortably Numb', 100, '2023-12-14', '2023-12-14', '2023-12-20', 465465141),
    (10, 'Here Comes the Sun', 100, '2023-12-15', '2023-12-15', NULL, 465465142),
    (11, 'Paint It Black', 0, '2023-12-16', '2023-12-16', NULL, 465465143),
    (12, 'HUMBLE.', 100, '2023-12-17', '2023-12-17', NULL, 465465144),
    (13, 'Monster', 100, '2023-12-18', '2023-12-18', NULL, 465465145),
    (14, 'Still D.R.E.', 100, '2023-12-19', '2023-12-19', NULL, 465465146),
    (15, 'Space Oddity', 100, '2023-12-20', '2023-12-20', NULL, 465465147);

INSERT INTO album (album_id, album_name, cover_photo_url, published_at, unpublished_at, published_status) VALUES
    (1, 'Love Deluxe', 'https://example.com/love_deluxe.jpg', '2023-12-06 12:00:00', NULL, 'published'),
    (2, 'Anti', 'https://example.com/anti_album.jpg', '2023-12-07 13:30:00', NULL, 'published'),
    (3, 'The Infamous', 'https://example.com/the_infamous.jpg', '2023-12-08 15:45:00', NULL, 'published'),
    (4, 'Led Zeppelin IV', 'https://example.com/led_zeppelin_iv.jpg', '2023-12-09 09:20:00', NULL, 'published'),
    (5, 'Dangerously in Love', 'https://example.com/dangerously_in_love.jpg', '2023-12-10 18:00:00', NULL, 'published'),
    (6, 'It Takes a Nation of Millions to Hold Us Back', 'https://example.com/it_takes_a_nation.jpg', '2023-12-11 14:10:00', NULL, 'published'),
    (7, 'Stankonia', 'https://example.com/stankonia.jpg', '2023-12-12 11:25:00', NULL, 'published'),
    (8, 'Hello Nasty', 'https://example.com/hello_nasty.jpg', '2023-12-13 10:45:00', NULL, 'published'),
    (9, 'The Wall', 'https://example.com/the_wall.jpg', '2023-12-14 08:30:00', '2023-12-20 17:00:00', 'unpublished'),
    (10, 'Abbey Road', 'https://example.com/abbey_road.jpg', '2023-12-15 19:55:00', NULL, 'published'),
    (11, 'Aftermath', 'https://example.com/aftermath.jpg', '2023-12-16 22:40:00', NULL, 'published'),
    (12, 'DAMN.', 'https://example.com/damn.jpg', '2023-12-17 07:00:00', NULL, 'published'),
    (13, 'The Fame Monster', 'https://example.com/fame_monster.jpg', '2023-12-18 16:20:00', NULL, 'published'),
    (14, '2001', 'https://example.com/2001_album.jpg', '2023-12-19 13:15:00', NULL, 'published'),
    (15, 'Space Oddity', 'https://example.com/space_oddity.jpg', '2023-12-20 09:30:00', NULL, 'published');

INSERT INTO track (track_id, track_name, project_id, album_id, cover_photo_url, published_at, unpublished_at, published_status) VALUES
    (1, 'No Ordinary Love', 1, 1, 'https://example.com/track1_cover.jpg', '2023-12-06 12:00:00', NULL, 'published'),
    (2, 'Love on the Brain', 2, 2, 'https://example.com/track2_cover.jpg', '2023-12-07 13:30:00', NULL, 'published'),
    (3, 'Shook Ones, Pt. II', 3, 3, 'https://example.com/track3_cover.jpg', '2023-12-08 15:45:00', NULL, 'published'),
    (4, 'Stairway to Heaven', 4, 4, 'https://example.com/track4_cover.jpg', '2023-12-09 09:20:00', NULL, 'published'),
    (5, 'Crazy in Love', 5, 5, 'https://example.com/track5_cover.jpg', '2023-12-10 18:00:00', NULL, 'published'),
    (6, 'The Message', 6, 6, 'https://example.com/track6_cover.jpg', '2023-12-11 14:10:00', NULL, 'unpublished'),
    (7, 'Ms. Jackson', 7, 7, 'https://example.com/track7_cover.jpg', '2023-12-12 11:25:00', NULL, 'published'),
    (8, 'Intergalactic', 8, 8, 'https://example.com/track8_cover.jpg', '2023-12-13 10:45:00', NULL, 'unpublished'),
    (9, 'Comfortably Numb', 9, 9, 'https://example.com/track9_cover.jpg', '2023-12-14 08:30:00', '2023-12-20 17:00:00', 'unpublished'),
    (10, 'Here Comes the Sun', 10, 10, 'https://example.com/track10_cover.jpg', '2023-12-15 19:55:00', NULL, 'published'),
    (11, 'Paint It Black', 11, 11, 'https://example.com/track11_cover.jpg', '2023-12-16 22:40:00', NULL, 'published'),
    (12, 'HUMBLE.', 12, 12, 'https://example.com/track12_cover.jpg', '2023-12-17 07:00:00', NULL, 'published'),
    (13, 'Monster', 13, 13, 'https://example.com/track13_cover.jpg', '2023-12-18 16:20:00', NULL, 'published'),
    (14, 'Still D.R.E.', 14, 14, 'https://example.com/track14_cover.jpg', '2023-12-19 13:15:00', NULL, 'published'),
    (15, 'Space Oddity', 15, 15, 'https://example.com/track15_cover.jpg', '2023-12-20 09:30:00', NULL, 'published');

INSERT INTO album_user_mapping (album_id, user_id) VALUES
    (1, 656667686),
    (2, 697071727),
    (3, 737475767),
    (4, 778081828),
    (5, 838485868),
    (6, 878889909),
    (7, 919293949),
    (8, 959697989),
    (9, 123124125),
    (10, 102103104),
    (11, 108109110),
    (12, 111112113),
    (13, 114115116),
    (14, 120121122),
    (15, 123124125),
    (1, 987654321),
    (2, 121314151),
    (3, 161718192),
    (4, 202122232),
    (5, 252627282),
    (6, 293031323),
    (7, 333435363),
    (8, 373839404),
    (9, 414243444),
    (10, 454647484),
    (11, 495051525),
    (12, 535455565),
    (13, 575859606);
    
    
INSERT INTO recording (recording_id, recoridng_name, recording_status, recording_url, project_id, start_time, end_time, volume) VALUES
    (1, 'Recording 1 for No Ordinary Love', 100, 'https://example.com/recording1.mp3', 1, '2023-12-06 08:00:00', '2023-12-06 09:00:00', 75),
    (2, 'Recording 2 for No Ordinary Love', 100, 'https://example.com/recording2.mp3', 1, '2023-12-06 10:00:00', '2023-12-06 11:30:00', 80),
    (3, 'Recording 1 for Love on the Brain', 100, 'https://example.com/recording3.mp3', 2, '2023-12-07 09:00:00', '2023-12-07 10:45:00', 85),
    (4, 'Recording 2 for Love on the Brain', 100, 'https://example.com/recording4.mp3', 2, '2023-12-07 12:00:00', '2023-12-07 13:30:00', 90),
    (5, 'Recording 1 for Shook Ones, Pt. II', 100, 'https://example.com/recording5.mp3', 3, '2023-12-08 11:00:00', '2023-12-08 12:15:00', 95),
    (6, 'Recording 2 for Shook Ones, Pt. II', 100, 'https://example.com/recording6.mp3', 3, '2023-12-08 14:00:00', '2023-12-08 15:45:00', 85),
    (7, 'Recording 1 for Stairway to Heaven', 100, 'https://example.com/recording7.mp3', 4, '2023-12-09 08:30:00', '2023-12-09 09:45:00', 80),
    (8, 'Recording 2 for Stairway to Heaven', 100, 'https://example.com/recording8.mp3', 4, '2023-12-09 10:30:00', '2023-12-09 11:45:00', 75),
    (9, 'Recording 1 for Crazy in Love', 100, 'https://example.com/recording9.mp3', 5, '2023-12-10 09:00:00', '2023-12-10 10:15:00', 70),
    (10, 'Recording 2 for Crazy in Love', 100, 'https://example.com/recording10.mp3', 5, '2023-12-10 11:30:00', '2023-12-10 12:45:00', 65),
    (11, 'Recording 1 for The Message', 0, 'https://example.com/recording11.mp3', 6, '2023-12-11 13:00:00', '2023-12-11 14:15:00', 60),
    (12, 'Recording 2 for The Message', 0, 'https://example.com/recording12.mp3', 6, '2023-12-11 15:30:00', '2023-12-11 16:45:00', 55),
    (13, 'Recording 1 for Ms. Jackson', 100, 'https://example.com/recording13.mp3', 7, '2023-12-12 10:00:00', '2023-12-12 11:15:00', 50),
    (14, 'Recording 2 for Ms. Jackson', 100, 'https://example.com/recording14.mp3', 7, '2023-12-12 12:30:00', '2023-12-12 13:45:00', 45),
    (15, 'Recording 1 for Intergalactic', 0, 'https://example.com/recording15.mp3', 8, '2023-12-13 14:00:00', '2023-12-13 15:15:00', 40),
    (16, 'Recording 2 for Intergalactic', 0, 'https://example.com/recording16.mp3', 8, '2023-12-13 16:30:00', '2023-12-13 17:45:00', 35),
    (17, 'Recording 1 for Comfortably Numb', 100, 'https://example.com/recording17.mp3', 9, '2023-12-14 11:00:00', '2023-12-14 12:15:00', 30),
    (18, 'Recording 2 for Comfortably Numb', 100, 'https://example.com/recording18.mp3', 9, '2023-12-14 13:30:00', '2023-12-14 14:45:00', 25),
    (19, 'Recording 1 for Here Comes the Sun', 100, 'https://example.com/recording19.mp3', 10, '2023-12-15 08:00:00', '2023-12-15 09:15:00', 20),
    (20, 'Recording 2 for Here Comes the Sun', 100, 'https://example.com/recording20.mp3', 10, '2023-12-15 10:30:00', '2023-12-15 11:45:00', 15),
    (21, 'Recording 1 for Paint It Black', 0, 'https://example.com/recording21.mp3', 11, '2023-12-16 12:00:00', '2023-12-16 13:15:00', 10),
    (22, 'Recording 2 for Paint It Black', 0, 'https://example.com/recording22.mp3', 11, '2023-12-16 14:30:00', '2023-12-16 15:45:00', 5),
    (23, 'Recording 1 for HUMBLE.', 100, 'https://example.com/recording23.mp3', 12, '2023-12-17 09:00:00', '2023-12-17 10:15:00', 80),
    (24, 'Recording 2 for HUMBLE.', 100, 'https://example.com/recording24.mp3', 12, '2023-12-17 11:30:00', '2023-12-17 12:45:00', 75),
    (25, 'Recording 1 for Monster', 100, 'https://example.com/recording25.mp3', 13, '2023-12-18 13:00:00', '2023-12-18 14:15:00', 70),
    (26, 'Recording 2 for Monster', 100, 'https://example.com/recording26.mp3', 13, '2023-12-18 15:30:00', '2023-12-18 16:45:00', 65),
    (27, 'Recording 1 for Still D.R.E.', 100, 'https://example.com/recording27.mp3', 14, '2023-12-19 10:00:00', '2023-12-19 11:15:00', 60),
    (28, 'Recording 2 for Still D.R.E.', 100, 'https://example.com/recording28.mp3', 14, '2023-12-19 12:30:00', '2023-12-19 13:45:00', 55),
    (29, 'Recording 1 for Space Oddity', 100, 'https://example.com/recording29.mp3', 15, '2023-12-20 14:00:00', '2023-12-20 15:15:00', 50),
    (30, 'Recording 2 for Space Oddity', 100, 'https://example.com/recording30.mp3', 15, '2023-12-20 16:30:00', '2023-12-20 17:45:00', 45);


INSERT INTO recording_effect_mapping (recording_id, effect_id) VALUES
    (1, 1),  -- Recording 1 for No Ordinary Love has Echo effect
    (2, 2),  -- Recording 2 for No Ordinary Love has Reverb effect
    (3, 3),  -- Recording 1 for Love on the Brain has Chorus effect
    (4, 4),  -- Recording 2 for Love on the Brain has Flanger effect
    (5, 5),  -- Recording 1 for Shook Ones, Pt. II has Phaser effect
    (6, 6),  -- Recording 2 for Shook Ones, Pt. II has Delay effect
    (7, 7),  -- Recording 1 for Stairway to Heaven has Distortion effect
    (8, 8),  -- Recording 2 for Stairway to Heaven has Compression effect
    (9, 9),  -- Recording 1 for Crazy in Love has Tremolo effect
    (10, 10), -- Recording 2 for Crazy in Love has Wah-Wah effect
    (11, 1), -- Recording 1 for The Message has Echo effect
    (12, 2), -- Recording 2 for The Message has Reverb effect
    (13, 3), -- Recording 1 for Ms. Jackson has Chorus effect
    (14, 4), -- Recording 2 for Ms. Jackson has Flanger effect
    (15, 5), -- Recording 1 for Intergalactic has Phaser effect
    (16, 6), -- Recording 2 for Intergalactic has Delay effect
    (17, 7), -- Recording 1 for Comfortably Numb has Distortion effect
    (18, 8), -- Recording 2 for Comfortably Numb has Compression effect
    (19, 9), -- Recording 1 for Here Comes the Sun has Tremolo effect
    (20, 10),-- Recording 2 for Here Comes the Sun has Wah-Wah effect
    (21, 1), -- Recording 1 for Paint It Black has Echo effect
    (22, 2), -- Recording 2 for Paint It Black has Reverb effect
    (23, 3), -- Recording 1 for HUMBLE. has Chorus effect
    (24, 4), -- Recording 2 for HUMBLE. has Flanger effect
    (25, 5), -- Recording 1 for Monster has Phaser effect
    (26, 6), -- Recording 2 for Monster has Delay effect
    (27, 7), -- Recording 1 for Still D.R.E. has Distortion effect
    (28, 8), -- Recording 2 for Still D.R.E. has Compression effect
    (29, 9), -- Recording 1 for Space Oddity has Tremolo effect
    (30, 10);-- Recording 2 for Space Oddity has Wah-Wah effect
