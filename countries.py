# you can write to stdout for debugging purposes, e.g.
# print("this is a debug message")

def solution(A):
    # write your code in Python 3.6
    countries={}
    country_count=0
    for i in range(len(A)):
        for j in range(len(A[0])):
            if(i==0 and j==0): # edge case
                country_count+=1
                countries[(i,j)]=country_count
            elif(i==0):
                if(A[i][j]==A[i][j-1]):
                    t=(i,j-1)
                    temp=countries[t]
                    countries[tuple(t)]=temp
            elif(j==0):
                if(A[i][j]==A[i-1][j]):
                    temp=countries[(i-1,j)]
                    countries[(i,j)]=temp
                    break
            else:
                if(A[i][j]==A[i][j-1] and A[i][j]==A[i-1][j]):
                    small=min(countries[A[i-1][j]],countries[A[i],[j-1]])
                    big=max(countriesso[A[i-1][j]],countries[A[i],[j-1]])
                    for country in countries:
                        if(countries[country]==big):
                            countries[country]=small
                    countries[(i,j)]=small
                elif(A[i][j]==A[i-1][j]):
                    countries[(i,j)]=countries[(i-1,j)]
                elif(i==0):
                    if(A[i][j]==A[i][j-1]):
                        countries[(i,j)]=countries[(i,j-1)]
                else: #new country
                    country_count+=1
                    countries[(i,j)]=country_count
    
    # 
    set_of_countries={}
    for country in countries:
        set_of_countries.add(countries[country])
        
    return(len(set_of_countries))
                    


a=[[5, 4, 4], [4, 3, 4], [3, 2, 4], [2, 2, 2], [3, 3, 4], [1, 4, 4], [4, 1, 1]]

result=solution(a)
