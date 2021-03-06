
# Load dataset
train <- read.csv("TitanicData/train.csv", header = TRUE)
test <- read.csv("TitanicData/test.csv", header = TRUE)


test.survived <- data.frame(Survived = rep("None", nrow(test)), test[,])

data.combined <- rbind(train, test.survived)
#colnames(test.survived) <- colnames(train)

str(data.combined)

data.combined$Survived <- as.factor(data.combined$Survived)
data.combined$Pclass <- as.factor(data.combined$Pclass)

table(data.combined$Survived)

table(data.combined$Pclass)

library(ggplot2)

train$Pclass <- as.factor(train$Pclass)

ggplot(train, aes(x=Pclass, fill=factor(Survived))) + geom_bar(stat = "count") + xlab("Pclass") + ylab("Total Count") + labs(fill = "Survived")

head(as.character(train$Name))
head(as.factor(train$Name))


length(unique(as.character(data.combined$Name)))

dup.names <- as.character(data.combined[which(duplicated(as.character(data.combined$Name))), "Name"])
data.combined[which(data.combined$Name %in% dup.names),]

library(stringr)

misses <- data.combined[which(str_detect(data.combined$Name, "Miss.")), ]
misses[1:5,]

mrses <- data.combined[which(str_detect(data.combined$Name, "Mrs.")), ]
mrses[1:5,]

males <- data.combined[which(train$Sex == "male"), ]
males[1:5,]

extractTitle <- function(name) {
  name <- as.character(name)
  
  if (length(grep("Miss.", name)) > 0) {
    return ("Miss.")
  } else if (length(grep("Master.", name)) > 0) {
    return ("Master.")
  } else if (length(grep("Mrs.", name)) > 0) {
    return ("Mrs.")
  } else if (length(grep("Mr.", name)) > 0) {
    return ("Mr.")
  } else {
    return ("Other")
  }
}

titles <- NULL
for (i in 1:nrow(data.combined)) {
  titles <- c(titles, extractTitle(data.combined[i,"Name"]))
}
data.combined$title <- as.factor(titles)

ggplot(data.combined[1:891,], aes(x = title, fill = Survived)) +
  geom_bar() +
  facet_wrap(~Pclass) + 
  ggtitle("Pclass") +
  xlab("Title") +
  ylab("Total Count") +
  labs(fill = "Survived")