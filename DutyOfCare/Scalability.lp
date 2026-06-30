props(1..100).
perm(1..100,j1).
parent(a,b).
judge(j1;j2;j3).


hasProp(a,1..50,j1). hasProp(a,1..50,j2). hasProp(a,1..50,j3).
hasProp(b,51..100,j1). hasProp(b,51..100,j2). hasProp(b,51..100,j3).
-goodness(1..20,j1).
-badness(1..20,j1). 
goodness(21..80,j1). 
badness(81..100,j1). 

weight(X,X,j1) :- props(X), X>20. 
choose(a,j1).

badness(1..20,j2). 
goodness(21..80,j2). 
badness(81..100,j2). 
weight(X,X,j2) :- props(X). 
choose(a,j2).

badness(1..20,j3). 
goodness(21..80,j3). 
-badness(81..100,j3). 
-goodness(81..100,j3). 

weight(X,X,j3) :- props(X), X<81. 
choose(a,j3).


#show points/3.
