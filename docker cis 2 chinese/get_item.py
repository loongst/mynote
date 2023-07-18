import os
import re
import random
import requests
import json
from hashlib import md5
from time import sleep

def star():
    reg=re.compile(r'\s\slocal\sid=.*\n\s\slocal\sdesc=.*\n\s\slocal.*\n\s\slocal.*\n')
    for root,dirs,files in os.walk(r"C:\Users\loong\mynote\docker cis 2 chinese\docker-bench-security-1.5.0\tests",topdown=True):
        for file in files:
            with open(os.path.join(root,file),"r+") as f:
                content=f.read()
                getinfos=re.findall(reg,content)
                print(getinfos[0])
            break

def tranlate():
    text='''
  local id="1.1.1"
  local desc="Ensure a separate partition for containers has been created (Automated)"
  local remediation="For new installations, you should create a separate partition for the /var/lib/docker mount point. For systems that have already been installed, you should use the Logical Volume Manager (LVM) within Linux to create a new partition."
  local remediationImpact="None."
'''
    desc=re.findall(r'local\sdesc="(.*)"',text)[0]
    remediation=re.findall(r'local\sremediation="(.*)"',text)[0]
    remediationImpact=re.findall(r'local\sremediationImpact="(.*)"',text)[0]
    for i in [desc,remediation,remediationImpact]:
        if len(i)>8:
            sleep(1)
            baidu(i)




def baidu(text):
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
    with open('outfile',"a+") as f:
        f.write(out['tran'])
    print()


def baiduTranslate(translate_text, flag=0):
    '''
    :param translate_text: 待翻译的句子，len(q)<2000
    :param flag: 1:原句子翻译成英文；0:原句子翻译成中文
    :return: 返回翻译结果。
    For example:
    q=我今天好开心啊！
    result = {'from': 'zh', 'to': 'en', 'trans_result': [{'src': '我今天好开心啊！', 'dst': "I'm so happy today!"}]}
    '''

    appid = '20210114000670951'  # 填写你的appid
    secretKey = 'zTlniq5NZkxJYelgEgGN'  # 填写你的密钥
    httpClient = None
    myurl = '/api/trans/vip/translate'  # 通用翻译API HTTP地址
    fromLang = 'auto'  # 原文语种

    if flag:
        toLang = 'en'  # 译文语种
    else:
        toLang = 'zh'  # 译文语种

    salt = random.randint(3276, 65536)

    sign = appid + translate_text + str(salt) + secretKey
    sign = hashlib.md5(sign.encode()).hexdigest()
    myurl = myurl + '?appid=' + appid + '&q=' + urllib.parse.quote(translate_text) + '&from=' + fromLang + \
            '&to=' + toLang + '&salt=' + str(salt) + '&sign=' + sign

    # 建立会话，返回结果
    try:
        httpClient = http.client.HTTPConnection('api.fanyi.baidu.com')
        httpClient.request('GET', myurl)
        # response是HTTPResponse对象
        response = httpClient.getresponse()
        result_all = response.read().decode("utf-8")
        result = json.loads(result_all)

        # return result
        return result['trans_result'][0]['dst']

    except Exception as e:
        print(e)
    finally:
        if httpClient:
            httpClient.close()
if __name__ == '__main__':
    # # 手动录入翻译内容，q存放
    # # q = raw_input("please input the word you want to translate:")
    # q = "介绍一下整本书，比如是传主的人生，或者作者写这本书的特色。可参看目录、序言或简介等资料。"
    # '''
    # flag=1 输入的句子翻译成英文
    # flag=0 输入的句子翻译成中文
    # '''
    # result = baiduTranslate(q, flag=1)  # 百度翻译
    # print("原句:"+q)
    # print(result)
    tranlate()
    # baidu