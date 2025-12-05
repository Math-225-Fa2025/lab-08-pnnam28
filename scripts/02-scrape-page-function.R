# load packages ----------------------------------------------------------------
library(tidyverse)
library(rvest)
library(stringr)
## function: scrape_page --------------------------------------------------------

scrape_page <- function(url) {
  page <- read_html(url)
  
  titles <- page %>%
    html_nodes(".iteminfo") %>%
    html_node("h3 a") %>%
    html_text() %>%
    str_squish()
  
  links <- page %>%
    html_nodes(".iteminfo") %>%
    html_node("h3 a") %>%
    html_attr("href") %>%
    str_replace("^\\.", "https://collections.ed.ac.uk")
  
  artists <- page %>%
    html_nodes(".iteminfo") %>%
    html_node("p a") %>%  # adjust selector if needed
    html_text() %>%
    str_squish()
  
  tibble(
    title  = titles,
    artist = artists,
    link   = links
  )
}
scrape_page(first_url)
scrape_page(second_url)
