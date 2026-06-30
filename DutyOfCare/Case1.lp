props(childWants;moveChild;money;badRel;capable). 


% Judge 1
hasProp(a,childWants,j1). hasProp(a,moveChild,j1).  
 hasProp(a,capable,j1).      

hasProp(b,capable,j1).  hasProp(b,money,j1).         
hasProp(b,badRel,j1).                              

badness(moveChild,j1). badness(badRel,j1).                   
 goodness(childWants,j1).               

perm(childWants). 
perm(moveChild). perm(badRel).
obl(capable).

weight(childWants, 100,j1). weight(moveChild, 30,j1).
weight(badRel, 50,j1). 
choose(a, j1).

% Judge 2
judge(j2).
hasProp(a,childWants,j2).  hasProp(a,moveChild,j2). 
 hasProp(a,capable,j1). 
 -hasProp(b,badRel,j2). 
hasProp(b,capable,j1). 

badness(moveChild,j2). 
-goodness(childWants,j2). -badness(childWants,j2).
badness(badRel,j2). 

weight(moveChild,60,j2). 
choose(b, j2).

%Judge 3 Supreme Court
judge(j3).
hasProp(a,childWants,j3).  hasProp(a,moveChild,j3). 


 hasProp(b,badRel,j3). 

badness(moveChild,j3). badness(badRel,j3). 
 goodness(childWants,j3). 

weight(badRel,50,j3). weight(childWants,100,j3).
weight(moveChild,45,j3). 

