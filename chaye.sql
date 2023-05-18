/**
*    Voici la liste des noms de tables dans l'ordre approprié pour éviter les erreurs de clé étrangère lors de l'exécution du script :
*
*   01 members
*   02 recipients
*   03 cooperation
*   04 announcments
*   05 members_connections
*   06 members_types
*   07 packages
*   08 confirmation_receipt_package
*   09 claims_alert
*   10 claims_details
*   11 claims_status
*   12 bank_accounts
*   13 bank_informations
*   14 wallet_btc
*   15 reserved_payment
*   16 payment
*   17 means_transport
*   18 journeys
*   19 position
*   20 tchat_discussions
*   21 tchat_messages
*   22 commentaries_ratings
**/

CREATE DATABASE IF NOT EXISTS chaye;

USE chaye;


CREATE TABLE members (
    id INT PRIMARY KEY,
    lastname VARCHAR(50),
    firstname VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20),
    adress VARCHAR(200),
    created_at DATETIME,
    updated_at DATETIME
);

CREATE TABLE recipients (
    id INT PRIMARY KEY,
    member_id INT,
    lastname VARCHAR(50),
    phone VARCHAR(20),
    delivery_adress TEXT,
    delivery_validation_key VARCHAR(60),
    created_at DATETIME,
    updated_at DATETIME,
    FOREIGN KEY (member_id) REFERENCES members(id)
);

CREATE TABLE cooperation (
    id INT PRIMARY KEY,
    cooperation_keygen VARCHAR(100),
    cooperation_applicant INT,
    cooperation_carrier INT,
    cooperation_state ENUM('rejected', 'accepted', 'waiting'),
    created_at DATETIME,
    cooperation_state_response_at DATETIME,
    FOREIGN KEY (cooperation_applicant) REFERENCES members(id),
    FOREIGN KEY (cooperation_carrier) REFERENCES members(id)
);

CREATE TABLE announcements (
    id INT PRIMARY KEY,
    announcment_type ENUM('enable', 'filled'),
    member_id INT,
    description TEXT,
    created_at DATETIME,
    updated_at DATETIME,
    FOREIGN KEY (member_id) REFERENCES members(id)
);

CREATE TABLE member_connections (
    member_id INT PRIMARY KEY,
    current_connection DATETIME,
    member_connections_history TEXT,
    created_at DATETIME,
    updated_at DATETIME,
    FOREIGN KEY (member_id) REFERENCES members(id)
);

CREATE TABLE member_types (
    member_id INT PRIMARY KEY,
    current_member_type ENUM('applicant', 'carrier', 'recipient'),
    created_at DATETIME,
    updated_at DATETIME,
    FOREIGN KEY (member_id) REFERENCES members(id)
);

/* INFOS COLIS */

CREATE TABLE packages (
    id INT PRIMARY KEY,
    cooperation_key VARCHAR(100),
    package_weight DECIMAL(5,2),
    package_sizes VARCHAR(60),
    package_content_list TEXT,
    package_content_pictures BLOB,
    FOREIGN KEY (cooperation_key) REFERENCES cooperation(cooperation_keygen)
);

CREATE TABLE confirmations_receipt_package (
    id INT PRIMARY KEY,
    cooperation_key VARCHAR(100),
    package_id INT,
    confirmation_applicant_state ENUM('accepted', 'rejected'),
    confirmation_carrier_state ENUM('accepted', 'rejected'),
    confirmation_state ENUM('accepted', 'rejected'),
    created_at DATETIME,
    FOREIGN KEY (cooperation_key) REFERENCES cooperation(cooperation_keygen),
    FOREIGN KEY (package_id) REFERENCES packages(id)
);

/* RECLAMATIONS */

CREATE TABLE claims_alert (
    id INT PRIMARY KEY,
    claim_by_member_id INT,
    claim_cooperation_key VARCHAR(100),
    claim_package__state ENUM('stolen', 'lost', 'damaged', 'customs'),
    created_at DATETIME,
    FOREIGN KEY (claim_by_member_id) REFERENCES members(id),
    FOREIGN KEY (cooperation_key) REFERENCES cooperation(cooperation_keygen)
);

CREATE TABLE claims_details (
    id INT PRIMARY KEY,
    claims_alert_id INT,
    membre_id INT,
    description TEXT,
    create_date DATETIME,
    FOREIGN KEY (claims_alert_id) REFERENCES claims_alert(id),
    FOREIGN KEY (membre_id) REFERENCES members(id)
);

