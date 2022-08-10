# --------------------------------------------------#
# Scientific computing
# ICTP/Serrapilheira 2022
# Creating R packages
# First version 2022-08-09
# --------------------------------------------------#

#install.packages("devtools")
#install.packages("usethis")
#install.packages("available")
#install.packages("roxygen2")

# Loading needed packages
library(devtools)
library(usethis)
library(available)
library(roxygen2)

#Check if you have the developer tools installed
devtools::has_devel()

#RStudio will ask you to confirm you want the create the project with the package.
#After you accept, it will start a new session in project “foo”
usethis::create_package("foo")

#Criar a licença
usethis::use_mit_license()

#Edit DESCRIPTION by hand with a description and your name

#Open a new script with the function "my shannon" and save
#Create the function
usethis::use_r("my_shannon")

#Checking the package
#checking if the package caBn load without installing it
devtools::load_all()

#You can already execute the function my_shannon() in the console
my_shannon(1)
my_shannon(c(1, 2, 3))

### Documenting functions
#Open the file, put the cursor at the beginning of the file
#Go to the menu Code>Insert roxygen skeleton
devtools::document()

### Run CRAN checks
#devtools has a function that emulates the checks run by CRAN when you submit a package
devtools::check()
#devtools::check() will return errors, warnings and notes
#All of them need to be adressed, especially the errors and warnings

### Testing the functions
#It’s best to add tests for every function in the package
#The percentage of code that is covered by tests is commonly called the coverage
usethis::use_test("my_shannon")

#Add to check
expect_equal(my_shannon(1), 0)

expect_type(my_shannon(c(1, 2, 3)), "double")

expect_snapshot_error(my_shannon("a"))

#You can check the package again, it will run the tests now
devtools::check()

#Add a README
usethis::use_readme_rmd()

#Add github
usethis::use_git()
