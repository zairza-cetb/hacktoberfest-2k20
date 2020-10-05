def subSum(arr, n, sum):
        ar=[]
        for i in range(l): 
            curr_sum = arr[i] 
            j = i + 1
            while(j<=n): 
                if(curr_sum == sum): 
                    print("the sub array is")
                    while(i<j):
                        ar.append(arr[i])
                        i=i+1
                    print(ar)
                    return 1
                if(curr_sum > sum or j == n): 
                    break
                curr_sum = curr_sum + arr[j] 
                j += 1
        print("No subarray found") 
        return 0
#Let the array and sum be taken as:-
arr=[2,5,3,8,13,1,6,23,9]
sum= 24
l=len(arr)
subSum(arr,l,sum)
