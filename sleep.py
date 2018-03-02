# you can write to stdout for debugging purposes, e.g.
# print("this is a debug message")

def solution(S):
    # write your code in Python 3.6
    schedule=S.split('\n')
    sorted_schedule=[]
    date_priority={}
    for item in schedule:
        if(item[0:3]=='Mon'):
            date_priority[item]=1
        elif(item[0:3]=='Tue'):
            date_priority[item]=2
        elif(item[0:3]=='Wed'):
            date_priority[item]=3         
        elif(item[0:3]=='Thu'):
            date_priority[item]=4       
        elif(item[0:3]=='Fri'):
            date_priority[item]=5
        elif(item[0:3]=='Sat'):
            date_priority[item]=6
        else:
            date_priority[item]=7
    
    
    ftr = [60,1]
    # sort the schedule
    sorted_schedule=sorted(date_priority, key=date_priority.__getitem__)
    for i in range(len(sorted_schedule)-1):
        day1=sorted_schedule[i]
        day2=sorted_schedule[i+1]
        if(day1[0:3]!=day2[0:3]):
            continue
        day1_start=day1[4:9]
        day2_start=day2[4:9]
        day1_start_num=sum([a*b for a,b in zip(ftr, map(int,day1_start.split(':')))])
        day2_start_num=sum([a*b for a,b in zip(ftr, map(int,day2_start.split(':')))])
        if(day1_start_num>day2_start_num):
            sorted_schedule[i]=day2
            sorted_schedule[i+1]=day1
        
    
    #compute the sleep time.
    sleep_list=[]
    for i in range(len(sorted_schedule)-1):
        
        end_time=sorted_schedule[i][10:15]
        start_time=sorted_schedule[i+1][4:9]
        
        end_minutes=sum([a*b for a,b in zip(ftr, map(int,end_time.split(':')))])
        start_minutes=sum([a*b for a,b in zip(ftr, map(int,start_time.split(':')))])
        if(sorted_schedule[i+1][0:3]!=sorted_schedule[i][0:3]):
            start_minutes+=24*60
        
        sleep_list.append(start_minutes-end_minutes)
        
    # edge case: SUnday to Monday
    Sunday=sorted_schedule[len(sorted_schedule)-1]
    end_time=Sunday[10:15]
    sunday_num=sum([a*b for a,b in zip(ftr, map(int,end_time.split(':')))])
    sleep_list.append(24*60-sunday_num)
    

    return max(sleep_list)
    
