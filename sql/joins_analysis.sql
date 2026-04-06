SELECT 
    p.client_id,
    c.client_name,
    p.fund_id,
    f.fund_name,
    p.investment_amount,
    p.returns,
    p.date
FROM portfolio p
JOIN clients c ON p.client_id = c.client_id
JOIN funds f ON p.fund_id = f.fund_id;

SELECT 
    c.client_name,
    f.fund_name,
    p.investment_amount
FROM portfolio p
JOIN clients c ON p.client_id = c.client_id
JOIN funds f ON p.fund_id = f.fund_id
WHERE c.risk_profile = 'High';