CREATE TABLE claims_status (
    id INT PRIMARY KEY,
    applicant_claim_id INT,
    carrier_claim_id INT,
    state ENUM('solved', 'urgent'),
    create_date DATETIME,
    updated_at DATETIME,
    FOREIGN KEY (applicant_claim_id) REFERENCES claims_alert(id),
    FOREIGN KEY (carrier_claim_id) REFERENCES claims_alert(id)
);

/* PAYMENT */

CREATE TABLE bank_accounts (
    id INT PRIMARY KEY,
    membre_id INT,
    account_type ENUM('crypto', 'fudiciary'),
    create_date DATETIME,
    updated_at DATETIME,
    FOREIGN KEY (membre_id) REFERENCES membres(id)
);

CREATE TABLE bank_informations (
    id INT PRIMARY KEY,
    bank_account_id INT,
    informations VARCHAR(255),
    FOREIGN KEY (bank_account_id) REFERENCES bank_accounts(id)
);

CREATE TABLE wallets_btc (
    id INT PRIMARY KEY,
    bank_account_id INT,
    wallet VARCHAR(255),
    FOREIGN KEY (bank_account_id) REFERENCES bank_accounts(id)
);


CREATE TABLE reserved_payments (
    id INT PRIMARY KEY,
    cooperation_key INT,
    from_bank_account_id INT,
    to_reserved_account_id INT,
    taking_reserved_at DATETIME,
    FOREIGN KEY (cooperation_key) REFERENCES cooperation(cooperation_keygen),
    FOREIGN KEY (from_bank_account_id) REFERENCES bank_accounts(id)
);

CREATE TABLE payments (
    id INT PRIMARY KEY,
    from_reserved_account_id INT,
    to_bank_account_id INT,
    state ENUM('waiting', 'sold'),
    created_at DATETIME,
    sold_at DATETIME,
    FOREIGN KEY (from_reserved_account_id) REFERENCES reserved_payments(id),
    FOREIGN KEY (to_bank_account_id) REFERENCES bank_accounts(id)
);

/* TRAVEL & POSITION GPS */

CREATE TABLE means_transport (
    id INT PRIMARY KEY,
    carrier_id INT,
    company VARCHAR(50),
    travel_code VARCHAR(10),
    transport ENUM('boat', 'plane', 'bus', 'car'),
    status ENUM('waiting', 'on the way', 'landed'),
    position_gps VARCHAR(100),
    created_at DATETIME,
    FOREIGN KEY (carrier_id) REFERENCES members(id)
);

CREATE TABLE journeys (
    id INT PRIMARY KEY,
    carrier_id INT,
    package_id INT,
    created_at DATETIME,
    leaving_at DATETIME,
    arrival_at DATETIME,
    FOREIGN KEY (carrier_id) REFERENCES members(id),
    FOREIGN KEY (package_id) REFERENCES packages(id)
);

CREATE TABLE positions (
    id INT PRIMARY KEY,
    membres_id INT,
    latitude FLOAT(10,6),
    longitude FLOAT(10,6),
    created_at DATETIME,
    FOREIGN KEY (membres_id) REFERENCES members(id)
);

/* MESSAGES TCHAT */

CREATE TABLE tchat_discussions (
    id INT PRIMARY KEY,
    discussion_opener_id INT,
    discussion_receiver_id INT,
    created_at DATETIME,
    FOREIGN KEY (discussion_opener_id) REFERENCES members(id),
    FOREIGN KEY (discussion_receiver_id) REFERENCES members(id)
);

CREATE TABLE tchat_messages (
    id INT PRIMARY KEY,
    discussion_id INT,
    member_id INT,
    content TEXT,
    created_at DATETIME,
    updated_at DATETIME,
    FOREIGN KEY (discussion_id) REFERENCES tchat_discussions(id),
    FOREIGN KEY (member_id) REFERENCES members(id)
);

/* COMMENTS & RATING */

CREATE TABLE commentaries_ratings (
    id INT PRIMARY KEY,
    cooperation_key VARCHAR(100),
    member_id INT,
    member_cooperation_status ENUM('sender', 'carrier', 'recipient'),
    rating_stars INT,
    content TEXT,
    FOREIGN KEY (member_id) REFERENCES members(id),
    FOREIGN KEY (cooperation_key) REFERENCES cooperation(cooperation_keygen)
);
