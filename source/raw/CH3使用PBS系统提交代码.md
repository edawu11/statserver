# 3 PBS程序提交系统
终于来到了提交程序的环节！本节介绍的**PBS程序提交系统**，是许多同学调用CPU跑程序的一个排队系统（同学们的程序任务相当于顾客，服务器的核相当于服务员，程序所运行的时间相当于服务时间）。**提交PBS系统的好处是，同学们提交完程序并确保程序已经开始运行的情况下，可以退出服务器终端去完成其它事情（包括关闭个人电脑），此时程序会继续跑，直至程序完成或达到所设的最长时限。**

## 3.1 PBS系统基本命令
在使用PBS系统时，会涉及一些常用的命令，包含**查看、提交、删除**等功能。

| **命令** | **功能** |
| --- | --- |
| `qstat` | 查看PBS系统正在运行以及排队的任务 |
| `qstat -r` | 查看PBS系统正在运行以及排队的任务使用的节点数和核数 |
| `pbsnodes -a` | 查看PBS系统是否空闲 |
| `qsub 脚本文件` | 提交任务 |
| `qdel 任务序号` | 删除单个任务 |
| `qdel {始序号..末序号}`  | 删除批量任务 |

## 3.2 调用CPU运行编程程序
在提交程序之前，首先使用`pbsnodes -a`查看服务器**是否有空闲的核**，如显示**state=free**，则可以提交程序，否则，先不提交程序，防止PBS系统崩溃。

**示例**

