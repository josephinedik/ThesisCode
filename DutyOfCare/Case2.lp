
props(waitedVisit;movedChild;capable).

perm(waitedVisit,j1).
perm(movedChild,j1).
obl(capable,j1).

hasProp(a,capable,j1). hasProp(b,capable,j1). 
hasProp(a,waitedVisit,j1). hasProp(b,movedChild,j1). 

goodness(movedChild,j1). badness(waitedVisit,j1).
weight(waitedVisit,3,j1). weight(movedChild,3,j1).
weight(suitable,20,j1).

choose(b,j1).

judge(j2).
hasProp(a,capable,j2). hasProp(b,capable,j2). 
hasProp(a,waitedVisit,j2). hasProp(b,movedChild,j2). 
weight(waitedVisit,3,j2). weight(movedChild,3,j2).
badness(movedChild,j2).  goodness(waitedVisit,j2).


#show points/3.




