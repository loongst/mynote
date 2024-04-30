import configparser
import re
import os
import logging
import pip
try:
    import coloredlogs
    import xlwings as xw
except ImportError as e:
    print(e)
    print("正在安装依赖包...")
    for i in os.listdir("./lib"):
        pip.main(["install","/lib/"+i])



class myreplace:

    def __init__(self) -> None:

        #从配置文件获取信息
        config=configparser.ConfigParser()
        config.read('config.ini')
        self.projectname="/"+config.get("env","projectname") if config.get("env","projectname") else ""
        self.ip_server=config.get("env","ip_server")
        self.port_server=config.get("env","port_server")
        self.ip_db=config.get("mysql","ip_db")
        self.name_db=config.get("mysql","name_db")
        self.user=config.get("mysql","user")
        self.passwd=config.get("mysql","passwd")

        #当前目录
        self.case_root_dir=os.getcwd()

        #配置日志打印
        coloredlogs.install(level='DEBUG', fmt='[%(levelname)s] %(asctime)s  %(message)s')
        logging.warning('case_root_dir: '+self.case_root_dir)

        # 字典路径正则
        self.reg=re.compile(r'D:\\\\工作\\\\测试效能平台')
        #当前字典路径
        self.dict_path=(self.case_root_dir ).replace("\\","\\\\\\\\")

    def replace_env(self,filepath):
        wb=xw.Book(filepath)
        sheet=wb.sheets[0]
        sheet["B2"].value=""
        sheet["C2"].value=""
        sheet["D2"].value=""
        wb.save()
        wb.close()


    #获取excle并替换http路径
    def replace_http(self,filepath):
        wb=xw.Book(filepath)
        sheet=wb.sheets[0]
        
        rows_count=sheet.used_range.shape[0]
        logging.warning("row count: "+str(rows_count))
        for i in range(2,rows_count+1):
            course=sheet["E{}".format(i)].value
            if course:
                course=course.replace('/websms',self.projectname)
                sheet["E{}".format(i)].value=course
                logging.error(course)
        wb.save()
        wb.close()


    #获取excle并替换字典路径
    def replace_dict(self,filepath):
        wb=xw.Book(filepath)
        sheet=wb.sheets[0]       
        rows_count=sheet.used_range.shape[0]
        logging.warning("row count: "+str(rows_count))
        for i in range(2,rows_count+1):
            try:
                courseG=sheet["G{}".format(i)].value
                courseH=sheet["H{}".format(i)].value
                if courseG and courseG.endswith(".txt"):
                    courseG=re.sub(self.reg,self.dict_path,courseG)
                    sheet["G{}".format(i)].value=courseG
                    logging.info(courseG)
                if courseH and courseH.endswith(".txt"):
                    courseH=re.sub(self.reg,self.dict_path,courseH)
                    sheet["H{}".format(i)].value=courseH
                    logging.info(courseH)
            except Exception as e:
                logging.error("handling line {} failed!".format(i))
                logging.error(e)
                            
        wb.save()
        wb.close()



    #遍历目录下的文件
    def Traversal_file(self):
        for root,dirs,files in os.walk(self.case_root_dir):

            for file in files:
                abpath=os.path.join(root,file)
                logging.debug("handling... "+abpath)
                if "环境信息模板.xlsx" ==file:
                    self.replace_env(abpath)
                elif "http接口信息.xlsx"==file:
                    self.replace_http(abpath)
                elif "http接口用例" in file:
                    self.replace_dict(abpath)
                else:
                    logging.warning("不处理："+abpath)





if __name__=='__main__':
    repl=myreplace()
    repl.Traversal_file()



# str1=r"status=ENUMFILE:D:\\工作\\测试效能平台\\字典\\xss注入.txt"
# if str1.endswith(".txt"):
#     print("000000000000")
# print(str1)
# logging.warning(r'{}'.format(str1))
# # logging.warning(str1)
# reg=re.compile(r'(D:\\工作\\测试效能平台\\字典\\)')

# path=os.getcwd()
# logging.warning(path)
# path=path.replace("\\","\\\\")
# logging.warning(path)
# path=path+("\\\\")
# logging.warning(path)
# ret=re.sub(reg, path ,str1)

# ret='[ { S:b '+str1+' }]'
# logging.warning("-----------")
# logging.warning(ret)
# logging.warning("-----------")


