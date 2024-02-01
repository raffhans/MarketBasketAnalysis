# Install and load package ====
#------------------------------|
library(plyr)
library(readxl)
library(ggplot2)
library(dplyr)    
library(tidyr)  
library(arules)

# Set Directory====
#-----------------|
# Read the dataset
setwd("C:/Users/acer/Documents/Degree/Year 3/CPC351/Project")
df <- readxl::read_excel("Electronic-store-sales-details.xls")
head(df)
summary(df)


# Data Exploratory====
#------------------|

# Let's print the columns (features) names.
print(colnames(df))

#Rename the column name & Define New Column Name
new_column_names <- c('RowID','OrderID','OrderDate', 'ShipDate', 'ShipMode', 'CustomerID', 'CustomerName', 'Segment', 'Country', 'City', 'State', 'PostalCode', 'Region', 'ProductID', 'Category', 'SubCategory', 'ProductName', 'Sales', 'Quantity', 'Discount', 'Profit')

# Rename the columns of the data frame
colnames(df) <- new_column_names

#Correction for data types
str(df)

#Convert The data type OrderDate & ShipDate to date datatype | 'PostalCode' column to character format
df$OrderDate <- as.Date(df$OrderDate)
df$ShipDate <- as.Date(df$ShipDate, format = "%Y-%m-%d")
df$PostalCode <- as.character(df$PostalCode)


# Print column data types
str(df)
summary(df)


# Monthly Sales by year:====
#--------------------------|
##2016##
sales16 <- df[df$OrderDate >= as.Date("2016-01-01") & df$OrderDate <= as.Date("2016-12-31"), ]

# Group by month and calculate the total profit
monthsales16 <- sales16 %>%
  group_by(month = format(OrderDate, "%m")) %>%
  summarise(total_sales = sum(Sales))

# Convert month to factor and specify order
monthsales16$month <- factor(monthsales16$month, levels = sprintf("%02d", 1:12))

##2017##
# Filter data for the year 2017
sales17 <- df[df$OrderDate >= as.Date("2017-01-01") & df$OrderDate <= as.Date("2017-12-31"), ]

# Group by month and calculate the total profit for 2017
monthsales17 <- sales17 %>%
  group_by(month = format(OrderDate, "%m")) %>%
  summarise(total_sales = sum(Sales))

# Convert month to factor and specify order
monthsales17$month <- factor(monthsales17$month, levels = sprintf("%02d", 1:12))

##2018##
# Filter data for the year 2018
sales18 <- df[df$OrderDate >= as.Date("2018-01-01") & df$OrderDate <= as.Date("2018-12-31"), ]

# Group by month and calculate the total profit for 2018
monthsales18 <- sales18 %>%
  group_by(month = format(OrderDate, "%m")) %>%
  summarise(total_sales = sum(Sales))

# Convert month to factor and specify order
monthsales18$month <- factor(monthsales18$month, levels = sprintf("%02d", 1:12))

##2019##
# Filter data for the year 2019
sales19 <- df[df$OrderDate >= as.Date("2019-01-01") & df$OrderDate <= as.Date("2019-12-31"), ]

# Group by month and calculate the total profit for 2018
monthsales19 <- sales19 %>%
  group_by(month = format(OrderDate, "%m")) %>%
  summarise(total_sales = sum(Sales))

# Convert month to factor and specify order
monthsales19$month <- factor(monthsales19$month, levels = sprintf("%02d", 1:12))


# The total sales for all year:=====
#----------------------------------|
  
# Combine data frames for all four years
all_monthly_sales <- rbind(monthsales16, monthsales17, monthsales18, monthsales19)

# Add a column for the year in the combined data frame
all_monthly_sales$year <- rep(c(2016, 2017, 2018, 2019), each = 12)

# Plotting the line graph for all years
ggplot(all_monthly_sales, aes(x = month, y = total_sales, group = as.factor(year), color = as.factor(year))) +
  geom_line() +
  geom_point() +
  scale_x_discrete(labels = c('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec')) +
  labs(x = 'Month', y = 'Sales', title = 'Monthly Sales Trend Analysis') +
  theme_minimal()

# Monthly Profit by year====
#--------------------------|

##2016##
profit16 <- df[df$OrderDate >= as.Date("2016-01-01") & df$OrderDate <= as.Date("2016-12-31"), ]
monthprof16 <- profit16 %>%
  group_by(month = format(OrderDate, "%m")) %>%
  summarise(total_profit = sum(Profit))
monthprof16$month <- factor(monthprof16$month, levels = sprintf("%02d", 1:12))

##2017##
profit17 <- df[df$OrderDate >= as.Date("2017-01-01") & df$OrderDate <= as.Date("2017-12-31"), ]
monthprof17 <- profit17 %>%
  group_by(month = format(OrderDate, "%m")) %>%
  summarise(total_profit = sum(Profit))
monthprof17$month <- factor(monthprof17$month, levels = sprintf("%02d", 1:12))

##2018##
profit18 <- df[df$OrderDate >= as.Date("2018-01-01") & df$OrderDate <= as.Date("2018-12-31"), ]
monthprof18 <- profit18 %>%
  group_by(month = format(OrderDate, "%m")) %>%
  summarise(total_profit = sum(Profit))
