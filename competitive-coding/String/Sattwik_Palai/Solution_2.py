#Solution for You are given a string (For eg: Input str = "1??0?101"). You have to return all strings by replacing '?' as '1' or '0'
ans = [] 
def String_Change(p): 
    if '?' in p: 
        p1 = p.replace('?','0',1)  
        p2 = p.replace('?','1',1) 
        String_Change(p1) 
        String_Change(p2) 
    else: ans.append(p) 
  
# Trial code 
String_Change("0???0?1?100?") 
print(ans) 
