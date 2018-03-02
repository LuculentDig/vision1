    # you can write to stdout for debugging purposes, e.g.
# print("this is a debug message")

def solution(A):
    # write your code in Python 3.6
    the_max=max(A)
    row_num=len(A)
    matrix=[]
    for i in range(row_num):
        row=[]
        for j in range(the_max):
            row.append(0)
        
        matrix.append(row)
        
        
    # we have a zero matrix
    for i in range(row_num):
        for j in range(A[i]):
            matrix[i][j]=1
          
    total_paint=0
    for j in range(len(matrix[0])):
        paint_count=0
        for i in range(row_num):
            if(matrix[i][j]==1):
                paint_count=1
            else:
                total_paint+=paint_count
                paint_count=0
            if(i==row_num-1 and paint_count==1):
                total_paint+=paint_count
                paint_count=0
    return total_paint
