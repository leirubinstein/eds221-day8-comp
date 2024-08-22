library(tidyverse)
library(patchwork)
library(here)

lizards <- read_csv(here::here("data_tidy", "lizards.csv"))

two_lizards <- lizards %>%
  filter(common_name %in% c("eastern fence", "western whiptail"))

p1 <- ggplot(data = two_lizards, aes(x = total_length,
                               y = weight)) +
  geom_point(aes(color = common_name)) +
  scale_color_manual(values = c("orange", "navy"),
                     name = "Lizard species",
                     labels = c("eastern fence lizard", "western whiptail lizard")) +
  theme_classic() +
  theme(legend.position = c(0.2, 0.8),
        legend.background = element_blank()) +
  labs(x = "total length (mm)",
       y = "total weight (g)")
  
p2 <- ggplot(data = lizards, aes(x = weight, y = site)) +
  geom_boxplot() +
  labs(x = "weight (g)",
       y = "site")

p3 <- ggplot(data = lizards, aes(x = weight)) + 
  geom_histogram() + 
  labs(x = "weight (g)",
       y = "counts (n)")

# using patchwork
((p1 + p2)/p3) & theme_minimal()

p4 <- (p1 / p2/ p3) & theme_minimal()  

ggsave("patchwork-example.png", p4, width = 5, height = 5)



