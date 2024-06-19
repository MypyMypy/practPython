SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

CREATE DATABASE IF NOT EXISTS itmo_db;

USE itmo_db;

CREATE TABLE borrowers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    inn VARCHAR(12) NOT NULL,
    bin VARCHAR(12),
    entity_type ENUM('individual', 'organization') NOT NULL,
    address VARCHAR(255),
    total_amount DECIMAL(15, 2),
    terms TEXT,
    legal_notes TEXT,
    contract_list TEXT
);

INSERT INTO borrowers (inn, bin, entity_type, address, total_amount, terms, legal_notes, contract_list) VALUES
('123456789012', NULL, 'individual', '123 Main St, City, Country', 100000.00, 'Standard Terms', 'No legal notes', 'Contract1, Contract2'),
('987654321098', NULL, 'individual', '456 Elm St, City, Country', 200000.00, 'Premium Terms', 'No legal notes', 'Contract3, Contract4'),
('234567890123', NULL, 'individual', '789 Oak St, City, Country', 150000.00, 'Basic Terms', 'No legal notes', 'Contract5, Contract6'),
('345678901234', NULL, 'individual', '101 Pine St, City, Country', 250000.00, 'Standard Terms', 'No legal notes', 'Contract7, Contract8'),
('456789012345', NULL, 'individual', '202 Maple St, City, Country', 300000.00, 'Premium Terms', 'No legal notes', 'Contract9, Contract10');

CREATE TABLE individuals (
    id INT AUTO_INCREMENT PRIMARY KEY,
    borrower_id INT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    inn VARCHAR(12) NOT NULL,
    FOREIGN KEY (borrower_id) REFERENCES borrowers(id)
);

INSERT INTO individuals (borrower_id, first_name, last_name, inn) VALUES
(1, 'John', 'Doe', '123456789012'),
(2, 'Jane', 'Smith', '987654321098'),
(3, 'Alice', 'Johnson', '234567890123'),
(4, 'Bob', 'Brown', '345678901234'),
(5, 'Charlie', 'Davis', '456789012345');

CREATE TABLE loans (
    id INT AUTO_INCREMENT PRIMARY KEY,
    individual_id INT NOT NULL,
    borrower_id INT,
    amount DECIMAL(15, 2) NOT NULL,
    interest_rate DECIMAL(5, 2) NOT NULL,
    term INT NOT NULL,
    FOREIGN KEY (individual_id) REFERENCES individuals(id),
    FOREIGN KEY (borrower_id) REFERENCES borrowers(id)
);

INSERT INTO loans (individual_id, borrower_id, amount, interest_rate, term) VALUES
(1, 1, 10000.00, 5.00, 12),
(2, 2, 20000.00, 4.50, 24),
(3, 3, 15000.00, 4.75, 18),
(4, 4, 25000.00, 5.25, 36),
(5, 5, 30000.00, 5.00, 48);

CREATE TABLE organization_loans (
    id INT AUTO_INCREMENT PRIMARY KEY,
    organization_id INT NOT NULL,
    individual_id INT NOT NULL,
    borrower_id INT,
    amount DECIMAL(15, 2) NOT NULL,
    term INT NOT NULL,
    FOREIGN KEY (individual_id) REFERENCES individuals(id),
    FOREIGN KEY (borrower_id) REFERENCES borrowers(id)
);

INSERT INTO organization_loans (organization_id, individual_id, borrower_id, amount, term) VALUES
(1, 1, 1, 50000.00, 36),
(2, 2, 2, 75000.00, 48),
(3, 3, 3, 60000.00, 24),
(4, 4, 4, 80000.00, 60),
(5, 5, 5, 90000.00, 72);

COMMIT;