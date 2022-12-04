# 2 Linux系统基本知识
虽然同学们使用服务器的主要目的是提交程序运行，但是因为服务器是基于Linux系统，所以在学习如何使用服务器提交程序之前，我们**首先需要了解Linux系统的基本知识**。本节我们将从**工作目录**、**文件管理**和**文本编辑器**三方面介绍Linux系统最常见的命令，方便同学们使用。
## 2.1 工作目录
在Linux系统中，用户主要以**命令行**进行工作目录（或文件夹）的管理，常见命令主要包括**创建**、**查看**、**切换**和**删除**四个模块。

| **命令** | **功能** |
| --- | --- |
| `mkdir 目录名称` | 创建工作目录 |
| `pwd` | 查看当前所在的工作目录 |
| `cd 绝对路径` | 切换工作目录 |
| `cd ./相对路径` | 切换工作目录 |
| `cd ..` | 返回上级目录 |
| `cd ~`或`cd` | 返回家目录 |
| `rmdir 目录名称` | 删除工作目录 |

## 2.2 文件
### 2.2.1 文件认识
在介绍文件管理的相关命令之前，我们**首先了解文件类型和文件权限及归属**。在Linux系统中，常见的两种文件类型是**普通文件**（用-表示）和**目录文件**（用d表示），它们都规定了文件的所有者、所有组以及其他用户对文件所拥有的**可读（r）、可写（w）、可执行（x）**等权限，具体解释见图。