![image.png](https://cdn.nlark.com/yuque/0/2022/png/12762052/1661674881492-bd00ebbb-431e-41de-9f5d-106f685dd45b.png#averageHue=%23312725&clientId=u76a6eea3-44cc-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=83&id=u0996bc0e&margin=%5Bobject%20Object%5D&name=image.png&originHeight=125&originWidth=428&originalType=binary&ratio=1&rotation=0&showTitle=false&size=8068&status=done&style=none&taskId=u5d9a759b-121a-49d6-8b99-219052e65f9&title=&width=285.3333333333333)

在下面的小节中，我们会介绍**R语言、Matlab以及Python**三种类型代码的提交，同学们可以根据需求直接看相应的小节。
### 3.2.1 R语言（附示例）
#### （一）版本说明
R语言版本：4.1.3（2022-03-10）
> **提醒**如果同学们发现该R语言版本满足不了自己的需求，可以自行在自己的账户下安装合适的R语言版本。

#### （二）R包的安装

1. 键入`R`回车后进入R语言环境；
2. 使用`install.packages()`命令安装R包，回车后稍等片刻会弹出镜像选择窗口，选择后确认即可；
> 提醒如果出现** grab failed: window not viewable** 的报错，意思是镜像选择窗口抓取失败，可以在R环境下输入`chooseCRANmirror(graphics=FALSE)` ，此后再执行`install.packages()`就不会出现窗口，而是通过输入镜像对应的序号选择特定的镜像地址。

3. 安装后的R包会存在自己用户的一个子目录下，使用`library()`查看是否报错，若无，R包安装完成；
4. 输入`q()`或者`CTRL+C`退出R界面。
#### （三）单核任务提交方法：PBS脚本

1. 将要运行的R代码拖入到服务器目录中；
2. 进入R代码所在目录，使用文本编辑器Vim/VI编写任务脚本；
3. 使用`qsub`命令提交任务。

**示例**

1. 准备好要运行的R脚本（**test1.R**），该代码的功能是生成1000个标准正态分布的随机数并计算样本均值，最后将均值保存为.R文件。
```r
set.seed(202209) # 设定随机种子，保证模拟可以复现，非常重要！
a = rnorm(1000,0,1)
a_mean = mean(a)
setwd("/project1/wuyida/R/test") # 设置文件要保存的路径
save(a_mean,file="a_mean.R")
```

2. 将**test1.R**拖入到服务器的目录中，如/project1/wuyida/R/test/。

![image.png](https://cdn.nlark.com/yuque/0/2022/png/12762052/1661678197761-44086b0e-722b-4bb0-9af4-df23992e1cfd.png#averageHue=%23fbf5f3&clientId=u76a6eea3-44cc-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=314&id=uf13f8c16&margin=%5Bobject%20Object%5D&name=image.png&originHeight=471&originWidth=567&originalType=binary&ratio=1&rotation=0&showTitle=false&size=22976&status=done&style=stroke&taskId=u76cfb338-748d-4036-afc2-590ed11876e&title=&width=378)

3. 使用命令行`cd /project1/wuyida/R/test/`进入该目录，使用**文本编辑器**`vim test`**（见2.3节）**编写任务脚本**test**，**test**的内容如下所示。**同学们可以直接将下面的脚本复制后使用鼠标右键（ctrl+v不行）将其直接粘贴到test的文本编辑界面，再保存退出。**
```
#!/bin/sh
#PBS -l nodes=1:ppn=1          
#PBS -l walltime=30000:00:00       
#PBS -o routput                   
#PBS -e rerror
#PBS -m abe
#PBS -M example@xxx.xx 
cd $PBS_O_WORKDIR
/usr/local/bin/R < test1.R --save
```
**注释**
第一行：指此脚本使用/bin/sh来解释执行
第二行：设置程序所需要的资源，nodes代表节点数，ppn代表核数，这里两者均设为1
第三行：设置程序最长运行时间
第四行：设置程序的输出结果文件名称（与脚本文件在同一个目录下）
第五行：设置程序的错误提示的文件名称（与脚本文件在同一个目录下），用户可以在这个文件内查看任务的报错信息
第六、七行：设置任务完成自动发送邮箱提醒功能，同学们可以根据自身需要选择这两行是否保留
第八行：进入执行命令的工作目录
第九行：/usr/local/bin/R是R语言所在的路径（Linux中可以使用`which R`查看），test1.R是待执行的R代码

4. 使用`qsub test`命令提交程序，使用`qstat`查看任务进程。

![image.png](https://cdn.nlark.com/yuque/0/2022/png/12762052/1661679095216-aca5de1b-ab10-4e12-9813-77bd66321f7f.png#averageHue=%232f2d2b&clientId=u76a6eea3-44cc-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=35&id=u91deebec&margin=%5Bobject%20Object%5D&name=image.png&originHeight=53&originWidth=392&originalType=binary&ratio=1&rotation=0&showTitle=false&size=4335&status=done&style=none&taskId=u5ad7c0f4-6f3a-4c13-91b0-56514fb70ce&title=&width=261.3333333333333)

**注释**34596是任务序号，statml是1号服务器的主机名。

![image.png](https://cdn.nlark.com/yuque/0/2022/png/12762052/1661679539932-ab1d2a6e-4c6a-40bb-8aba-cfe3211f29a6.png#averageHue=%23252423&clientId=u76a6eea3-44cc-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=49&id=u6ce4ece1&margin=%5Bobject%20Object%5D&name=image.png&originHeight=73&originWidth=927&originalType=binary&ratio=1&rotation=0&showTitle=false&size=5610&status=done&style=none&taskId=u4467cffb-5bcd-4a3d-9d95-0ca03d89cdd&title=&width=618)
![image.png](https://cdn.nlark.com/yuque/0/2022/png/12762052/1661679176262-c6a81b78-2095-49d2-a341-eb1337f66d49.png#averageHue=%232c2a28&clientId=u76a6eea3-44cc-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=17&id=u46f3f94d&margin=%5Bobject%20Object%5D&name=image.png&originHeight=26&originWidth=931&originalType=binary&ratio=1&rotation=0&showTitle=false&size=3625&status=done&style=none&taskId=u062a879d-cee9-49c9-97d0-53d932c65b2&title=&width=620.6666666666666)

**注释**任务序号34596，任务名test，所有者wuyida，运行时间00:00:00，运行状态C（C表示完成或者终止，R表示正在运行，Q表示排队），1号服务器队列代号是batch。

5. 使用`ls`查看结果文件。

![image.png](https://cdn.nlark.com/yuque/0/2022/png/12762052/1661679345081-fe692a58-f3dd-4625-ad8b-3b729a3bc4cf.png#averageHue=%232c2a29&clientId=u76a6eea3-44cc-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=35&id=u58ed5bff&margin=%5Bobject%20Object%5D&name=image.png&originHeight=53&originWidth=588&originalType=binary&ratio=1&rotation=0&showTitle=false&size=5421&status=done&style=none&taskId=u47ec1e6d-a482-4d6a-9929-fc67ee115f3&title=&width=392)

**注释**可以看到结果文件**routput**和错误文件**rerror**均出现在该目录下，同时也可以看到，**我们的测试代码里面保存的a_mean.R文件也出现在该目录下**。

到此，任务实现完毕O(∩_∩)O

**提醒**如果有多段相同功能的代码需要运行，可以使用编程语言批量生成多组脚本（单核PBS脚本+代码脚本）后一次性提交，下面会提供Perl脚本的示例，同学们也可以使用python、shell等语言实现相同的功能。

#### （四）多核任务提交方法一：Perl脚本
**功能实现：执行K次模拟，各次模拟执行相同的功能，且之间相互独立，互不干扰**

本方法是借助**Perl**批量生成多个模拟任务各自对应的PBS脚本并一次性提交，步骤如下：

1. 在要执行的R代码中加入相应的头文件；
2. 将R代码和Perl脚本拖入到服务器目录中；
3. 使用Perl脚本提交任务；

**示例**

1. 准备好要运行的R脚本（**test2.R**），该代码的功能是抽取K组**（具体多少组实验不用在这里指定，每一组实验都相互独立，也不用在这里指定需要调用多少个核）**10000个标准正态分布的随机数并计算各自的样本均值，最后将这些均值保存为.R文件。【注意：此为示例代码，实际中实现此功能完全不需要用多个核跑】
```r
args=commandArgs(T);
jobB=args[1];
jobE=args[2];
DirPre=args[3];
n = 10000
for(p in jobB:jobE){
  set.seed(p)
  temp = mean(rnorm(n,0,1))
  save(temp,file = paste("mean_",p,".R",sep="")) 
}
```
**注释提醒**

- 前4行内容为perl头文件，需要复制到你要执行的R代码的**最上方**
- 循环次数需要更改为** jobB:jobE**，每一次循环就是一次模拟实验

2. 将**test2.R**和**qsub_r.pl**拖入到服务器的目录中，如/project1/wuyida/R/test/。

![image.png](https://cdn.nlark.com/yuque/0/2022/png/12762052/1662821559350-61ac54a3-ed03-46bc-876b-3fcc66708e52.png#averageHue=%23faebe9&clientId=ua8a5475b-6662-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=207&id=kr9fj&margin=%5Bobject%20Object%5D&name=image.png&originHeight=343&originWidth=451&originalType=binary&ratio=1&rotation=0&showTitle=false&size=14978&status=done&style=none&taskId=ufdb32fe7-bc6a-49f1-b25b-be13a2ff527&title=&width=271.66668701171875)

qsub_r.pl文件下载地址

链接：[https://pan.baidu.com/s/1pOUWUFctuB8u0h_xWLe84A](https://pan.baidu.com/s/1pOUWUFctuB8u0h_xWLe84A) 

提取码：lfvu 

3. 进入/project1/wuyida/R/test/，使用perl命令提交代码，**在这里你需要设置调用多少个核以及每个核的运算次数**。
```perl
perl ./qsub_r.pl /project1/wuyida/R/test test_ batch 5 20 /project1/wuyida/R/test Rscript test2.R
```
![image.png](https://cdn.nlark.com/yuque/0/2022/png/12762052/1669985982254-cc0ef657-afcd-44ed-aa46-05cfb662a51e.png#averageHue=%23212120&clientId=u2cda27fb-ff71-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=180&id=uff678386&margin=%5Bobject%20Object%5D&name=image.png&originHeight=270&originWidth=1447&originalType=binary&ratio=1&rotation=0&showTitle=false&size=17533&status=done&style=none&taskId=u8057beda-e441-4fa6-a15a-21f201bea90&title=&width=964.6666666666666)

**注释**
- `perl ./qsub_Wrapper_0to9.pl` 调用perl执行qsub_Wrapper_0to9.pl文件，`./`是执行的意思。
- `/project1/wuyida/R/test test_ batch 5 20` `/project1/wuyida/R/test`是任务文件的输出路径（.job/.err/.out），以及你的代码保存文件的默认输出路径（建议在R代码里设好保存路径）；`batch`指队列代号；`5`指调用5个核，`20`指每个核计算20次，所以这里相当于调用5个核执行100次循环，对应于for循环的1-100。如果想要改变循环的起点和终点，可以在 R 代码的for循环部分添加一个常数。
- `/project1/wuyida/R/test` 作业运行的工作目录，一般和前面的工作目录保持一致即可。
-  `Rscript test2.R` 调用Rscript运行test2.R文件。

4. 使用`qstat`查看任务运行情况

![image.png](https://cdn.nlark.com/yuque/0/2022/png/12762052/1661679539932-ab1d2a6e-4c6a-40bb-8aba-cfe3211f29a6.png#averageHue=%23252423&clientId=u76a6eea3-44cc-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=49&id=MDZBe&margin=%5Bobject%20Object%5D&name=image.png&originHeight=73&originWidth=927&originalType=binary&ratio=1&rotation=0&showTitle=false&size=5610&status=done&style=none&taskId=u4467cffb-5bcd-4a3d-9d95-0ca03d89cdd&title=&width=618)
![image.png](https://cdn.nlark.com/yuque/0/2022/png/12762052/1669985997808-e587d78d-ba26-4473-aba8-4e2b50666950.png#averageHue=%232e2c2a&clientId=u2cda27fb-ff71-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=81&id=ucb7b34bc&margin=%5Bobject%20Object%5D&name=image.png&originHeight=121&originWidth=930&originalType=binary&ratio=1&rotation=0&showTitle=false&size=17041&status=done&style=none&taskId=u56acbc91-8583-44ef-be89-a3c87527802&title=&width=620)

**注释**一个核的运行对应一个任务，42668-42672是这五个任务对应的编号。运行时间00:00:00，（C表示完成或者终止，R表示正在运行，Q表示排队），服务器队列代号是batch。

5. 可以看到5个任务（共100次模拟）对应的结果文件（100个均值）都在/project1/wuyida/R/test/中。

![image.png](https://cdn.nlark.com/yuque/0/2022/png/12762052/1662821716221-7caa1b85-e181-43e5-849e-47346a0710ea.png#averageHue=%2334312e&clientId=ua8a5475b-6662-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=149&id=jXmrB&margin=%5Bobject%20Object%5D&name=image.png&originHeight=223&originWidth=2023&originalType=binary&ratio=1&rotation=0&showTitle=false&size=44091&status=done&style=none&taskId=u0692e78d-b868-473d-93d6-36965c2681f&title=&width=1348.6666666666667)

到此，任务实现完毕O(∩_∩)O
#### （五）多核任务提交方法二：结合R并行计算代码
**功能实现：待执行任务的某步骤可以分解成K个独立个体单独计算再合并，充分利用计算资源。（在有些情况下与方法一等同）**

1. 将要运行的R代码**（有使用并行计算代码的）**拖入到服务器目录中；
2. 进入R代码所在目录，使用文本编辑器Vim/VI编写任务脚本；
3. 使用`qsub`命令提交任务。
> 提醒多核任务提交与单核任务提交的步骤一样，不同的是R代码需要加入并行代码 以及 任务脚本需要指定使用多少个核。

**示例**

1. 准备好要运行的R脚本（**test1.R**），该代码的功能是调用5个核抽100组10000个标准正态分布的随机数并计算各自的样本均值，最后将100个均值保存为.R文件。**【注意：此为示例代码，实际中实现此功能完全不需要并行，简单运算使用并行计算是画蛇添足】**
```r
set.seed(202209) # 设定随机种子，保证模拟可以复现，非常重要！
library(snowfall) # 调用实现并行的包
K = 100 # 实验次数
sfInit(parallel = TRUE, cpus = 5) # 设置使用的CPU核数，必须能整除K
single_fun = function(index,n){
  temp = rnorm(n,0,1)
  return(mean(temp))
  }
allmean = sfSapply(1:K,single_fun,n=10000) # 调用5个核计算K个实验，在这个例子中，每个核执行20个实验
sfStop() # 停止并行
setwd("/project1/wuyida/R/test") # 设置文件要保存的路径
save(allmean,file="allmean.R")
```
> **提醒**上述代码中并行代码调用的是snowfall包，这部分是可以替换的。R语言中实现并行计算的包，如parallel、snowfall等（[HighPerformanceComputing](https://cran.r-project.org/web/views/HighPerformanceComputing.html)），不同的包有各自的有优缺点。具体如何使用同学们可以上网查找如何使用。


2. 将**test1.R**拖入到服务器的目录中，如/project1/wuyida/R/test/。

![image.png](https://cdn.nlark.com/yuque/0/2022/png/12762052/1662190175848-51b9d893-7d30-431c-a9bd-53612461abb4.png#averageHue=%23faf1ef&clientId=u108e5d6b-b4cd-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=178&id=u728b4324&margin=%5Bobject%20Object%5D&name=image.png&originHeight=267&originWidth=819&originalType=binary&ratio=1&rotation=0&showTitle=false&size=14984&status=done&style=stroke&taskId=ub1c47a68-5e13-4e5b-909a-2ede3813441&title=&width=546)

3. 使用命令行`cd /project1/wuyida/R/test/`进入该目录，使用**文本编辑器**`vim test`**（见2.3节）**编写任务脚本**test**，**test**的内容如下所示。**同学们可以直接将下面的脚本复制后使用鼠标右键（ctrl+v不行）将其直接粘贴到test的文本编辑界面，再保存退出。**
4. **粘贴到test的文本编辑界面，再保存退出。**
```
#!/bin/sh
#PBS -l nodes=1:ppn=5         
#PBS -l walltime=30000:00:00       
#PBS -o routput                   
#PBS -e rerror
#PBS -m abe
#PBS -M example@xxx.xx 
cd $PBS_O_WORKDIR
/usr/local/bin/R < test1.R --save
```
**注释**
第一行：指此脚本使用/bin/sh来解释执行
第二行：设置程序所需要的资源，nodes代表节点数，ppn代表核数，这里调用了5个核。
提醒注意1号服务器的nodes默认为1，不需要改动。2号服务器是有两个节点，所以使用时需要指定nodes=stat1-0或nodes=stat2-0或nodes=2
第三行：设置程序最长运行时间
第四行：设置程序的输出结果文件名称（与脚本文件在同一个目录下）
第五行：设置程序的错误提示的文件名称（与脚本文件在同一个目录下），用户可以在这个文件内查看任务的报错信息
第六、七行：设置任务完成自动发送邮箱提醒功能，同学们可以根据自身需要选择这两行是否保留
第八行：进入执行命令的工作目录
第九行：/usr/local/bin/R是R语言所在的路径（Linux中可以使用`which R`查看），test1.R是待执行的R代码

4. 使用`qsub test`命令提交程序，使用`qstat`查看任务进程。

![image.png](https://cdn.nlark.com/yuque/0/2022/png/12762052/1662189951217-b2bce472-606d-482b-addd-d7cc7706d0af.png#averageHue=%23302d2b&clientId=u108e5d6b-b4cd-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=35&id=ucd064757&margin=%5Bobject%20Object%5D&name=image.png&originHeight=53&originWidth=389&originalType=binary&ratio=1&rotation=0&showTitle=false&size=4328&status=done&style=none&taskId=u950dcd5f-b9de-4fec-bef6-eedfaca7044&title=&width=259.3333333333333)

**注释**34905是任务序号，statml是1号服务器的主机名。

![image.png](https://cdn.nlark.com/yuque/0/2022/png/12762052/1661679539932-ab1d2a6e-4c6a-40bb-8aba-cfe3211f29a6.png#averageHue=%23252423&clientId=u76a6eea3-44cc-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=49&id=eBul8&margin=%5Bobject%20Object%5D&name=image.png&originHeight=73&originWidth=927&originalType=binary&ratio=1&rotation=0&showTitle=false&size=5610&status=done&style=none&taskId=u4467cffb-5bcd-4a3d-9d95-0ca03d89cdd&title=&width=618)
![image.png](https://cdn.nlark.com/yuque/0/2022/png/12762052/1662189966536-015cf881-e4d1-4eee-8212-2343a6bb21aa.png#averageHue=%232c2a28&clientId=u108e5d6b-b4cd-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=17&id=u63f5bab9&margin=%5Bobject%20Object%5D&name=image.png&originHeight=26&originWidth=927&originalType=binary&ratio=1&rotation=0&showTitle=false&size=3521&status=done&style=none&taskId=udccc3443-84fb-489b-84cd-8e73c44cc86&title=&width=618)

**注释**任务序号34905，任务名test，所有者wuyida，运行时间00:00:00，（C表示完成或者终止，R表示正在运行，Q表示排队），1号服务器队列代号是batch。

5. 使用`ls`查看结果文件。

![image.png](https://cdn.nlark.com/yuque/0/2022/png/12762052/1662189985570-79af686e-389a-48cc-96f5-0432474312be.png#averageHue=%232d2a29&clientId=u108e5d6b-b4cd-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=35&id=u3ba77eb4&margin=%5Bobject%20Object%5D&name=image.png&originHeight=52&originWidth=706&originalType=binary&ratio=1&rotation=0&showTitle=false&size=5643&status=done&style=none&taskId=u8e41d386-f433-4de7-8581-0df684bc400&title=&width=470.6666666666667)

**注释**可以看到结果文件**routput**和错误文件**rerror**均出现在该目录下，同时也可以看到，**我们的测试代码里面保存的allmean.R文件也出现在该目录下**。
到此，任务实现完毕O(∩_∩)O

### 3.2.2 Matlab（附示例）
#### （一）版本说明及许可证绑定
1号服务器Matlab版本：R2021a

**首次通过服务器进入Matlab需要绑定许可证**，具体步骤如下：

1. 在命令行键入`matlab`，稍等片刻会弹出窗口如下，点击使用Internet自动激活后点击下一步。

![1662800100427.jpg](https://cdn.nlark.com/yuque/0/2022/jpeg/12762052/1662800106082-e0c35a2d-957d-45e5-96dc-6e65365b7138.jpeg#averageHue=%23e2e9ec&clientId=ua8a5475b-6662-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=343&id=u80b70a0f&margin=%5Bobject%20Object%5D&name=1662800100427.jpg&originHeight=695&originWidth=1059&originalType=binary&ratio=1&rotation=0&showTitle=false&size=125357&status=done&style=stroke&taskId=ub0076456-e64d-4b4a-aeb2-6d5161f9d35&title=&width=523)

2. 点击第一个登录到我的账户，输入自己已激活的MathWorks账号密码，并一直点击下一步，直至完成。若账户此前未激活，请点击[这里](http://zhengban.xmu.edu.cn/matlab.html)查看厦门大学学生激活步骤。

![image.png](https://cdn.nlark.com/yuque/0/2022/png/12762052/1662801113978-f8e914ae-b841-41ee-acef-67ba9a7ee02f.png#averageHue=%23c9d9e2&clientId=ua8a5475b-6662-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=326&id=ue493dc51&margin=%5Bobject%20Object%5D&name=image.png&originHeight=625&originWidth=1038&originalType=binary&ratio=1&rotation=0&showTitle=false&size=116888&status=done&style=stroke&taskId=udeb46afe-fb7a-4005-94ba-13bfdeba19a&title=&width=541)

3. 绑定完成后在命令行输入`matlab`，稍等片刻可以看到和自己个人电脑完全一样的界面。

![image.png](https://cdn.nlark.com/yuque/0/2022/png/12762052/1662801272733-ffeaefe6-c3ce-4f31-9c11-adeb1b440820.png#averageHue=%230b74ae&clientId=ua8a5475b-6662-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=283&id=u70821b6f&margin=%5Bobject%20Object%5D&name=image.png&originHeight=653&originWidth=682&originalType=binary&ratio=1&rotation=0&showTitle=false&size=222098&status=done&style=stroke&taskId=u9b459abf-5629-4cc3-8234-702dcadc4a2&title=&width=295.66668701171875)
![image.png](https://cdn.nlark.com/yuque/0/2022/png/12762052/1662801295550-630bfc2c-119f-4838-9b00-98b3f839ad03.png#averageHue=%23f9f9f9&clientId=ua8a5475b-6662-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=303&id=u9a1edd63&margin=%5Bobject%20Object%5D&name=image.png&originHeight=1200&originWidth=2175&originalType=binary&ratio=1&rotation=0&showTitle=false&size=176600&status=done&style=stroke&taskId=u7f08882e-cfc9-449b-bbde-267035b2057&title=&width=549)

4. 点击关闭，下面提交程序时我们无须打开这个界面。
#### （二）单核任务提交方法：PBS脚本

1. 将要运行的Matlab代码拖入到服务器目录中；
2. 进入Matlab代码所在目录，使用文本编辑器Vim/VI编写任务脚本；
3. 使用`qsub`命令提交任务。

**示例**

1. 准备好要运行的Matlab脚本（**test1.m**），该代码的功能是生成1000个标准正态分布的随机数并计算样本均值，最后将均值保存为.m文件。
```matlab
rng(202209); # 设定随机种子，保证模拟可以复现，非常重要！
n = 1000;
x = randn(n,1);
mean_x = mean(x);
result_table1=table(mean_x);
cd /project1/wuyida/matlab/test; # 设置文件要保存的路径
writetable(result_table1, 'test1.csv');
```

2. 将**test1.m**拖入到服务器的目录中，如/project1/wuyida/matlab/test/。

![image.png](https://cdn.nlark.com/yuque/0/2022/png/12762052/1662803903500-54dfba57-b221-473f-b1e2-c545481b19be.png#averageHue=%23fbf6f5&clientId=ua8a5475b-6662-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=360&id=udc61f88b&margin=%5Bobject%20Object%5D&name=image.png&originHeight=540&originWidth=491&originalType=binary&ratio=1&rotation=0&showTitle=false&size=22832&status=done&style=none&taskId=u110ae28b-bf79-4cc1-bc48-aaa04962ad6&title=&width=327.3333333333333)

3. 使用命令行`cd /project1/wuyida/matlab/test/`进入该目录，使用**文本编辑器**`vim test`**（见2.3节）**编写任务脚本**test**，**test**的内容如下所示。**同学们可以直接将下面的脚本复制后使用鼠标右键（ctrl+v不行）将其直接粘贴到test的文本编辑界面，再保存退出。**
```
#!/bin/sh
#PBS -l nodes=1:ppn=1          
#PBS -l walltime=30000:00:00       
#PBS -o routput                   
#PBS -e rerror    
#PBS -m abe
#PBS -M example@xxx.xx 
cd $PBS_O_WORKDIR
/usr/local/bin/matlab < test1.m
```
**注释**
第一行：指此脚本使用/bin/sh来解释执行
第二行：设置程序所需要的资源，nodes代表节点数，ppn代表核数，这里两者均设为1
第三行：设置程序最长运行时间
第四行：设置程序的输出结果文件名称（与脚本文件在同一个目录下）
第五行：设置程序的错误提示的文件名称（与脚本文件在同一个目录下），用户可以在这个文件内查看任务的报错信息
第六、七行：设置任务完成自动发送邮箱提醒功能，同学们可以根据自身需要选择这两行是否保留
第八行：进入执行命令的工作目录
第九行：/usr/local/bin/matlab是Matlab所在的路径（Linux中可以使用`which matlab`查看），test1.m是待执行的Matlab代码

4. 使用`qsub test`命令提交程序，使用`qstat`查看任务进程。

![image.png](https://cdn.nlark.com/yuque/0/2022/png/12762052/1662804024335-50bbea05-8720-4e07-9167-c04d69f1a592.png#averageHue=%23322f2d&clientId=ua8a5475b-6662-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=33&id=u47180a3d&margin=%5Bobject%20Object%5D&name=image.png&originHeight=50&originWidth=402&originalType=binary&ratio=1&rotation=0&showTitle=false&size=4296&status=done&style=none&taskId=u56b7bca5-d6eb-48aa-8139-688b0fbe001&title=&width=268)

**注释**36057是任务序号，statml是服务器的主机名。

![image.png](https://cdn.nlark.com/yuque/0/2022/png/12762052/1661679539932-ab1d2a6e-4c6a-40bb-8aba-cfe3211f29a6.png#averageHue=%23252423&clientId=u76a6eea3-44cc-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=49&id=cWNQ2&margin=%5Bobject%20Object%5D&name=image.png&originHeight=73&originWidth=927&originalType=binary&ratio=1&rotation=0&showTitle=false&size=5610&status=done&style=none&taskId=u4467cffb-5bcd-4a3d-9d95-0ca03d89cdd&title=&width=618)
![image.png](https://cdn.nlark.com/yuque/0/2022/png/12762052/1662804053399-8fd17870-7ff8-4f19-8d86-106151174505.png#averageHue=%232b2928&clientId=ua8a5475b-6662-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=20&id=ub82cb1d1&margin=%5Bobject%20Object%5D&name=image.png&originHeight=30&originWidth=929&originalType=binary&ratio=1&rotation=0&showTitle=false&size=3554&status=done&style=none&taskId=ue9f1bf59-b62b-4a9a-8800-67a3c1b800d&title=&width=619.3333333333334)

**注释**任务序号36057，任务名test，所有者wuyida，运行时间00:00:00，（C表示完成或者终止，R表示正在运行，Q表示排队），1号服务器队列代号是batch。

5. 使用`ls`查看结果文件。

![image.png](https://cdn.nlark.com/yuque/0/2022/png/12762052/1662804075913-60e40beb-0a9d-4c84-b06d-d4a00d7f7727.png#averageHue=%232e2b29&clientId=ua8a5475b-6662-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=37&id=u748e2cc5&margin=%5Bobject%20Object%5D&name=image.png&originHeight=55&originWidth=505&originalType=binary&ratio=1&rotation=0&showTitle=false&size=4460&status=done&style=none&taskId=u03c00108-41c3-4121-8ed8-3b823a085ad&title=&width=336.6666666666667)

**注释**可以看到结果文件**routput**和错误文件**rerror**均出现在该目录下，同时也可以看到，**我们的测试代码里面保存的test1.csv文件也出现在该目录下**。

到此，任务实现完毕O(∩_∩)O

**提醒**如果有多段相同功能的代码需要运行，可以使用编程语言批量生成多组脚本（单核PBS脚本+代码脚本）后一次性提交，同学们可以使用python、shell、perl等语言实现此功能。
#### （三）多核任务提交方法一：结合Matlab并行计算代码
**功能实现：待执行任务的某步骤可以分解成K个独立个体单独计算再合并，充分利用计算资源。（在有些情况下与方法一等同）**

1. 将要运行的matlab代码**（有使用并行计算代码的）**拖入到服务器目录中；
2. 进入matlab代码所在目录，使用文本编辑器Vim/VI编写任务脚本；
3. 使用`qsub`命令提交任务。
> 提醒多核任务提交与单核任务提交的步骤一样，不同的是matlab代码需要加入并行代码 以及 任务脚本需要指定使用多少个核。


**示例**

1. 准备好要运行的R脚本（**test1.m**），该代码的功能是调用5个核抽100组10000个标准正态分布的随机数并计算各自的样本均值，最后将100个均值保存为.csv文件。【注意：此为示例代码，实际中实现此功能完全不需要并行，简单运算使用并行计算是画蛇添足】
```matlab
rng(202209);
p = parpool(5); %开启进程池，指定线程数量为5个
data = zeros(100,1);
parfor i = 1:100 %使用parfor替代for，启用并行。在这个例子中，每个核执行20次运算
n = 10000;
x = randn(n,1);
data(i) = mean(x);
end
delete(p);
result_table1=table(data);
cd /project1/wuyida/matlab/test;
writetable(result_table1, 'test2.csv');
```
> **提醒**上述代码中并行代码使用的是`parfor`框架，除了开启和关闭进程池，其余和for循环使用的语法一样（只需要将`for`替换为`parfor`），注意这里for循环的每一个任务要相互独立，互不影响。


2. 将**test2.m**拖入到服务器的目录中，如/project1/wuyida/matlab/test/。

![image.png](https://cdn.nlark.com/yuque/0/2022/png/12762052/1662821045132-8c0df880-2a57-45f3-9ec1-78fc39cdf496.png#averageHue=%23fbf3f2&clientId=ua8a5475b-6662-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=243&id=u08816dee&margin=%5Bobject%20Object%5D&name=image.png&originHeight=365&originWidth=450&originalType=binary&ratio=1&rotation=0&showTitle=false&size=18524&status=done&style=none&taskId=u2592f9e0-6acd-43b7-9c0b-86451403f86&title=&width=300)

3. 使用命令行`cd /project1/wuyida/matlab/test/`进入该目录，使用**文本编辑器**`vim test`**（见2.3节）**编写任务脚本**test**，**test**的内容如下所示。**同学们可以直接将下面的脚本复制后使用鼠标右键（ctrl+v不行）将其直接粘贴到test的文本编辑界面，再保存退出。**
```
#!/bin/sh
#PBS -l nodes=1:ppn=5           
#PBS -l walltime=30000:00:00       
#PBS -o routput                   
#PBS -e rerror  
#PBS -m abe
#PBS -M example@xxx.xx 
cd $PBS_O_WORKDIR
/usr/local/bin/matlab < test2.m
```
**注释**
第一行：指此脚本使用/bin/sh来解释执行
第二行：设置程序所需要的资源，nodes代表节点数，ppn代表核数，这里调用了5个核。
提醒注意1号服务器的nodes默认为1，不需要改动。2号服务器是有两个节点，所以使用时需要指定nodes=stat1-0或nodes=stat2-0或nodes=2
第三行：设置程序最长运行时间
第四行：设置程序的输出结果文件名称（与脚本文件在同一个目录下）
第五行：设置程序的错误提示的文件名称（与脚本文件在同一个目录下），用户可以在这个文件内查看任务的报错信息
第六、七行：设置任务完成自动发送邮箱提醒功能，同学们可以根据自身需要选择这两行是否保留
第八行：进入执行命令的工作目录
第九行：/usr/local/bin/matlab是Matlab所在的路径（Linux中可以使用`which matlab`查看），test2.m是待执行的Matlab代码

4. 使用`qsub test`命令提交程序，使用`qstat`查看任务进程。

![image.png](https://cdn.nlark.com/yuque/0/2022/png/12762052/1662821263954-6a393513-5880-4463-8492-279be74132db.png#averageHue=%23322f2d&clientId=ua8a5475b-6662-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=32&id=u872ce98e&margin=%5Bobject%20Object%5D&name=image.png&originHeight=48&originWidth=388&originalType=binary&ratio=1&rotation=0&showTitle=false&size=4293&status=done&style=none&taskId=u0834184b-3fbb-42b5-948a-47153268640&title=&width=258.6666666666667)

**注释**36058是任务序号，statml是1号服务器的主机名。

![image.png](https://cdn.nlark.com/yuque/0/2022/png/12762052/1661679539932-ab1d2a6e-4c6a-40bb-8aba-cfe3211f29a6.png#averageHue=%23252423&clientId=u76a6eea3-44cc-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=49&id=VZHvg&margin=%5Bobject%20Object%5D&name=image.png&originHeight=73&originWidth=927&originalType=binary&ratio=1&rotation=0&showTitle=false&size=5610&status=done&style=none&taskId=u4467cffb-5bcd-4a3d-9d95-0ca03d89cdd&title=&width=618)
![image.png](https://cdn.nlark.com/yuque/0/2022/png/12762052/1662821284942-299b2eac-aa94-43cd-9b17-f2920247be83.png#averageHue=%232a2827&clientId=ua8a5475b-6662-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=21&id=u9393d7d7&margin=%5Bobject%20Object%5D&name=image.png&originHeight=31&originWidth=922&originalType=binary&ratio=1&rotation=0&showTitle=false&size=3657&status=done&style=none&taskId=ud8ae7ac8-7564-4f0e-9ef6-51374af1aa9&title=&width=614.6666666666666)

**注释**任务序号36058，任务名test，所有者wuyida，运行时间00:00:00，（C表示完成或者终止，R表示正在运行，Q表示排队），1号服务器队列代号是batch。

5. 使用`ls`查看结果文件。

![image.png](https://cdn.nlark.com/yuque/0/2022/png/12762052/1662821306002-a4b9cc94-c372-41e3-acb8-2655b7ad244c.png#averageHue=%232b2927&clientId=ua8a5475b-6662-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=38&id=u1d2d94ca&margin=%5Bobject%20Object%5D&name=image.png&originHeight=57&originWidth=754&originalType=binary&ratio=1&rotation=0&showTitle=false&size=5075&status=done&style=none&taskId=ude87e4f4-d507-4ca4-ab20-d7d41ee11fb&title=&width=502.6666666666667)

**注释**可以看到结果文件**routput**和错误文件**rerror**均出现在该目录下，同时也可以看到，**我们的测试代码里面保存的test2.csv文件也出现在该目录下**。

到此，任务实现完毕O(∩_∩)O

### 3.2.3 Python（附示例）
#### （一）版本说明
1号服务器Python版本：3.7.0（2018）
> **提醒**如果同学们发现该Python版本满足不了自己的需求，可以自行在自己的账户下安装合适的Python版本。

#### （二）单核任务提交方法：PBS脚本

1. 将要运行的python代码拖入到服务器目录中；
2. 进入python代码所在目录，使用文本编辑器Vim/VI编写任务脚本；
3. 使用`qsub`命令提交任务。

**示例**

1. 准备好要运行的python脚本（**test1.py**），该代码的功能是生成1000个标准正态分布的随机数，最后将所有随机数保存为.csv文件。
```python
import os
import pandas as pd
import numpy as np
import scipy.stats as st
np.random.seed(202209) 
a=st.norm.rvs(size=100)
dataframe = pd.DataFrame({'a':a})
os.chdir("/project1/wuyida/python/test")
dataframe.to_csv("test1.csv", sep=',')
```

2. 将**test1.py**拖入到服务器的目录中，如/project1/wuyida/python/test/。

![image.png](https://cdn.nlark.com/yuque/0/2022/png/12762052/1662906186537-719092c0-5974-4ad5-a372-5e11d7ac9275.png#averageHue=%23fbf1ef&clientId=ubd6fa7d9-cc4e-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=187&id=u4ca27f6b&margin=%5Bobject%20Object%5D&name=image.png&originHeight=280&originWidth=450&originalType=binary&ratio=1&rotation=0&showTitle=false&size=10696&status=done&style=none&taskId=ua4866aa6-ae6e-4af4-99f3-0ab97a43428&title=&width=300)

3. 使用命令行`cd /project1/wuyida/python/test/`进入该目录，使用**文本编辑器**`vim test`**（见2.3节）**编写任务脚本**test**，**test**的内容如下所示。**同学们可以直接将下面的脚本复制后使用鼠标右键（ctrl+v不行）将其直接粘贴到test的文本编辑界面，再保存退出。**
```
#!/bin/sh
#PBS -l nodes=1:ppn=1          
#PBS -l walltime=30000:00:00       
#PBS -o routput                   
#PBS -e rerror
#PBS -m abe
#PBS -M example@xxx.xx 
cd $PBS_O_WORKDIR
/var/lib/anaconda3/bin/python3 < test1.py
```
**注释**
第一行：指此脚本使用/bin/sh来解释执行
第二行：设置程序所需要的资源，nodes代表节点数，ppn代表核数，这里两者均设为1
第三行：设置程序最长运行时间
第四行：设置程序的输出结果文件名称（与脚本文件在同一个目录下）
第五行：设置程序的错误提示的文件名称（与脚本文件在同一个目录下），用户可以在这个文件内查看任务的报错信息
第六、七行：设置任务完成自动发送邮箱提醒功能，同学们可以根据自身需要选择这两行是否保留
第八行：进入执行命令的工作目录
第九行：/var/lib/anaconda3/bin/python3是python3所在的路径（Linux中可以使用`which python3`查看），test1.py是待执行的python代码

4. 使用`qsub test`命令提交程序，使用`qstat`查看任务进程。

![image.png](https://cdn.nlark.com/yuque/0/2022/png/12762052/1662906714137-1fcc15ed-ed4f-4ca7-b8af-9874caf433ae.png#averageHue=%232e2b2a&clientId=ubd6fa7d9-cc4e-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=39&id=uc23731a6&margin=%5Bobject%20Object%5D&name=image.png&originHeight=59&originWidth=380&originalType=binary&ratio=1&rotation=0&showTitle=false&size=3754&status=done&style=none&taskId=ucdcefd82-25c9-4f35-9e80-f311ed43f98&title=&width=253.33333333333334)

**注释**36126是任务序号，statml是服务器的主机名。

![image.png](https://cdn.nlark.com/yuque/0/2022/png/12762052/1661679539932-ab1d2a6e-4c6a-40bb-8aba-cfe3211f29a6.png#averageHue=%23252423&clientId=u76a6eea3-44cc-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=49&id=wH4Ej&margin=%5Bobject%20Object%5D&name=image.png&originHeight=73&originWidth=927&originalType=binary&ratio=1&rotation=0&showTitle=false&size=5610&status=done&style=none&taskId=u4467cffb-5bcd-4a3d-9d95-0ca03d89cdd&title=&width=618)
![image.png](https://cdn.nlark.com/yuque/0/2022/png/12762052/1662906739471-cdf766ce-99d5-4066-9563-53e388f7eb45.png#averageHue=%232c2a28&clientId=ubd6fa7d9-cc4e-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=17&id=ueb945339&margin=%5Bobject%20Object%5D&name=image.png&originHeight=26&originWidth=917&originalType=binary&ratio=1&rotation=0&showTitle=false&size=3081&status=done&style=none&taskId=uf2e4f30a-0468-4af7-a2a5-28905e66a3d&title=&width=611.3333333333334)

**注释**任务序号36126，任务名test，所有者wuyida，运行时间00:00:00，（C表示完成或者终止，R表示正在运行，Q表示排队），1号服务器队列代号是batch。

5. 使用`ls`查看结果文件。

![image.png](https://cdn.nlark.com/yuque/0/2022/png/12762052/1662906759723-74fff729-9d45-448e-b8b2-79fc7f5bee42.png#averageHue=%232e2c2a&clientId=ubd6fa7d9-cc4e-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=37&id=u2ac953e3&margin=%5Bobject%20Object%5D&name=image.png&originHeight=56&originWidth=524&originalType=binary&ratio=1&rotation=0&showTitle=false&size=4210&status=done&style=none&taskId=u6bf768e4-fe9e-470e-9c82-c51e508b177&title=&width=349.3333333333333)

**注释**可以看到结果文件**routput**和错误文件**rerror**均出现在该目录下，同时也可以看到，**我们的测试代码里面保存的test1.csv文件也出现在该目录下**。

到此，任务实现完毕O(∩_∩)O

**提醒**如果有多段相同功能的代码需要运行，可以使用编程语言批量生成多组脚本（单核PBS脚本+代码脚本）后一次性提交，同学们可以使用python、shell、perl等语言实现此功能。
