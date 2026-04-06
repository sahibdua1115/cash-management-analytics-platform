-- To Find Total Investment Per Client; Business Insight : Who are the top clients. 
SELECT 
    c.client_name,
    SUM(p.investment_amount) AS total_investment
FROM portfolio p
JOIN clients c ON p.client_id = c.client_id
GROUP BY c.client_name
ORDER BY total_investment DESC;

-- To Find Average Returns Per Fund; Business Insight : Best Perfmorning Fund. 
SELECT 
    f.fund_name,
    AVG(p.returns) AS avg_returns
FROM portfolio p
JOIN funds f ON p.fund_id = f.fund_id
GROUP BY f.fund_name
ORDER BY avg_returns DESC;

-- To Find Risk-wise Investment Distribution; Business Insight : How much money is in High, Medium and Low Risk.
SELECT 
    c.risk_profile AS risk_level,
    SUM(p.investment_amount) AS total_investment
FROM portfolio p
JOIN clients c ON p.client_id = c.client_id
GROUP BY c.risk_profile
ORDER BY total_investment DESC;

-- To Find Monthly Investment Trend; Business Insight : Growth over time. 
SELECT 
    DATE_TRUNC('month', p.date) AS month,
    SUM(p.investment_amount) AS total_investment
FROM portfolio p
GROUP BY month
ORDER BY month;

-- To Find High Risk + High Investment Clients; Business Insight : Identify risky + valuable clients.
SELECT 
    c.client_name,
    SUM(p.investment_amount) AS total_investment
FROM portfolio p
JOIN clients c ON p.client_id = c.client_id
WHERE c.risk_profile = 'High'
GROUP BY c.client_name
ORDER BY total_investment DESC;
