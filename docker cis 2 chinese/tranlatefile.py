import os
import re
import random
import requests
import json
from hashlib import md5
from time import sleep
import scrapy
import execjs


def Readfile():
    reg=re.compile(r'\s\slocal\sid=.*\n\s\slocal\sdesc=.*\n\s\slocal.*\n\s\slocal.*\n')
    reg_desc=re.compile(r'\slocal\sdesc="(.*)"')
    reg_remediation=re.compile(r'remediation="(.*)"')
    reg_remediationImpact=re.compile(r'\slocal\sremediationImpact="(.*)"')
    for root,dirs,files in os.walk(r"C:\Users\loong\mynote\docker cis 2 chinese\docker-bench-security-1.5.0\tests",topdown=True):
        for file in files:
            with open(os.path.join(root,file),"r+",encoding="utf-8") as f:
                content=f.readlines()
                # getinfos=re.findall(reg,content)
                # print(getinfos[0])

                with open(os.path.join(r"C:\Users\loong\mynote\docker cis 2 chinese\docker-bench-security-1.5.0\tests\out",file),"+a",encoding="utf-8") as a:

                    for line in content:
                        
                            # for regi in [reg_desc,reg_remediation,reg_remediationImpact]:
                            #     if re.search(reg_desc,line) or re.search(reg_remediation,line) or re.search(reg_remediationImpact,line):
                            #         text1=re.findall(regi,line)[0]
                            #         sleep(random.randint(1,3))
                            #         src,dest=baiduTranslate(text1)
                            #         print(src)
                            #         print(dest)
                            #         print(line)
                            #         prt=re.sub(src,dest,line)
                            #         print(prt)
                            #         a.write(prt)
                            #     else:
                            #         a.write(line)
                            #         pass

                        if not line.startswith("  local"):
                            a.write(line)
                        elif re.search(reg_desc,line):
                            text1=re.findall(reg_desc,line)[0]
                            src,dest=baiduTranslate(text1)
                            sleep(1)
                            prt=re.sub(src,dest,line)
                            print(prt)
                            a.write(prt)
                        elif re.search(reg_remediation,line):
                            text1=re.findall(reg_remediation,line)[0]
                            src,dest=baiduTranslate(text1)
                            sleep(1)
                            prt=re.sub(src,dest,line)
                            print(prt)
                            a.write(prt)
                        elif re.search(reg_remediationImpact,line):
                            text1=re.findall(reg_remediationImpact,line)[0]
                            src,dest=baiduTranslate(text1)
                            sleep(1)
                            prt=re.sub(src,dest,line)
                            print(prt)
                            a.write(prt)
                        else:
                            a.write(line)
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
    print(result)
    return result['trans_result'][0].get('src'),result['trans_result'][0].get('dst')


def translate(text):
        url = 'https://fanyi.baidu.com/v2transapi?from=en&to=zh'
        query = text

        with open('pGrab.js', mode='r', encoding='utf-8') as f:
            sign = execjs.compile(f.read()).call("tl", query)

        # print(sign)
        headers = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.0.0 Safari/537.36',
        }
        cookies = {
        }

        data = {
        'from': 'en',
        'to': 'zh',
        'query': query,
        'transtype': 'realtime',
        'simple_means_flag': '3',
        'sign': sign,
        'token': '69bc413a68f32b1bcfa6e91c29c95d40',
        'domain': 'common',
        }

        r=requests.post(url=url, headers=headers, data=data, cookies=cookies)
        result=r.json()
        print(result)

if __name__ == '__main__':
    # baiduTranslate()
    # Readfile()
    translate("home")