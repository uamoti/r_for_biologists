library(tidyverse)
library(ggpubr)

as_tibble(iris)  # This is your data set for these problems
View(iris)  # View it in RStudio

### dplyr problems ###

# NOTE: Don't forget, you there's a cheat sheet available on Box under "Resources"

# A. Complete the filter so that it only returns the "virginica" species
iris %>%
  filter(Species == virginica)

# B. Use summarise to get the mean sepal length for each species
iris %>%
  group_by(Species) %>%
  summarise(sepal_mean = mean(Sepal.Length))

# C. Get the ratio of sepal length to sepal width for all samples
iris %>%
  mutate(sepal_ratio = Sepal.Length/Sepal.Width)

# D. Get the average ratio of petal length to petal width for each species
iris %>%
  mutate(petal_ratio = Petal.Length/Petal.Width) %>%
  group_by(Species) %>%
  summarise(petal_ratio_avg = mean(petal_ratio))

### ggplot problems ###

# A. Make a scatter plot comparing sepal length to petal length
iris %>%
  ggplot(aes(Sepal.Length, Petal.Length)) +
  geom_point()

# B. Color the plot by the Species 
iris %>%
  ggplot(aes(Sepal.Length, Petal.Length, colour = Species)) +
  geom_point()

# C. Change to theme_classic(), set the base font size to 16, 
# set the x label to "Sepal Length (cm)", and set the y label to "Petal Length (cm)",
# set the title to "Sepal vs Petal Length in Iris Flowers"
iris %>%
  ggplot(aes(Sepal.Length, Petal.Length, colour = Species)) +
  geom_point() +
  ylab("Petal Length (cm)") +
  xlab("Sepal Length (cm)") +
  ggtitle("Sepal vs Petal Length in Iris Flowers") +
  theme_classic(base_size = 16)

# D. Plot the linear correlation between Sepal and Petal length stat_smooth 
iris %>%
  ggplot(aes(Sepal.Length, Petal.Length, colour = Species)) +
  geom_point() +
  ylab("Petal Length (cm)") +
  xlab("Sepal Length (cm)") +
  ggtitle("Sepal vs Petal Length in Iris Flowers") +
  theme_classic(base_size = 16) +
  stat_smooth(method = "lm")

# E. Add the pearson correlation coefficient using ggpubr's stat_cor()
iris %>%
  ggplot(aes(Sepal.Length, Petal.Length, colour = Species)) +
  geom_point() +
  ylab("Petal Length (cm)") +
  xlab("Sepal Length (cm)") +
  ggtitle("Sepal vs Petal Length in Iris Flowers") +
  theme_classic(base_size = 16) +
  stat_smooth(method = "lm") +
  stat_cor()

# F. Save the plot to a pdf file
iris %>%
  ggplot(aes(Sepal.Length, Petal.Length, colour = Species)) +
  geom_point() +
  ylab("Petal Length (cm)") +
  xlab("Sepal Length (cm)") +
  ggtitle("Sepal vs Petal Length in Iris Flowers") +
  theme_classic(base_size = 16) +
  stat_smooth(method = "lm") +
  stat_cor()
ggsave("my_figure.pdf")


### Challenge Problems ###

# Answer the following using dplyr and ggplot2 (with significance testing via ggpubr):

# 1. Do 6 cylinder cars have better MPG than 8 cylinder cars?
View(mtcars)
## Non-visual method
mtcars %>%
    select(cyl, mpg) %>%
    filter(cyl == 6 | cyl == 8) %>%
    t.test(mpg ~ cyl, data=.)

## Plotting
mtcars %>%
    filter(cyl == 6 | cyl == 8) %>%
    group_by(cyl) %>%
##    summarise(avg=mean(mpg)) %>%
    ggplot(aes(factor(cyl), avg)) +
    geom_boxplot() +
    stat_compare_means(comparisons=list(c('6', '8')), method='t.test')


# 2. Is there a correlation between urban population and Murder rate?
View(USArrests)
cor(USArrests$Murder, USArrests$UrbanPop)
## Plotting
USArrests %>%
    ggplot(aes(Murder, UrbanPop)) +
    geom_point() +
    geom_smooth(se=FALSE)

# 3. Did the treatment make the plants grow more or less?
View(PlantGrowth)
PlantGrowth %>%
    group_by(group) %>%
    ggplot(aes(group, weight)) +
    geom_boxplot() +
    stat_compare_means(
        comparisons=list(
            c('ctrl', 'trt1'),
            c('ctrl', 'trt2'),
            c('trt1', 'trt2')
        ),
        method='t.test'
    )


# 4. Does Vitamin C supplementation improve tooth growth? Is OJ better than Vitamin C at dose of 2?
View(ToothGrowth)


