

obl(-X)   :- -perm(X). -perm(-X) :- obl(X). perm(-X)  :- -obl(X). -obl(-X)  :- perm(X). %(1)      
:- obl(X), obl(-X). perm(X) :- obl(X).                                                  %(2)

-goodness(X) :- badness(X). -badness(X) :- goodness(X).                                 %(3)

permPlus(X) :- goodness(X), props(X), perm(X).                                          %(4)
permMin(X)  :- badness(X), props(X), perm(X).                                           %(5)
permZero(X) :- not permMin(X), not permPlus(X), props(X), perm(X).                      %(6)

1{weight(X,N): num(N)}1:- props(X).                                                     %(7)
num(1..21).                                                                             %(8)

weight(X,0) :- permZero(X).                                                             %(9)
values(X,0) :- weight(X,0).                                                             %(10)
values(X,Y)  :- weight(X,Y), permPlus(X).                                               %(11)
values(X,-Y) :- weight(X,Y), permMin(X).                                                %(12)

points(P,X) :- X=#sum{N,Y :values(Y,N), hasProp(P,Y)}, parent(P).                       %(13)
choose(P) :- X>Y, points(P,X), points(Q,Y), parent(P), parent(Q).                       %(14)
:- X=Y, points(P,X), points(Q,Y), P!=Q.                                                 %(15)
:- choose(P), choose(Q), P!= Q.                                                         %(16)

category(unimp). category(imp). category(veryimp).                                      %(17)
:- props(X), catProp(X,unimp), weight(X,N), N>7, num(N).                                %(18)
:- props(X), catProp(X,imp), weight(X,N), N<8, num(N).                                  %(19)
:- props(X), catProp(X,imp), weight(X,N), N>14, num(N).                                 %(20)
:- props(X), catProp(X,veryimp), weight(X,N), N<15, num(N).                             %(21)
1{catProp(X,Y):category(Y)}1 :- props(X).                                               %(22)

perm(X) :- props(X).                                                                    %(23)