# s=input()
# # a,b=[]
# # for x in s:
# #   if not a:
# #     a.apend(x)
# #     continue
# #   if x ==a[0]:
# #     a.append(x)
# #   else:
# #     b.append(x)
# # if len(a)>len(b):
# for i in range(1,len(s)-1):
#   a,b,c=s[i-1],s[i],s[i+1]
#   if a==b and b!=c:
#     print(i+2)
#     break
#   elif a!=b and b==c:
#     print(i)
#     break
#   elif a==c and a!=b:
#     print(i+1)
#     break


# p=input()
# Pline=[]
# line=input()
# for i in line.split(" "):
#     Pline.append(i)
# q=input()
# qlist=[]
# for i in range(int(q)):
#     qlist.append(input())

# for i in qlist:
#     [a,b]=[x for x in i.split(" ")]
#     # j=k=0
#     # print(a,b)
#     for j in range(int(p)):
#         if Pline[j]==a:
#             for k in range(int(p)):
#                 if Pline[k]==b:
#                     if j<k:
#                         print(a)
#                     else:
#                         print(b)


# # print(Pline)
# # print(qlist)



# a='''

# p=input()

# line=input()

# q=input()
# qlist=[]
# for i in range(int(q)):
#     qlist.append(input())

# # for i in range(len(qlist)//2+1):
# #     for j in range(i+1,len(qlist)):
# #         if qlist[i][::-1]==qlist[j]:
# #             y,z=qlist[i],qlist[j]
# #             qlist.remove(y)
# #             qlist.remove(z)

# for i in qlist:
#     if i.split(" ")[0]==i.split(" ")[1]:
#         qlist.remove(i)


# # for i in qlist:
# #     [a,b]=[x for x in i.split(" ")]
# #     line=line.replace(a,b)    
# # print(line)
# s=list(line)
# for i in qlist:
#     [a,b]=i.split(" ")
#     for x in range(len(s)):
#         if a==s[x]:
#             s[x]=b
# print(''.join(s))
# '''


p=input()

line=input()
s=list(line)
q=input()
qlist=[]
for i in range(int(q)):
    [a,b]=input().split(" ")
    for x in range(len(s)):
        if a==s[x]:
            s[x]=b
print(''.join(s))

# print(qlist)
# s=list(line)
# for i in qlist:
#     [a,b]=i.split(" ")
#     for x in range(len(s)):
#         if a==s[x]:
#             s[x]=b
# print(''.join(s))