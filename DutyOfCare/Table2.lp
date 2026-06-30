judge(j1).                                                        %(1)
high(j1,j2) :- judge(j1), judge(j2).                              %(2)                       
high(j1,j3) :- judge(j1), judge(j2), judge(j3).                   %(3)           
high(j2,j3) :- judge(j1), judge(j2), judge(j3).                   %(4)   