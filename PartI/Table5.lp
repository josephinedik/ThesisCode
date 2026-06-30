viol(permPlus(X,J),permZero(X,I)) :- permPlus(X,J), permZero(X,I), high(J,I).                    %(1)
viol(permMin(X,J),permZero(X,I)) :- permMin(X,J), permZero(X,I), high(J,I).                      %(2) 

viol(permZero(X,J),permPlus(X,I)) :- permZero(X,J), permPlus(X,I), high(J,I).                    %(3)                   
viol(permZero(X,J),permMin(X,I)) :- permZero(X,J), permMin(X,I), high(J,I).                      %(4)                           

viol(permPlus(X,J),permMin(X,I)) :- permPlus(X,J), permMin(X,I), high(J,I).                      %(5)                     
viol(permMin(X,J),permPlus(X,I)) :- permMin(X,J), permPlus(X,I), high(J,I).                      %(6)                   

viol(hasProp(P,X,J),-hasProp(P,X,I)):-  hasProp(P,X,J), -hasProp(P,X,I), high(J,I).              %(7)                       
viol(-hasProp(P,X,J),hasProp(P,X,I)):-  -hasProp(P,X,J), hasProp(P,X,I),high(J,I).               %(8)                   

viol(weight(X,M,J),weight(X,N,I)) :- weight(X,M,J), weight(X,N,I), M!=N, high(J,I), M>0, N>0.    %(9)                   
viol(ord(X,Y,J), ord(Y,X,I)) :- ord(X,Y,J), ord(Y,X,I), high(J,I).                               %(10)               