![image.png](https://cdn.nlark.com/yuque/0/2022/png/12762052/1661670095115-0650d04e-f704-4346-83e8-13b4c364b127.png#averageHue=%23f1f1f1&clientId=uafd17257-a033-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=206&id=u6a631292&margin=%5Bobject%20Object%5D&name=image.png&originHeight=371&originWidth=816&originalType=binary&ratio=1&rotation=0&showTitle=true&size=77071&status=done&style=stroke&taskId=ud08369e2-2cc0-47e8-ac0b-fc163c4eb10&title=%E6%99%AE%E9%80%9A%E6%96%87%E4%BB%B6%E5%92%8C%E7%9B%AE%E5%BD%95%E6%96%87%E4%BB%B6%E6%9D%83%E9%99%90%E8%A7%A3%E9%87%8A&width=454 "普通文件和目录文件权限解释")

文件的读、写、执行权限简写为**r、w、x**，也可以用**数字4、2、1**来表示，注意文件所有者、所属组以及其他用户权限之间是相互独立的，如表所示。

![image.png](https://cdn.nlark.com/yuque/0/2022/png/12762052/1661669457694-d65a0501-13d3-498d-b1dd-047eba1067cf.png#averageHue=%2388795d&clientId=uafd17257-a033-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=127&id=JiuHE&margin=%5Bobject%20Object%5D&name=image.png&originHeight=231&originWidth=1141&originalType=binary&ratio=1&rotation=0&showTitle=true&size=93258&status=done&style=none&taskId=udf67a692-b530-4741-b291-3fb0a2b3050&title=%E6%96%87%E4%BB%B6%E6%9D%83%E9%99%90%E7%9A%84%E5%AD%97%E7%AC%A6%E4%B8%8E%E6%95%B0%E5%AD%97%E8%A1%A8%E7%A4%BA&width=627 "文件权限的字符与数字表示")
注：如果数字为7，则代表可读、可写、可执行（4+2+1），若数字为6则代表可读、可写（4+2），等等。一个文件的权限为777，则代表这个文件对于文件所有者、文件所属组和其它用户均具备可读、可写、可执行的权限。

在Linux系统中，当我们使用`ls -l`命令查看文件信息时，便可以看到上述介绍的文件类型和文件权限。

![image.png](https://cdn.nlark.com/yuque/0/2022/png/12762052/1661671216848-a8c2fd0a-b687-4f11-acb0-3b7a61c5c091.png#averageHue=%23dddeae&clientId=uafd17257-a033-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=103&id=u5260f65a&margin=%5Bobject%20Object%5D&name=image.png&originHeight=154&originWidth=830&originalType=binary&ratio=1&rotation=0&showTitle=false&size=54610&status=done&style=none&taskId=ucb7cbbb1-a7ed-4171-9e90-680165213f5&title=&width=553.3333333333334)
### 2.2.2 文件管理命令（附示例）
对于文件的管理，Linux系统也有一系列的命令，常见命令主要包括**查看**、**删除**、**修改权限**等。

| **命令** | **功能** |
| --- | --- |
| `ls` | 显示当前目录的所有文件和子目录 |
| `ls -l` | 显示当前目录的所有文件和子目录的详细信息（包括使用权限、创建日期、大小等） |
| `ls *.R`  | 查看当前目录中文件名以.R结尾的文件 |
| `rm 文件名` | 删除当前目录下的某个文件 |
| `rm *.R`  | 删除当前目录中文件名.R结尾的文件 |
| `cat 文件名` | 查看当前目录下某个文件的文本内容 |
| `chmod 数字组合 文件名` | 修改文件或目录的权限 |

示例

1. 首先进入**test**工作目录，使用`ls -l`命令输出该目录下的所有文件和子目录的信息。

![image.png](https://cdn.nlark.com/yuque/0/2022/png/12762052/1661670846952-6c0665ca-a355-4c28-81ca-8e90a9596f66.png#averageHue=%232b2927&clientId=uafd17257-a033-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=81&id=u42fdecae&margin=%5Bobject%20Object%5D&name=image.png&originHeight=122&originWidth=654&originalType=binary&ratio=1&rotation=0&showTitle=false&size=14215&status=done&style=none&taskId=u1d7027b0-e584-4cd9-8af6-efaf244b363&title=&width=436)

2. 对**test1.R**文件增加所有者可执行（可执行对应数字1，所以第一个数字改为7即可）的权限。

![image.png](https://cdn.nlark.com/yuque/0/2022/png/12762052/1661671341890-de524096-cf11-4ae4-b7f8-5d52fbc4d08f.png#averageHue=%232c2a28&clientId=uafd17257-a033-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=83&id=u9055cf98&margin=%5Bobject%20Object%5D&name=image.png&originHeight=125&originWidth=637&originalType=binary&ratio=1&rotation=0&showTitle=false&size=15339&status=done&style=none&taskId=u90725520-875b-4f3e-b97a-de88925e216&title=&width=424.6666666666667)

3. 对**test1.R**文件开放所有权限。

![image.png](https://cdn.nlark.com/yuque/0/2022/png/12762052/1661671392019-477f382c-5f1a-4880-8bdb-42c833314e52.png#averageHue=%232c2a28&clientId=uafd17257-a033-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=84&id=ud410549a&margin=%5Bobject%20Object%5D&name=image.png&originHeight=126&originWidth=638&originalType=binary&ratio=1&rotation=0&showTitle=false&size=15176&status=done&style=none&taskId=uebd1918c-1e73-4bd8-84ff-4f1a7903399&title=&width=425.3333333333333)

4. 删除**test1.R**文件。

![image.png](https://cdn.nlark.com/yuque/0/2022/png/12762052/1661671413051-92736436-4802-4933-8a8a-b99b2e32496c.png#averageHue=%232a2827&clientId=uafd17257-a033-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=68&id=ufe2cc226&margin=%5Bobject%20Object%5D&name=image.png&originHeight=102&originWidth=618&originalType=binary&ratio=1&rotation=0&showTitle=false&size=10817&status=done&style=none&taskId=u97c6b29f-34be-46d4-b6c8-cf450b21829&title=&width=412)
## 2.3 文本编辑器
类似于Windows系统的记事本，Linux也有自己的文本编辑器。
> 提醒对于Windowx记事本创建的文本文件，不可以将其拖到linux系统中直接使用（编码格式不一样）。


在Linux系统中，常用的文本编辑器是**Vim（Vi的升级版）/Vi编辑器**，它设置了三种模式——**命令模式**、**编辑模式**和**末行模式**，这三种模式通过对应的按键（如图）进行相互切换。

- **命令模式**：控制光标移动，可对文本进行复制、粘贴、删除和查找等工作，但无法插入新内容
- **编辑模式**：可以进行正常的文本插入
- **末行模式**：保存或退出文档，以及设置编辑环境

![image.png](https://cdn.nlark.com/yuque/0/2022/png/12762052/1661671672162-596c479e-90f9-4440-9e59-3db797de89f1.png#averageHue=%23d3e6f4&clientId=uafd17257-a033-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=226&id=u63750b6c&margin=%5Bobject%20Object%5D&name=image.png&originHeight=388&originWidth=939&originalType=binary&ratio=1&rotation=0&showTitle=true&size=91272&status=done&style=none&taskId=uf6e33be5-2ffb-49f0-a73d-1f9890c8378&title=%E4%B8%89%E7%A7%8D%E6%A8%A1%E5%BC%8F%E7%9A%84%E5%88%87%E6%8D%A2&width=546 "三种模式的切换")

**操作：**在每次运行Vim编辑器时，默认进入命令模式。此时需要按`i`或`a`等切换到输入模式，此时可以进行正常的文本编写工作，编写完成后按`ESC`重新返回命令模式，最后按`:`进入末行模式（显示在编辑器的最下面）执行保存`w`或保存退出`wq`操作。

示例

1. 创建一个名为test的文本文件，回车进入编辑器窗口。

![image.png](https://cdn.nlark.com/yuque/0/2022/png/12762052/1661672576060-2ed6a7dd-1b1c-4330-a307-eafe0e34d014.png#averageHue=%232b2928&clientId=u76a6eea3-44cc-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=19&id=u15ea8d55&margin=%5Bobject%20Object%5D&name=image.png&originHeight=28&originWidth=623&originalType=binary&ratio=1&rotation=0&showTitle=false&size=2882&status=done&style=none&taskId=ub26e90de-20f1-41c5-bbd0-5aca1bab28c&title=&width=415.3333333333333)

2. 按`i`或`a`等切换到输入模式（此时最下面会显示--插入--），输入文本“I love statistics!“。

![image.png](https://cdn.nlark.com/yuque/0/2022/png/12762052/1661672682672-57fe7826-72cd-4596-a7a1-e941ca49c336.png#averageHue=%231e1e1e&clientId=u76a6eea3-44cc-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=379&id=u6ee59d69&margin=%5Bobject%20Object%5D&name=image.png&originHeight=845&originWidth=1324&originalType=binary&ratio=1&rotation=0&showTitle=false&size=17369&status=done&style=none&taskId=u338dff4a-f3db-4a86-a0df-bf7526c8edd&title=&width=594)

3. 输入完成后按`ESC`重新返回命令模式，此时最下面的--插入--字样消失。

![image.png](https://cdn.nlark.com/yuque/0/2022/png/12762052/1661672741260-30f0f5b3-9110-43a2-88b8-03d0f4def7b1.png#averageHue=%231e1e1e&clientId=u76a6eea3-44cc-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=381&id=u6f6baf7b&margin=%5Bobject%20Object%5D&name=image.png&originHeight=842&originWidth=1321&originalType=binary&ratio=1&rotation=0&showTitle=false&size=16164&status=done&style=none&taskId=ua12b2edb-e0f9-4829-9d96-6c0f778ac39&title=&width=597)

4. 按`:`进入末行模式（显示在编辑器的最下面），并输入`wq`，回车，执行保存退出。

![image.png](https://cdn.nlark.com/yuque/0/2022/png/12762052/1661672820789-78e4f81a-76a0-4e5a-87e1-16478e47d298.png#averageHue=%231e1e1e&clientId=u76a6eea3-44cc-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=385&id=u160a1747&margin=%5Bobject%20Object%5D&name=image.png&originHeight=846&originWidth=1315&originalType=binary&ratio=1&rotation=0&showTitle=false&size=15175&status=done&style=none&taskId=u2e7d7cce-fade-4d38-a260-8b4ac790a0d&title=&width=598)

5. 可以使用`cat`命令查看文本文件的内容。

![image.png](https://cdn.nlark.com/yuque/0/2022/png/12762052/1661672901592-e88026ea-8ef4-49d3-8120-6282c57f3dc9.png#averageHue=%23292726&clientId=u76a6eea3-44cc-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=41&id=u966cd333&margin=%5Bobject%20Object%5D&name=image.png&originHeight=51&originWidth=614&originalType=binary&ratio=1&rotation=0&showTitle=false&size=4482&status=done&style=none&taskId=u91888ac8-96e4-4ced-9b53-116d25ace0d&title=&width=493.3333435058594)
