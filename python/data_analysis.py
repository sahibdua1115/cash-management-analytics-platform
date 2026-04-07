import pandas as pd
import psycopg2

# ----------------------------
# 1️⃣ Connect to PostgreSQL
# ----------------------------
try:
    conn = psycopg2.connect(
        dbname="cash_management",   # your database name
        user="postgres",            # your PostgreSQL username
        password="postgres24",   # replace with your PostgreSQL password
        host="localhost",
        port="5432"
    )
    print("Connection successful ✅")
except Exception as e:
    print("Connection failed ❌")
    print(e)

# ----------------------------
# 2️⃣ Fetch tables
# ----------------------------
df_clients = pd.read_sql("SELECT * FROM clients;", conn)
df_portfolio = pd.read_sql("SELECT * FROM portfolio;", conn)
df_funds = pd.read_sql("SELECT * FROM funds;", conn)

print("Clients table preview:")
print(df_clients.head())
print("Portfolio table preview:")
print(df_portfolio.head())
print("Funds table preview:")
print(df_funds.head())

# ----------------------------
# 3️⃣ Merge tables
# ----------------------------
# Merge portfolio with clients
df_merge = df_portfolio.merge(df_clients, how='inner', left_on='client_id', right_on='client_id')

# Merge the result with funds
df_merge = df_merge.merge(df_funds, how='inner', left_on='fund_id', right_on='fund_id')

print("Merged table preview:")
print(df_merge.head())

#----------------------------
# 3️⃣ Buinsess Insights
#----------------------------
# Total investment by risk profile
risk_investment = df_merge.groupby('risk_profile')['investment_amount'].sum().sort_values(ascending=False)
print("Total investment by risk profile (high -> low):")
print(risk_investment)

# Total investment per client
client_investment = df_merge.groupby('client_name')['investment_amount'].sum().sort_values(ascending=False)
print("\nTotal investment per client:")
print(client_investment)

# Total investment per fund category
category_investment = df_merge.groupby('category')['investment_amount'].sum().sort_values(ascending=False)
print("\nTotal investment by fund category:")
print(category_investment)

import os

os.makedirs("outputs", exist_ok=True)

print("DEBUG: reached save section")

risk_investment.to_csv("outputs/total_investment_by_risk_profile.csv", header=True)
print("Saved: total_investment_by_risk_profile.csv ✅")

client_investment.to_csv("outputs/total_investment_per_client.csv", header=True)
print("Saved: total_investment_per_client.csv ✅")

category_investment.to_csv("outputs/total_investment_by_fund_category.csv", header=True)
print("Saved: total_investment_by_fund_category.csv ✅")
