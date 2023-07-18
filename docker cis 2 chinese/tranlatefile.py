import os
import re
import random
import requests
import json
from hashlib import md5
from time import sleep


def Readfile():
    reg=re.compile(r'\s\slocal\sid=.*\n\s\slocal\sdesc=.*\n\s\slocal.*\n\s\slocal.*\n')
    reg_desc=re.compile(r'\slocal\sdesc="(.*)"')
    reg_remediation=re.compile(r'remediation="(.*)"')
    reg_remediationImpact=re.compile(r'\slocal\sremediationImpact="(.*)"')
    for root,dirs,files in os.walk(r"C:\Users\loong\mynote\docker cis 2 chinese\docker-bench-security-1.5.0\tests",topdown=True):
        for file in files:
            with open(os.path.join(root,file),"r+") as f:
                content=f.readlines()
                # getinfos=re.findall(reg,content)
                # print(getinfos[0])

                with open(os.path.join(r"C:\Users\loong\mynote\docker cis 2 chinese\docker-bench-security-1.5.0\tests\out",file),"+a") as a:

                    for line in content:
                            for regi in [reg_desc,reg_remediation,reg_remediationImpact]:
                                if re.search(regi,line):
                                    text1=re.findall(regi,line)[0]
                                    sleep(random.randint(1,3))
                                    src,dest=baiduTranslate(text1)
                                    print(src)
                                    print(dest)
                                    print(line)
                                    prt=re.sub(src,dest,line)
                                    print(prt)
                                    a.write(prt)
                                else:
                                    a.write(line)
                                    pass
                break


def baiduTranslate(text):
    # Set your own appid/appkey.
    appid = '20210114000670951'
    appkey = 'zTlniq5NZkxJYelgEgGN'

    # For list of language codes, please refer to `https://api.fanyi.baidu.com/doc/21`
    from_lang = 'en'
    to_lang =  'zh'

    endpoint = 'http://api.fanyi.baidu.com'
    path = '/api/trans/vip/translate'
    url = endpoint + path

    query = text

    # Generate salt and sign
    def make_md5(s, encoding='utf-8'):
        return md5(s.encode(encoding)).hexdigest()

    salt = random.randint(32768, 65536)
    sign = make_md5(appid + query + str(salt) + appkey)

    # Build request
    headers = {'Content-Type': 'application/x-www-form-urlencoded'}
    payload = {'appid': appid, 'q': query, 'from': from_lang, 'to': to_lang, 'salt': salt, 'sign': sign}

    # Send request
    r = requests.post(url, params=payload, headers=headers)
    result = r.json()

    # Show response
    out=json.dumps(result, indent=4, ensure_ascii=False)
    # print(result)
    return result['trans_result'][0].get('src'),result['trans_result'][0].get('dst')

if __name__ == '__main__':
    # baiduTranslate()
    Readfile()