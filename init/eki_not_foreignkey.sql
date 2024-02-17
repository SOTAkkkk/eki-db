-- CREATE DATABASE
DROP DATABASE `eki`;
CREATE DATABASE `eki` DEFAULT CHARACTER SET utf8mb4;
USE `eki`;

-- CREATE TABLE
-- 事業者テーブル
DROP TABLE IF EXISTS `companies`;
CREATE TABLE companies (
    company_cd INT NOT NULL,
    rr_cd INT NOT NULL,
    company_name VARCHAR(80) NOT NULL,
    company_name_k VARCHAR(80),
    company_name_h VARCHAR(80),
    company_name_r VARCHAR(80),
    company_url VARCHAR(255),
    company_type INT UNSIGNED,
    e_status INT UNSIGNED,
    e_sort INT UNSIGNED,
    PRIMARY KEY (company_cd),
    CHECK (LENGTH(company_url) = 0 OR (company_url LIKE 'http%')),
    CHECK (company_type IN (0, 1, 2, 3)),
    CHECK (e_status IN (0, 1, 2))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 路線テーブル
DROP TABLE IF EXISTS `railroad_lines`;
CREATE TABLE railroad_lines (
    line_cd INT NOT NULL,
    company_cd INT NOT NULL,
    line_name VARCHAR(80) NOT NULL,
    line_name_k VARCHAR(80),
    line_name_h VARCHAR(80),
    line_color_c VARCHAR(6),
    line_color_t VARCHAR(10),
    line_type INT,
    lon FLOAT,
    lat FLOAT,
    zoom INT,
    e_status INT,
    e_sort INT,
    PRIMARY KEY (line_cd),
    CHECK (e_status IN (0, 1, 2))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 都道府県テーブル
DROP TABLE IF EXISTS `prefectures`;
CREATE TABLE prefectures (
    pref_cd INT NOT NULL,
    pref_name VARCHAR(4) NOT NULL,
    PRIMARY KEY (pref_cd)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 駅テーブル
DROP TABLE IF EXISTS `stations`;
CREATE TABLE stations (
    station_cd INT NOT NULL,
    station_g_cd INT,
    station_name VARCHAR(80) NOT NULL,
    station_name_k VARCHAR(80),
    station_name_r VARCHAR(200),
    line_cd INT,
    pref_cd INT,
    post VARCHAR(10),
    address VARCHAR(300),
    lon FLOAT,
    lat FLOAT,
    open_ymd DATE,
    close_ymd DATE,
    e_status INT,
    e_sort INT,
    PRIMARY KEY (station_cd),
    CHECK (e_status IN (0, 1, 2))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 接続駅テーブル
DROP TABLE IF EXISTS `connected_stations`;
CREATE TABLE connected_stations (
    line_cd INT NOT NULL,
    station_cd1 INT NOT NULL,
    station_cd2 INT NOT NULL,
    PRIMARY KEY (line_cd, station_cd1, station_cd2)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Import CSV
-- 事業者CSVファイル
LOAD DATA LOCAL INFILE 'data/company20230824.csv'
INTO TABLE companies
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(company_cd,rr_cd,company_name,company_name_k,company_name_h,company_name_r,company_url,company_type,e_status,e_sort);

-- 路線CSVファイル
LOAD DATA LOCAL INFILE 'data/line20230824free.csv'
INTO TABLE railroad_lines
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(line_cd,company_cd,line_name,line_name_k,line_name_h,line_color_c,line_color_t,line_type,lon,lat,zoom,e_status,e_sort);

-- 都道府県CSVファイル
LOAD DATA LOCAL INFILE 'data/pref.csv'
INTO TABLE prefectures
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(pref_cd,pref_name);

-- 駅CSVファイル
LOAD DATA LOCAL INFILE 'data/station20230907free.csv'
INTO TABLE stations
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(station_cd,station_g_cd,station_name,station_name_k,station_name_r,line_cd,pref_cd,post,address,lon,lat,open_ymd,close_ymd,e_status,e_sort);

-- 接続駅CSVファイル
LOAD DATA LOCAL INFILE 'data/join20230907.csv'
INTO TABLE connected_stations
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(line_cd,station_cd1,station_cd2);
