Exploration of Team climate for performance data
========================================================

The shiny app has been developped to quickly data about team climate for performance

Input
-----

The file 'data.csv' contains the data about different dimensions of team climate as well as performance data. 
These data have been directly collected among team meambers via survey. Data are agregated at a department level.The file 'infos.csv' describes the variables of the 'data.csv' file.
More specifically, 'type' column indicates whether the variable is a segmentation variable or a dimension variable.
The 'sname' column provides the dimension name as indicated in the 'data.csv' file. 
The 'lname' column provides a longer and more descriptive name for each dimension.

Data exploration results
------------------------

The shiny apps provides : 
1. Descriptive statistics (boxplot). The results can be filtered by using the 'Department filter' list box.
2. A scatterplot of the relationship between two dimensions. Dimensions are selected via the 'select dimension' list boxes.The results can be filtered by using the 'Department filter' list box.

