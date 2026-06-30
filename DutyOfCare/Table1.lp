%% Properties of the norms
obl(-X,J)   :- -perm(X,J).      %(1)
-perm(-X,J) :- obl(X,J).        %(2)
perm(-X,J)  :- -obl(X,J).       %(3)
-obl(-X,J)  :- perm(X,J).       %(4)
:- obl(X,J), obl(-X,J).         %(5)
perm(X,J) :- obl(X,J).          %(6)

-goodness(X,J) :- badness(X,J).         %(7)
-badness(X,J) :- goodness(X,J).         %(8)

permPlus(X,J) :- goodness(X,J), props(X), perm(X,J).       %(9)
permMin(X,J)  :- badness(X,J), props(X), perm(X,J).        %(10)
permZero(X,J) :- not permMin(X,J), not permPlus(X,J), props(X), perm(X,J).  %(11)

obl(-choose(P),J) :- obl(-Y,J), hasProp(P,Y,J).     %(12)
obl(-choose(P),J) :- obl(Y,J), -hasProp(P,Y,J).     %(13)

weight(X,0,J) :- permZero(X,J).                                %(14)
values(X,0,J) :- weight(X,0,J).                                %(15) 
values(X,Y,J)  :- weight(X,Y,J), permPlus(X,J).                %(16)
values(X,-Y,J) :- weight(X,Y,J), permMin(X,J).                 %(17)


ord(X,Y,J) :- weight(X,N,J), weight(Y,M,J), N>M, X!=Y, M>0.   %(18)
