library(xlsx)
library(dplyr)
library(tidyr)
library(zoo)
library(ggplot2)

# grab headers and make tidy
headers<-read.xlsx("data/KIPP Chicago teachers.xlsx",
                   sheetIndex = 2,
                        startRow = 1,
                        endRow = 2,
                        header = FALSE,
                        stringsAsFactors = FALSE)


glimpse(headers)

headers_t <- t(headers) %>%
  as.data.frame(stringsAsFactors = FALSE) %>%
  rename(domain = V1, prompt = V2) %>%
  mutate(col_index = rownames(.),
         domain = zoo::na.locf(domain, na.rm=FALSE),
         prompt = ifelse(prompt == "School Sorter", NA, prompt))

# grab column to use for informational purposes
column_A<-read.xlsx("data/KIPP Chicago teachers.xlsx",
                    sheetIndex = 2,
                   colIndex = 1,
                   header = FALSE,
                   stringsAsFactors = FALSE)

# Get some info from column A like the first row with the word "Note"

first_foundation_row <- note_row<-grep("School Sorter", column_A$X1) + 1
note_row<-grep("Note", column_A$X1)
last_school_row <- note_row - 1


# get foundation data
tntp_foundation <-read.xlsx("data/KIPP Chicago teachers.xlsx",
                            sheetIndex = 2,
                   startRow = first_foundation_row,
                   endRow = first_foundation_row + 2,
                   header = FALSE,
                   stringsAsFactors = FALSE)

tntp_foundation <- tntp_foundation %>%
  rename(school = X1,
         region = X2) %>%
  gather(col_index, value, 3:ncol(tntp_foundation)) %>%
  left_join(headers_t, by = "col_index")


# get schools  data
tntp_schools <-read.xlsx("data/KIPP Chicago teachers.xlsx",
                         sheetIndex = 2,
                            startRow = first_foundation_row + 4,
                            endRow = last_school_row,
                            header = FALSE,
                            stringsAsFactors = FALSE)

tntp_schools <- tntp_schools %>%
  rename(school = X1,
         region = X2) %>%
  gather(col_index, value, 3:ncol(tntp_schools)) %>%
  left_join(headers_t, by = "col_index") %>%
  mutate(value = as.numeric(ifelse(value=="Top-Q", 1, value)))


# combine schools and foundation data into one data frame

tntp <- bind_rows(tntp_schools, tntp_foundation)



