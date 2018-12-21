# get stock price data
library(quantmod)
library(purrr)

start <- as.Date("2018-01-01")
end <- as.Date("2018-11-30")

getSymbols("AAPL", src = "yahoo", from = start, to = end)
getSymbols("MSFT", src = "yahoo", from = start, to = end)



# extract closing prices

aapl <- AAPL$AAPL.Close
msft <- MSFT$MSFT.Close


# create single dataset

stocks <- cbind(aapl, msft$MSFT.Close)


# plot with ggplot

library(ggplot2)

autoplot(stocks)


# create plot using dygraph

library(dygraphs)

dygraph(stocks)

library(dplyr)

dygraph(stocks, main = "AAPL and MSFT Closing Price 1st Jan - 30th Nov 2018") %>%
  dySeries("MSFT.Close", axis = "y2") %>% 
  dyAxis("y", 
         label = "AAPL") %>%
  dyAxis("y2", 
         label = "MSFT",
         valueRange = c(80, 120),
         independentTicks = TRUE) %>%
  dyRangeSelector(dateWindow = c("2018-01-01", "2018-11-30")) %>%
  dyRoller()
