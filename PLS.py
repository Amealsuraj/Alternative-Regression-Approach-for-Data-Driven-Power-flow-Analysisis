'''
Goal: Perform PLS
Input - P, Q, V, Va, num_train, num_bus
Output - Xp, Xq, P_mape, Q_mape, Xv, Xva, V_mae, Va_mae

'''
import numpy as np
import pandas as pd

def PLS(P, Q, V, Va, I,Ia, num_train, num_bus):
    import pandas as pd
    import numpy as np
    import sklearn
    
    # Y = P.join(Q, lsuffix='_P', rsuffix='_Q')
    # X = Va.join(V, lsuffix='_Va', rsuffix='_V')
    X = pd.concat([P,Q,I,Ia,intercept],axis=1)
    

    from sklearn.cross_decomposition import PLSRegression
    from sklearn.model_selection import cross_val_score

    '''ols = LinearRegression()
    scores = cross_val_score(ols, X, P, cv=5, scoring="neg_mean_absolute_percentage_error")
    P_mape = scores.mean()

    ols = LinearRegression()
    scores = cross_val_score(ols, X, Q, cv=5, scoring="neg_mean_absolute_percentage_error")
    Q_mape = scores.mean()

    ols2 = LinearRegression()
    scores = cross_val_score(ols2, Y, V, cv=5, scoring="neg_mean_absolute_error")
    V_mae = scores.mean()

    ols2 = LinearRegression()
    scores = cross_val_score(ols2, Y, Va, cv=5, scoring="neg_mean_absolute_error")
    Va_mae = scores.mean()

    # Find Xp, Xq, Xv, Xva - Try out on your own
    ols3 = LinearRegression()
    ols3.fit(X,P)
    arr1 = np.array(ols3.coef_)
    arr2 = np.array(ols3.intercept_)
    Xp = np.column_stack((arr1,arr2))

    ols4 = LinearRegression()
    ols4.fit(X,Q)
    arr1 = np.array(ols4.coef_)
    arr2 = np.array(ols4.intercept_)
    Xq = np.column_stack((arr1,arr2))
'''

    # X = [P Q I Ia]
    pls5 = PLSRegression()
    pls5.fit(X,V)
    Xv = np.array(pls5.coef_)
    Xv=np.transpose(Xv)
    #arr2 = np.array(pls5.intercept_)
    #Xv = np.column_stack((arr1,arr2))

    pls6 = PLSRegression()
    pls6.fit(X,Va)
    Xva = np.array(pls6.coef_)
    Xva =np.transpose(Xva)
    #arr2 = np.array(pls6.intercept_)
    #Xva = np.column_stack((arr1,arr2))

    #return [Xp, Xq, Xv, Xva, P_mape, Q_mape, V_mae, Va_mae]
    return [ Xv, Xva]

P = pd.read_csv('gen_data/P.csv', header = None)
Q = pd.read_csv('gen_data/Q.csv', header = None)
V = pd.read_csv('gen_data/V.csv', header = None)
Va = pd.read_csv('gen_data/Va.csv', header = None)
I= pd.read_csv('gen_data/I.csv', header = None)
Ia = pd.read_csv('gen_data/Ia.csv', header = None)
num_train = P.shape[0]
num_bus = P.shape[1]
intercept =pd.DataFrame(np.ones((num_train,1)))
 
#Scaling 
from sklearn.preprocessing import MinMaxScaler
scaler=MinMaxScaler()

P=scaler.fit_transform(P)
P= pd.DataFrame(P)
Q=scaler.fit_transform(Q)
Q= pd.DataFrame(Q)
V=scaler.fit_transform(V)
V= pd.DataFrame(V)
Va=scaler.fit_transform(Va)
Va= pd.DataFrame(Va)
I=scaler.fit_transform(I)
I= pd.DataFrame(I)
Ia=scaler.fit_transform(Ia)
Ia= pd.DataFrame(Ia)
#Saving Scaled Data
P.to_csv('gen_data/Scaled/P.csv', header = None,index=False)
Q.to_csv('gen_data/Scaled/Q.csv', header = None,index=False)
V.to_csv('gen_data/Scaled/V.csv', header = None,index =False)
Va.to_csv('gen_data/Scaled/Va.csv', header = None,index=False)
I.to_csv('gen_data/Scaled/I.csv', header = None,index=False)
Ia.to_csv('gen_data/Scaled/Ia.csv', header = None,index=False)


# [Xp, Xq, Xv, Xva, P_mape, Q_mape, V_mae, Va_mae] = OLS(P, Q, V, Va, num_train, num_bus)
[ Xv, Xva] = PLS(P, Q, V, Va,I,Ia, num_train, num_bus)

np.savetxt("gen_data/Xv.csv", Xv, delimiter=",")
np.savetxt("gen_data/Xva.csv", Xva, delimiter=",")

print(Xv.shape)
print(Xva.shape)