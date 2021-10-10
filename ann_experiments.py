# to manually check the error of prediction made by ANN.
# How to traverse pandas data frame column wise

# For forward regression. Select X and Y accordingly
from sklearn.metrics import mean_absolute_percentage_error
eg = y_test.shape[0]
# results = a = [0 for x in range(eg)]
for i in range(eg):
    pred = model1.predict(X_test.iloc[[i]])
    act = y_test.iloc[[i]]
    results[i] = mean_absolute_percentage_error(pred,act)
    
import statistics
statistics.mean(results) 

# For Inverse regression. Select X and Y accordingly]
from sklearn.metrics import mean_absolute_error
eg = y_test.shape[0]
# results = a = [0 for x in range(eg)]
for i in range(eg):
    pred = model1.predict(X_test.iloc[[i]])
    act = y_test.iloc[[i]]
    results[i] = mean_absolute_error(pred,act)
    
import statistics
statistics.mean(results) 



# Error - List object has no mean