arr=[5,3,9,2,8,24,1,2,6]
sum= 33
l=len(arr)
ar=[]
currSum = arr[0]
start=0
end=0
def ss(s,e):
    while(s<=e):
        ar.append(arr[s])
        s=s+1

while (end < l):
    if (currSum == sum):
        ss(start,end)
        break
    if (currSum <= sum):
        end=end+1
        if (end < l):
            currSum = currSum + arr[end]
    else:
        currSum = currSum - arr[start]
        start=start+1
print(ar)

