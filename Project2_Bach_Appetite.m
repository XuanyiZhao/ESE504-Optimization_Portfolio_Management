%% For investors who are risk appetite
% Read the data into Matlab
[NUMERIC, TXT, RAW] = xlsread('NASDAQ_Composite_201811.xlsx');
% Calculate the volatility of stock price in the last month (November), 
% we use the square of the absolute stock price change to represent the 
% volatility
Price_20181130 = cell2mat(RAW(2:end, 8));
Price_20181101 = cell2mat(RAW(2:end, 7));
Volatility_20181101_and_20181130 = (Price_20181130 - Price_20181101) .^ 2;

%% 0 - 1 integer programming to select 20 stocks for risk appetite investors

% Construct the objective function and constraints based on the weights of
% various industries in the members of the NASDAQ Composite index
f = -Volatility_20181101_and_20181130;
All = ones(1, 300);
Semiconductor = zeros(1, 300);
Software = zeros(1, 300);
Biotechnology = zeros(1, 300);
Banks = zeros(1, 300);
Media = zeros(1, 300);
Capital_markets = zeros(1, 300);
Entertainment = zeros(1, 300);
IT_services = zeros(1, 300);
Health_care_equipment = zeros(1, 300);
Interactive_media = zeros(1, 300);
Internet_marketing = zeros(1, 300);
Electronic_equipment = zeros(1, 300);
Hotels_restaurants = zeros(1, 300);
Others = zeros(1, 300);

Semiconductor(1:29) = 1;
Software(30:57) = 1;
Biotechnology(58:80) = 1;
Banks(81:100) = 1;
Media(101:114) = 1;
Capital_markets(115:125) = 1;
Entertainment(126:136) = 1;
IT_services(137:147) = 1;
Health_care_equipment(148:157) = 1;
Interactive_media(158:167) = 1;
Internet_marketing(168:176) = 1;
Electronic_equipment(177:184) = 1;
Hotels_restaurants(185:192) = 1;
Others(193:300) = 1;

% Construct the constraints coefficients matrix
A = [-All; Semiconductor; Software; Biotechnology; Banks; Media; Capital_markets; ...
     Entertainment; IT_services; Health_care_equipment; Interactive_media; ...
     Internet_marketing; Electronic_equipment; Hotels_restaurants; Others];

% Construct the constraints rhs vector
b = [-20; 2; 2; 2; 1; 1; 1; 1; 1; 1; 1; 1; 1; 1; 4];

% Solve the integer programming
lb = zeros(1, 300);
ub = ones(1, 300);
intcon = [1:300];
[X, FVAL] = intlinprog(f, intcon, A, b, [], [], lb, ub);

% Store the index of selected stocks for invests who are risk averse
Averse_selected_stock_index = find(X == 1);

% Read the symbols in NASDAQ and company names of each selected stocks
Stock_symbols = RAW(2:end, 2);
Selected_stock_symbols = Stock_symbols(Averse_selected_stock_index);
Company_names = RAW(2:end, 3);
Selected_company_name = Company_names(Averse_selected_stock_index);

% Display the selected stock symbols and company name
[Selected_stock_symbols, Selected_company_name]
Optimal_value = -FVAL

%% Capital allocation

% Read the Alpha and Beta of each selected stocks
Stock_alpha = cell2mat(RAW(2:end, 11));
Selected_stock_alpha = Stock_alpha(Averse_selected_stock_index);
Stock_beta = cell2mat(RAW(2:end, 10));
Selected_stock_beta = Stock_beta(Averse_selected_stock_index);

% Compute the median of alpha of 300 sample stocks
alpha_median = median(cell2mat(RAW(2:end, 11)));

% Read the market return and risk-free return into Matlab
Market_return = cell2mat(RAW(2, 12));
Risk_free_return = cell2mat(RAW(2,13));

% Use CAMP model to calculate the annual return of each selected stock
Stock_return = Risk_free_return + Selected_stock_alpha + Selected_stock_beta .* (Market_return - Risk_free_return);

% Linear Programming to decide the weights of each stock in the portfolio that we selected for investors who are risk averse

% Construct the objective function and constraints matrix
f = -Selected_stock_beta;
weights = ones(1, 20);
return_constraints = -transpose(Stock_return);
upperbound_on_weights = eye(20);
lowerbound_on_weights = -eye(20);
alpha_constraint = -ones(1, 20);
lb = zeros(1, 20);
ub = ones(1, 20);

A = [return_constraints; weights; upperbound_on_weights; lowerbound_on_weights; alpha_constraint];

% Construct the constraints rhs vector
each = ones(20, 1);
each_maximum_weight = each .* 0.2;
each_minimum_weight = -each .* 0.02;
b = [-1.5 * Market_return; 1; each_maximum_weight; each_minimum_weight; -alpha_median]; 

% Solve the linear programming
[X_weights, fval_portfolio_beta] = linprog(f, A, b, [], [], lb, ub);
[Selected_company_name, mat2cell(X_weights, ones(1,20), 1)]
fval_portfolio_beta = -fval_portfolio_beta
