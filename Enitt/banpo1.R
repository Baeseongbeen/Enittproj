setwd("C:\\Users\\seong\\Desktop\\enitt\\Enitt\\")

banpo1 <- read.csv("banpo1_join.csv", encoding="UTF-8")
head(banpo1$env_slopesolar)
banpo1 <- banpo1[banpo1$match_solar != 0,]
banpo1 <- banpo1[banpo1$pow_totpower !=0, ]
banpo1 <- banpo1[banpo1$env_slopesolar !=0, ]
banpo1 <- banpo1[banpo1$env_levelsolar !=0, ]
head(banpo1)
set.seed(2019)
index <- sample(1:nrow(banpo1), .7*nrow(banpo1))
train.banpo1 <-banpo1[index, ]
test.banpo1 <-banpo1[-index, ]
head(train.banpo1)
r0 <- lm(pow_totpower ~ env_slopesolar + env_levelsolar + env_modtemp + env_airtemp, data=train.banpo1)
r1 <- lm(pow_totpower ~ match_solar, data=train.banpo1)
r2 <- lm(pow_totpower ~ env_slopesolar, data=train.banpo1)
r3 <- lm(pow_totpower ~ env_levelsolar, data=train.banpo1)
r4 <- lm(match_solar ~ env_slopesolar, data=train.banpo1)
r5 <- lm(match_solar ~ env_levelsolar, data=train.banpo1)
summary(r)

result1 <- predict(r1, newdata = test.banpo1)
result2 <- predict(r2, newdata = test.banpo1)
result3 <- predict(r3, newdata = test.banpo1)
result_df <- data.frame(test.banpo1$pow_totpower, result)
plot(result_df)
abline(a=0, b=1, col="red")


# install.packages("Metrics")
# library("Metrics")

mse(test.banpo1$pow_totpower, result)
rmse(test.banpo1$pow_totpower, result)
mae(test.banpo1$pow_totpower, result)
1-mape(test.banpo1$pow_totpower, result)

a = banpo1[banpo1$env_slopesolar != 0,]$env_slopesolar
b = banpo1[banpo1$env_slopesolar != 0,]$match_solar

install.packages("forecast")
library("forecast")

accuracy(r0)
accuracy(r1)
accuracy(r2)
accuracy(r3)
accuracy(r4)
accuracy(r5)
