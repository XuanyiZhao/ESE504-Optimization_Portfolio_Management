# Optimization_Portfolio_Management

## 1. Scope of Research
The aim of this project is to use different investment strategies to generate two different optimal portfolios stocks for investors with different risk tolerance. Each portfolio contains 20 stocks in different industries. First, based on the market capital, we choose the top 300 stocks from Nasdaq Composite Index components, then use binary linear programming to build a stock selection model and choose 20 stocks out of 300 stocks data set. The number of stocks in each industry in our portfolio is in proportion to weight of each industry in our dataset. Then we use linear programming to build a capital allocation model to find weights of each stock in our portfolio.

## 2. Dataset
Nasdaq Composite Index components

## 3. Risk Measures
The 2015-16 stock market selloff was the latest period of decline in the value of stock prices globally that occurred from June 2015 to June 2016. U.S. markets finished 2015 mostly in the red: The Dow was down 2.2%. The S&P 500 ended the year down 0.7%. The Nasdaq finished 2015 up 5.7%. However, it had double digit gains in the three years prior. Nearly 70% investors lost money in 2015. It was the worst year for stock markets since financial crisis in 2008. We choose 12/29/2015 to 02/11/2016 as our evaluating period. Here we use the square of the difference between stock prices in that period as a measure of risk based on the fact that invests can take a long position or short position in each stock. The more the stock price changes, the higher risk it has.

## 4. Return on the stock index
Take the historical average return of Nasdaq Composite Index as market return in CAPM model. The historical average return is calculated by the past ten years data, saying from 11/30/2008 to 11/30/2018.

annual index return = (1 + monthly index return)^12 - 1

## 5. Risk of the stock
In our project, β is the percentage of change in the price of the stock given a 1% change in the Nasdaq Composite Index risk premium. For investors who are risk averse, our objective function in capital allocation is choosing the minimum β in order to set the systematic risk to the lowest level. However, for investors who are risk appetite, our objective function in capital allocation is choosing the maximum β so as to set the systematic risk to the highest level.

## 6. Return of the sotck
Based on Capital Asset Pricing Model, RS = RF + β * (RM - RF) + α
