Script workflow:
1. Save the given csv file.
2. Set the proper working directory. This working directiry will be the directory in which csv file is saved.
   This can be done getwd() and setwd().
3. After this, create an object for reading the csv file.
4. For linear regression, remove appropriate columns.
5. Get 80% of data as training data and 20% of data as testing data.
6. Perform linear regression on training dataset and predict on testing data.
7. Get highly correlated features by correlation matrix and again do the same.
8. Perform logistic regression on training dataset and predict on testing data.
9. Get highly correlated features by correlation matrix and again do the same.
10. Find ROC curve on predicted values.
11. Find confusion matrix on test data whose true values are already known.

Execution:
1. To execute whole script, select the whole script and click on 'Run' button in RStudio.
2. To execute the selected part of script, select that part and click on 'Run' button in RStudio.

-Vaibhavi Awghate (vna4493)