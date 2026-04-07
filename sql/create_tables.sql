CREATE TABLE clients (
    client_id INT,
    client_name VARCHAR(50),
    risk_profile VARCHAR(20)
);

CREATE TABLE funds (
    fund_id INT,
    fund_name VARCHAR(100),
    category VARCHAR(50),
    risk_level VARCHAR(20)
);

CREATE TABLE portfolio (
    client_id INT,
    fund_id INT,
    investment_amount INT,
    returns FLOAT,
    date DATE
);
