setwd("~/Desktop")
Hadza <- read.csv("tribes.csv")

# endowmentcondition: Whether subject was tested according to condition 1 or 2 in the experiment.
# endowmentlighter: Whether subject traded the item in the choice among lighters. 
# endowmentbiscuit: Whether subject traded the item in the choice among biscuits.

library("ggplot2", lib.loc="/Library/Frameworks/R.framework/Versions/3.2/Resources/library")

# Clean up data

Hadza$X <- NULL
Hadza$gpsx <- NULL
Hadza$gpsy <- NULL

Hadza <- Hadza[-c(22),]
Hadza <- Hadza[-c(4),]

colnames(Hadza)[1] <- "camp"
colnames(Hadza)[6] <- "condition"
colnames(Hadza)[7] <- "lighter"
colnames(Hadza)[8] <- "biscuit"

# Dummies for trading in each condition and for each object

Hadza$lighter1 <- NA
for (i in 1:nrow(Hadza)) {
  if ((Hadza$condition[i] == 1) && (Hadza$lighter[i] == "Yes")) {Hadza$lighter1[i] <- 1}
  if ((Hadza$condition[i] == 1) && (Hadza$lighter[i] == "No")) {Hadza$lighter1[i] <-0}
}

Hadza$lighter2 <- NA
for (i in 1:nrow(Hadza)) {
  if ((Hadza$condition[i] == 2) && (Hadza$lighter[i] == "Yes")) {Hadza$lighter2[i] <- 1}
  if ((Hadza$condition[i] == 2) && (Hadza$lighter[i] == "No")) {Hadza$lighter2[i] <- 0}
}

Hadza$biscuit1 <- NA
for (i in 1:nrow(Hadza)) {
  if ((Hadza$condition[i] == 1) && (Hadza$biscuit[i] == "Yes")) {Hadza$biscuit1[i] <- 1}
  if ((Hadza$condition[i] == 1) && (Hadza$biscuit[i] == "No")) {Hadza$biscuit1[i] <-0}
}

Hadza$biscuit2 <- NA
for (i in 1:nrow(Hadza)) {
  if ((Hadza$condition[i] == 2) && (Hadza$biscuit[i] == "Yes")) {Hadza$biscuit2[i] <- 1}
  if ((Hadza$condition[i] == 2) && (Hadza$biscuit[i] == "No")) {Hadza$biscuit2[i] <- 0}
}

# High or Low Exposure (HE = 1, LE = 0)

Hadza$Mangola <- 1
Hadza$Mangola[Hadza$camp %in% c("Endadubu", "Mayai", "Mizeu", "Mwashilatu", "Onawasi")] <- 0

# Trades for high and low exposure

Mangola <- aggregate(Hadza[10:13], by = list(Exposure = Hadza$Mangola), FUN = mean, na.rm = TRUE)

Mangola$Exposure[Mangola$Exposure == 0] <- "LE"
Mangola$Exposure[Mangola$Exposure == 1] <- "HE"

for (i in 1:2) {
  Mangola$total[i] <- rowMeans(Mangola[i, 2:5], na.rm = TRUE)
}

# Plot trades by exposure

ggplot(data = Mangola, aes(x = Exposure, y = total)) +
  ylim(0, 1) + xlab("Exposure") + ylab("Trades") + 
  theme_minimal() + geom_hline(yintercept = 0.5) +
  geom_bar(stat = "identity", aes(width = 0.5, fill = "red")) +
  guides(fill = FALSE)

# Distance from Mangola village centre

Hadza$distance <- (765668 - Hadza$utm36m)^2 + (9611785 - Hadza$v9)^2
Hadza$distance <- sqrt(Hadza$distance)
Hadza$distance <- (Hadza$distance)/1000

# Trades per camp

Camps <- aggregate(Hadza[10:13], by = list(camp = Hadza$camp), FUN = mean, na.rm = TRUE)

for (i in 1:7) {
  Camps$trades[i]  <- rowMeans(Camps[i, 2:5], na.rm = TRUE)
  Camps$distance[i]  <- mean(Hadza$distance[Hadza$camp == Camps$camp[i]])
  Camps$size[i] <- sum(Hadza$camp == Camps$camp[i])
}

Camps$lighter1 <- NULL
Camps$lighter2 <- NULL
Camps$biscuit1 <- NULL
Camps$biscuit2 <- NULL

# Plotting distance with trades

ggplot(data = Camps, aes(x = distance, y = trades)) +
  ylim(0, 1) + xlab("Distance from Mangola Village Centre (km)") + ylab("Trades") + 
  theme_minimal() + geom_hline(yintercept = 0.5, alpha = 0.5) +
  geom_point(aes(size = size, colour = "green"), alpha = 0.5) + 
  scale_size_area(max_size = 12) + 
  scale_color_manual(values = "darkgreen") +
  guides(colour = FALSE, size = FALSE) +
  annotate("text", label = "Endadubu", x = 29, y = 0.58, size = 4) +
  annotate("text", label = "Shibibunga", x = 7, y = 0.15, size = 4) +
  annotate("text", label = "Mkwajuni", x = 12, y = 0.25, size = 4) +
  annotate("text", label = "Sonai", x = 7, y = 0.4, size = 4) +
  annotate("text", label = "Mwashilatu", x = 77, y = 0.41, size = 4) +
  annotate("text", label = "Mayai", x = 73, y = 0.73, size = 4) +
  annotate("text", label = "Onawasi", x = 48, y = 0.6, size = 4)

# Bad correlations

  # Adding exposure to Camps
Camps$Exposure <- 1
Camps$Exposure[Camps$camp %in% c("Endadubu", "Mayai", "Mizeu", "Mwashilatu", "Onawasi")] <- 0

cor(Camps$Exposure, Camps$trades, method = "spearman")
cor(Camps$distance, Camps$trades, method = "spearman")

# Bad linear regression

lm(Camps$trades ~ Camps$Exposure + Camps$distance)

# Good linear regression

  # Making a distance column with same range as exposure
Camps$dist_01 <- Camps$distance / max(Camps$distance)

lm(Camps$trades ~ Camps$Exposure + Camps$dist_01)