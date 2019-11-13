library(tidyverse)

ansp <- read_csv("anagrams-signature-spanish.csv")

ansp_summ <-   ansp %>%
  group_by(n) %>%
  summarise(
    nsets = n()
  ) %>%
  ungroup() %>%
  mutate(n = as.character(n)) %>%
  arrange(desc(nsets))

n9 <- ansp %>%
  filter(n == 9) %>%
  mutate(
    elements = paste0("- ", elements) %>%
                str_replace_all("\\|", ", ") %>%
                str_wrap(width = 70, exdent = 2)
  ) %>%
  pull(
    elements
  ) %>%
  paste(collapse = "\n")

ggplot(ansp_summ, aes(x = n, y = nsets)) +
  geom_point() +
  geom_segment(aes(x = n, xend = n, y = 0, yend = nsets), size = 0.5) +
  geom_text(aes(label = nsets), nudge_y = 200) +
  annotate(
    geom = "text",
    x = 3.5, y = 4000, hjust = 0, vjust = 1,
    label = n9, color = "red", size = 4
  ) +
  annotate(
    geom = "text",
    x = 3.5, y = 4300, hjust = 0, vjust = 1,
    label = "Sets with the most number of elements (n = 9):",
    size = 5
  ) +
  labs(
    y = "",
    x = "Number of elements in set",
    title = "Distribution of set sizes for anagrams in Spanish",
    subtitle = "Source: https://github.com/jmcastagnetto/spanish-anagrams-list",
    caption = "@jmcastagnetto, Jesus M. Castagnetto"
  ) +
  ggthemes::theme_tufte() +
  theme(
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank(),
    axis.text.x = element_text(size = 12),
    axis.title = element_text(size = 16),
    plot.title = element_text(size = 24),
    plot.caption = element_text(size = 10),
    plot.margin = unit(rep(1, 4), "cm")
  )

ggsave(
  filename = "anagram-set-sizes-spanish.png",
  width = 8,
  height = 6
)
