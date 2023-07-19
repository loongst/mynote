import os
import re
import random
import requests
import json
from hashlib import md5
from time import sleep
import scrapy
import csv

def Readfile():
    reg=re.compile(r'\s\slocal\sid=.*\n\s\slocal\sdesc=.*\n\s\slocal.*\n\s\slocal.*\n')
    reg_id=re.compile(r'\slocal\sid="(.*)"')
    reg_desc=re.compile(r'\slocal\sdesc="(.*)"')
    reg_remediation=re.compile(r'remediation="(.*)"')
    reg_remediationImpact=re.compile(r'\slocal\sremediationImpact="(.*)"')
    for root,dirs,files in os.walk(r"C:\Users\loong\mynote\docker cis 2 chinese\docker-bench-security-1.5.0\tests",topdown=True):
        for file in files:
            content=''
            with open(os.path.join(root,file),"r+",encoding="utf-8") as f:
                content=f.readlines()

            with open(os.path.join(r"C:\Users\loong\mynote\docker cis 2 chinese\docker-bench-security-1.5.0\tests\out",file),"+a",encoding="utf-8") as a:
                flag=0
                flag2=0
                for line in content:
                    if flag!=0:
                        flag-=1
                        continue
                    else:
                        if not line.startswith("  local"):
                            a.write(line)

                        else:
                            if flag2!=0:
                                flag2-=1
                                a.write(line)


                            if re.search(reg_id,line):
                                id=re.findall(reg_id,line)[0]
                                row= ReadCSV(id)
                                if row:
                                    a.write(line)
                                    desc="  local desc="+row[3]+"  【"+row[4]+"】"
                                    remediation="  local remediation="+row[6]
                                    a.write(desc)
                                    a.write(remediation)
                                    flag=2
                                else:
                                    a.write(line)
                                    flag2=2
                            else:
                                # a.write(line)
                                if re.search(reg_desc,line):
                                    pass
                                elif re.search(reg_remediation,line):
                                    pass
                                else:
                                    a.write(line)




def ReadCSV(id):
    
    # 打开文件，指定读取模式
    with open(r'C:\Users\loong\mynote\docker cis 2 chinese\cis.CSV', 'r') as file:
        # 创建csv读取对象
        reader = csv.reader(file)
        # 跳过表头
        next(reader)
        # 遍历每一行数据
        i=0
        for row in reader:
            if row[0]==id:
                return row
            else:
                print(id+"-没有匹配到数据")
                return 0


ReadCSV()