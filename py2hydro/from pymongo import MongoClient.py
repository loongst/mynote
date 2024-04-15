from pymongo import MongoClient
import base64
import json
import datetime
# 连接到MongoDB实例

 

class Monitordb:
    client = MongoClient('mongodb://hydro:sHRaXSmxJKrUnRt9FMercL9aJsbomYCj@192.168.228.128:27017/hydro')

# 选择数据库
db = client['hydro']
 
# 选择集合
collection = db['storage']

# users={"loong":2,"user1":3,"user2":4,"user3":5}
users={"loong":2,"user1":3,"user2":4,"user3":5}
pids={33,34}
 
# 执行查询
# query = {'owner': {'$regex':"^izx"}}

# for u in users.keys():
#     query = {'owner': users[u]}
#     print(query)
#     results = collection.find(query)
    
#     # 打印查询结果

#     for doc in results:
#         print(doc)
#         print(base64.b64decode(doc["etag"]).decode() )
#         print(doc["path"])
#         print(doc['owner'])

collection2=db['record']

# for u in users.keys():
#     query2={'uid':users[u]}
#     print(query2)
#     results2=collection2.find(query2)
#     for doc2 in results2:
#         print(doc2)

# ...
# items={}
# for pid in pids:
#     query2={'pid':pid}
#     print(query2)
#     result2=collection2.find(query2)
# #     print(result2)
# #     items[pid]=[x for x in result2]
# # print(items)
#     for doc2 in result2:
#         if doc2['status']==1:

#             print(doc2)
#     #         print(doc2['files']['code'])

#     #         for uid in users.values():
#     #             if doc2['uid']==uid:


# # for pid in [34]:
# #     item_tmp=items[pid]
# #     for i in item_tmp:
# #         if not i['status']==1:
# #             item_tmp.remove(i)

# # ...


items={}
for pid in pids:
    items[pid]={}
    query2={'pid':pid}
    print(query2)
    result2=collection2.find(query2)
    tmp={}
    for uid in users.values():
        tmp[uid]=[]
    for doc2 in result2:
        for uid in users.values():
            if doc2['uid']==uid:
              if doc2['status']==1:
                tmp[uid].append(doc2)
              else:
                  print("clean failed record")
    print(tmp)
    items[pid]=tmp

print("-"*100)
print(items)


for pid in pids:
    for uid in users.values():
        print(pid,uid)
        print(len(items[pid][uid]))
        if len(items[pid][uid])>1:
            print(items[pid][uid])
            cleans=items[pid][uid]
            endtime=datetime.datetime(2024, 1, 1, 2, 50, 55, 512000)
            # for x in range(len(cleans)):
            #     if cleans[x]['judgeAt']>endtime:
            #         endtime=cleans[x]['judgeAt']
            #     else:
            #         cleans.remove(cleans[x])
            # print(cleans)
            endx=''
            for x in cleans:
                if x['judgeAt']>endtime:
                    endtime=x['judgeAt']
                    endx=x

            print(endx)
            items[pid][uid]=endx

print(items)




















#  [{'_id': ObjectId('65b8553a54292cd283fa1043'), 'status': 1, 'uid': 2, 'code': None, 'lang': '_', 'pid': 34, 'domainId': 'CFIT', 'score': 100, 'time': 0, 'memory': 0, 'judgeTexts': [], 'compilerTexts': [], 'testCases': [{'id': 1, 'status': 1, 'score': 100, 'time': 0, 'memory': 0, 'message': '', 'subtaskId': 0}], 'judger': 1, 'judgeAt': datetime.datetime(2024, 1, 30, 1, 47, 38, 995000), 'rejudged': False, 'files': {'code': '2/aZzxIRnQrZvYkT_yRmq0Y#sqli.zip'}, 'subtasks': {'1': {'type': 'sum', 'score': 100, 'status': 1}}}, 
# {'_id': ObjectId('65d595fe825e4e4e01d14ff1'), 'status': 1, 'uid': 2, 'code': None, 'lang': '_', 'pid': 34, 'domainId': 'CFIT', 'score': 100, 'time': 0, 'memory': 0, 'judgeTexts': [], 'compilerTexts': [], 'testCases': [{'id': 1, 'status': 1, 'score': 100, 'time': 0, 'memory': 0, 'message': '', 'subtaskId': 0}], 'judger': 1, 'judgeAt': datetime.datetime(2024, 2, 21, 6, 19, 43, 274000), 'rejudged': False, 'files': {'code': '2/yshS2pgWcbxkRYMySQjn6#sqli.zip'}, 'subtasks': {'1': {'type': 'sum', 'score': 100, 'status': 1}}},
# {'_id': ObjectId('6618a00c109622f735723b9f'), 'status': 2, 'uid': 3, 'code': None, 'lang': '_', 'pid': 34, 'domainId': 'CFIT', 'score': 0, 'time': 0, 'memory': 0, 'judgeTexts': [], 'compilerTexts': [], 'testCases': [{'id': 1, 'status': 2, 'score': 0, 'time': 0, 'memory': 0, 'message': {'message': 'File not found.'}, 'subtaskId': 0}], 'judger': 1, 'judgeAt': datetime.datetime(2024, 4, 12, 2, 44, 28, 916000), 'rejudged': False, 'contest': ObjectId('66189807109622f735723b02'), 'files': {'code': '3/ufCUo6wVbrtTCXapHKhD0#mysubmit.zip'}, 'subtasks': {'1': {'type': 'sum', 'score': 0, 'status': 2}}, 'progress': 100},
# {'_id': ObjectId('6618a092109622f735723bab'), 'status': 1, 'uid': 3, 'code': None, 'lang': '_', 'pid': 34, 'domainId': 'CFIT', 'score': 100, 'time': 0, 'memory': 0, 'judgeTexts': [], 'compilerTexts': [], 'testCases': [{'id': 1, 'status': 1, 'score': 100, 'time': 0, 'memory': 0, 'message': '', 'subtaskId': 0}], 'judger': 1, 'judgeAt': datetime.datetime(2024, 4, 12, 2, 46, 43, 160000), 'rejudged': False, 'contest': ObjectId('66189807109622f735723b02'), 'files': {'code': '3/hYlE4Oq_g7SM7TxrGdSHg#mysub.zip'}, 'subtasks': {'1': {'type': 'sum', 'score': 100, 'status': 1}}, 'progress': 100}]