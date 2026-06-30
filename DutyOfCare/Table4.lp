parent(a;b).                                                                                          %(0)                      
points(P,X,J) :- X=#sum{Z: values(Y,Z,J), hasProp(P,Y,J)}, parent(P), not obl(-choose(P),J),judge(J). %(a)

obl(choose(P),J) :- X>Y, points(P,X,J), points(Q,Y,J). %(b)                                           %(b)                  
perm(choose(P),J) :- X=Y, points(P,X,J), points(Q,Y,J), P!=Q. %(b)                                    %(c)                          
obl(-choose(neither),J) :- perm(choose(a),J), perm(choose(b),J). %(d)                                 %(d)                          
obl(choose(neither),J) :- obl(-choose(a),J), obl(-choose(b),J). %(e)                                  %(e)                              
obl(choose(P),J) :- obl(-choose(Q),J), not obl(-choose(P),J), P!=Q, parent(P), parent(Q). %(f)        %(f)                                  

viol(obl(choose(P,J)),I) :- obl(choose(P),J), not choose(P,J), high(J,I).                             %(g)                  



