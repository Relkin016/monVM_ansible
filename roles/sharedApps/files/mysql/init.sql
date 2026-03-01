-- Создаем базу данных, если она еще не создана
CREATE DATABASE IF NOT EXISTS db;
USE db;

-- Создаем таблицу test с 3 основными полями данных (плюс id)
CREATE TABLE IF NOT EXISTS test (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    role VARCHAR(50) NOT NULL,
    status VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Наполняем таблицу 5 тестовыми записями
INSERT INTO test (name, role, status) VALUES 
('Yaroslav', 'Administrator', 'active'),
('Relkin016', 'DevOps Engineer', 'online'),
('Andrey_Instructor', 'Tech Lead', 'busy'),
('Guest_User', 'Viewer', 'offline'),
('System_Bot', 'Monitor', 'active');
