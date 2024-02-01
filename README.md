# MarketBasketAnalysis
MBA for Electronic Store Sales Dataset. 

# Objective
1) To diagnose what the cause of lost profit over the year 
2) To advise them to promote the right products by using Apriori Algorithm

## Code Flow

1) First we visual both profit and sales of the dataset
2) We have seen that the profit and sales are high during the festive month of United State which the most celebrated one; Christmas
3) However, if we compared both of these graph (sales and profit) we have seen that the sales are higher at a specific month but the profit are low. 
4) For instance, in year 2016, March and October recorded an increase and decrease in sales respectively. However, the profit states the opposite where the store experienced decrease and increase in profit during those respectively. 
5) In order for us to convince that this statement is true, we visual the data by finding the correlation between sales and profit
6) we can observed from the plot that even though the sales are high but the profit is low.
7) Then, we try to find what the cause of this significant losses of profit in this dataset.
8) we use correlation matrix between all the numerical features and it show that the discount has a negative value indicating it cause the profit losses.
9) Again, we convince our finding by using the null hypothesis and alternative hypothesis.
10) Null hypothesis: Discount doesnt affect the profit.
    Alternative hypothesis: Discount does affect the profit.
11) We use the Z-test to confirm our findings. 
12)  It is found that the p-value is lesser than 0.05, indicating that it is statistically significant. Therefore, we can reject the null hypothesis, H₀.
13) Here is the point where we want to perform the Market Basket Analysis, so that the company would gave discount to the right products based on the outcome for the alpriori algorithm.

