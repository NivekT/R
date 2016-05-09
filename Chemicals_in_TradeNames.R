# Code written by me to help with a friend's assignment


#For every trade name, what are the chemcials that are listed with it 90% of the time? 

# creating vector of unique trade names, in order of most common 
tn <- rownames(as.matrix(sort(table(CommonChemicals$TradeName),decreasing=TRUE)))

#creating vector of unique chemical names
cn <- unique(CommonChemicals$ChemicalName)

#creating dataframe with the tradenames as column names
df <- matrix(ncol=14886, nrow =4000)
df <- data.frame(df)

colnames(df) = tn

# Creating an empty matrix 
zeros <- t(rep(0,14887))
for (i in 1201:9000) {
  df[i,] <- zeros
}

# Initial the row of Counts
rownames(df)[1] = "Count"
for (i in 1:ncol(df)) {
  df[1,i] = 0
}

# We are now going to extract the Chemical Names within each Trade Name

for (i in 1:2557) {
  current_name = colnames(df)[i]
  for (j in 1:nrow(CommonChemicals)) {
  #for (j in 1:1000) {
    if (current_name == CommonChemicals$TradeName[j]) {
      df$Count[i] = df$Count[i] + 1
      df[df$Count[i] + 1,i] = toString(CommonChemicals$ChemicalName[j])
    }
  }
}

write.csv(df, file = "df.csv", row.names = FALSE)

# the following part requires the usage of the hash table package
# which is basically the dictionary datatype in Python

big_h = list(0)
for (i in 1:2557) { 
  h <- hash()
  for (j in 2:(df2$Count[i] + 1)) {
    curr = toString(df2[j,i])
    if (curr != "") {
      if (has.key(curr,h)) {
        h[[curr]] = h[[curr]] + 1
        #.set(h, curr = (unlist((values(h, keys = curr))) + 1))
      } else {
        .set(h, keys = curr, values = 1)
      }
    }
  }
  big_h[i] = h
}

# Find the unique number of Tradenames per API
for (i in 1:2557) {
  current = colnames(df2)[i]
    df2$Count[i] = length(unique(CommonChemicals$APIFFQA[CommonChemicals$TradeName == current]))
}

df3 <- matrix(ncol=2557, nrow =5000)
df3 <- data.frame(df3)
colnames(df3) = tn

# Find the Chemical Names that appear in >=90% of Tradenames
for (i in 1:length(big_h)) {   # Walk through big_h
  h = big_h[[i]] # h is the current  hash table that we are working on
  j = 0
  for (key in keys(h)) {
    if (h[[key]] >= 0.9*df2$Count[i]) { 
      df3[j,i] = key # Save Chemical name into final_df
      j = j + 1 # Increment the count every time we find >= 0.9*count
    }
  }
}

write.csv(df3, file = "Chemicals_in_90%TradeNames.csv", row.names = FALSE, na = "")