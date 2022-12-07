# 4 服务器环境配置

> 本节整理：王琨

拿到账号后，在运行自己的脚本前最重要的是安装软件和配置环境。推荐大家使用conda来管理自己的环境，支持Python, R, julia等多种语言，且安装、使用非常方便。
## 1. 安装conda
这里推荐安装Miniconda，因为Anaconda自带的包太多，没什么用装起来很慢。
https://docs.conda.io/en/latest/miniconda.html

安装步骤：
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
sh Miniconda3-latest-Linux-x86_64.sh
然后根据文字提示操作
安装好后注意配置一下环境


## 2. conda常用命令
conda create -n xx 创建名为xx的环境
conda create -n xx python=a.b 创建名为xx的环境，且指定python版本为a.b
conda info -e 查看所有环境的名称
conda activate xx 进入名为xx的环境
conda deactivate 退出当前环境
conda install xx 安装名为xx的包
conda install r-xx 安装名为xx的R包

## 3. 利用conda配置python环境
conda自带最新版本的python，如果没有特殊需求可以直接使用。

### 3.1 配置torch环境
首先用conda新建一个pytorch的环境，方便版本管理。根据文档建议(https://pytorch.org/get-started/locally/#linux-python)，我们选择python3.8
conda create -n pytorch12 python=3.8
创建好后进入pytorch环境
conda activate pytorch12
安装pytorch
conda install pytorch torchvision torchaudio cudatoolkit=10.2 -c pytorch
注：pytorch版本和cuda版本自行调整，如果不用gpu可以选cpu版本的torch安装。
安装测试一下是否可以使用，进入python后
import torch
print(torch.cuda.is_available())
如果显示True表示一切正常。

### 3.2 gpu的使用
首先查看gpu的使用率
nvidia-smi
用torch.cuda.set_device(x)把gpu切换成使用率较低的，不要扎堆用0。

### 3.3 tensorboard的使用
在vscode中按ctrl+shift+P
输入python:launch tensorboard就可以打开使用了

## 4. 配置R环境
conda create -n Rxy r-base=x.y 创建名为Rxy的环境，并为其安装版本为x.y的r kernel
这时，进入Rxy环境后再输入命令"R“就是用的刚刚安装的R，不是公共的R
conda activate Rxy 进入刚创建的R环境
conda install r-IRkernel 安装交互式R解释器
进入R，然后输入命令：
IRkernel::installspec(name='irxy', displayname='Rx.y')
启动IRkernel，然后就会在jupyter显示名为Rx.y的kernel

tips: R自带的包管理器不好使，可以用conda install r-xx来安装r包

## 5. 如何使用jupyter实现交互式coding
切换到base环境，然后安装jupyter：
conda install jupyterlab
安装nb_conda_kernels，可以在base环境的jupyter里通过切换kernel切换不同环境：
conda install nb_conda_kernels

修改jupyter配置：
jupyter lab --generate-config 生成配置文件

修改配置文件：
vim ~/.jupyter/jupyter_lab_config.py

在最上面输入下列代码：
c.NotebookApp.ip='0.0.0.0' #允许访问的IP地址
c.NotebookApp.open_browser = False
c.NotebookApp.port = xx #自行指定一个端口xx, 访问时使用该端口，范围1-65535，尽量大一点防止冲突
c.NotebookApp.allow_remote_access = True
(注：上述配置对jupyter notebook和jupyter lab都是适用的)

配置好后，对于83
输入命令
jupyter lab
然后在自己电脑上打开浏览器，访问59.77.1.83:xx
根据提示设置密码，token在服务器的输出里，设置好密码后关闭jupyter
然后用pbs提交下述脚本

#!/bin/sh -x
#PBS -l nodes=1:ppn=1
#PBS -N jupyterlab
#PBS -l walltime=30000:00:00
cd $PBS_O_WORKDIR
date
hostname
jupyter lab
date

在自己电脑上访问59.77.1.83:xx就可以使用了

对于81：
因为服务器配置问题，需要另辟蹊径
安装vscode然后在扩展里装一个remote-SSH，配置好后就可以直接打开服务器里的notebook并运行。
如需切换不同conda环境只需点右上角，也很方便。
remark: 可能会提示没有ipykernel，根据提示装一下就行了

- 81的设置可以参考黎青山提供的[vscode连接远程服务器并实现本地编写jupyter_notebook](https://maiimg.com/dec/d94047648506@pdf)

## 6. 配置tex、Julia等其他环境
TBD