monthprof18$month <- factor(monthprof18$month, levels = sprintf("%02d", 1:12))

##2019##
profit19 <- df[df$OrderDate >= as.Date("2019-01-01") & df$OrderDate <= as.Date("2019-12-31"), ]
monthprof19 <- profit19 %>%
  group_by(month = format(OrderDate, "%m")) %>%
  summarise(total_profit = sum(Profit))
monthprof19$month <- factor(monthprof19$month, levels = sprintf("%02d", 1:12))

# The total sales for all year:=====
#----------------------------------|
# Combine data frames for all four years
all_monthly_profit <- rbind(monthprof16, monthprof17, monthprof18, monthprof19)

# Add a column for the year in the combined data frame
all_monthly_profit$year <- rep(c(2016, 2017, 2018, 2019), each = 12)

# Plotting the line graph for all years profit
ggplot(all_monthly_profit, aes(x = month, y = total_profit, group = as.factor(year), color = as.factor(year))) +
  geom_line() +
  geom_point() +
  scale_x_discrete(labels = c('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec')) +
  labs(x = 'Month', y = 'Profit', title = 'Monthly Profit Trend Analysis') +
  theme_minimal()

# Performed correlation between the sales and profit for each category====
#------------------------------------------------------------------------|

# Filter data for United States, select relevant columns, group by Sub-Category, and calculate totals
df_us <- df %>%
  select(SubCategory, Sales, Profit) %>%
  group_by(SubCategory) %>%
  summarise(total_sales = sum(Sales),
            total_profit = sum(Profit)) %>%
  mutate(profitability_flag = ifelse(total_profit <= 0, "0", "1"))

# Plot
ggplot(df_us, aes(x = total_profit, y = total_sales, color = profitability_flag)) +
  geom_point() + 
  theme_minimal() +
  scale_y_continuous(labels = scales::comma) +
  scale_x_continuous(labels = scales::comma) +
  ggtitle("Profit Vs Sales by Subcategory") +
  labs(x = "Total Profit", y = "Total Sales") +
  theme(plot.title = element_text(hjust = 0.5)) +
  geom_vline(xintercept = 0) +
  geom_hline(yintercept = 100000) +
  coord_flip()



# Which attribute causes the lost to profit?====
#Calculate correlation coefficients for numeric variables
#-------------------------------------------------------------|

correlation_matrix <- cor(df[, sapply(df, is.numeric)], use = "pairwise.complete.obs")

# Sort correlations with Profit in descending order
profit_correlation <- correlation_matrix["Profit", ]
sorted_correlation <- sort(profit_correlation, decreasing = TRUE)

# Print correlation coefficients
print(sorted_correlation)

#Perfom hyphothesis to find if the discount causes the lost of profit
#-------------------------------------------------------------------------|

z.test <- function(sample, population){
  x_bar <- mean(sample)
  mu <- mean(population)
  n <- length(sample) 
  sigma <- sd(population)
  z <- (x_bar - mu) / (sigma / sqrt(n)) 
  p_value <- pnorm(z)
  df <- data.frame("Z_calc" = z, "P_value" = p_value)
  return(df)
}

# Generate a sample of profits with discounts from the superstore dataset
profit_sample_disc <- df %>% 
  dplyr::filter(Country == "United States") %>% 
  dplyr::filter(Discount > 0) %>% 
  dplyr::pull(Profit) %>%
  sample(1000)

# Perform the Z-test using the function
z_test_result <- z.test(profit_sample_disc, df$Profit)
print(z_test_result)


# Apriori Algorithm====
#----------------------|
# Group all the items that are bought in a transaction
trans <- ddply(df, c("OrderID"), function(df1) paste(df1$SubCategory, collapse = ","))

# Remove unnecessary columnsS
trans$OrderID <- NULL

# Rename the column
colnames(trans) <- c("items")

# Write the processed dataset to an external CSV file
write.csv(trans, "processed_transactions.csv", quote = FALSE, row.names = FALSE)

# Load the processed dataset using read.transactions
tr <- read.transactions("processed_transactions.csv", format = "basket", sep = ",", cols = 1, rm.duplicates = FALSE)

# View the summary of the transaction object
summary(tr)

# Generate a plot to view the frequency of the top 10 items
itemFrequencyPlot(tr, topN = 10, type = "absolute", main = "Absolute Item Frequency Plot")

#Application of Apriori Algorithm and Diagnostics of the Association Rules Analysis

#----------------------|

# Scenario 1: For minlen=2
scenario1 <- apriori(tr,parameter=list(support=0.01,confidence=0.22,
                                       target = "rules",minlen=2))
inspect(scenario1)


# Scenario 2: For minlen=3
scenario2 <- apriori(tr,parameter=list(support=0.006,confidence=0.1,
                                       target = "rules",minlen=3))
inspect(scenario2)

# Scenario 3: For minlen=4
scenario3 <- apriori(tr,parameter=list(support=0.002,confidence=0.3,
                                       target = "rules",minlen=4))
inspect(scenario3)


