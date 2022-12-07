# 4 服务器环境配置

拿到账号后，在运行自己的脚本前最重要的是安装软件和配置环境。推荐大家使用conda来管理自己的环境，支持Python, R, julia等多种语言，且安装、使用非常方便。
## 1. 安装conda
这里推荐安装Miniconda，因为Anaconda自带的包太多，没什么用装起来很慢。
https://docs.conda.io/en/latest/miniconda.html

安装步骤：
```
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
sh Miniconda3-latest-Linux-x86_64.sh
```
然后根据文字提示操作，安装好后注意改一下环境变量。


## 2. conda常用命令
```
conda create -n xx 创建名为xx的环境
conda create -n xx python=a.b 创建名为xx的环境，且指定python版本为a.b
conda info -e 查看所有环境的名称
conda activate xx 进入名为xx的环境
conda deactivate 退出当前环境
conda install xx 安装名为xx的包
conda install r-xx 安装名为xx的R包
```

## 3. 利用conda配置python环境
conda自带最新版本的python，如果没有特殊需求可以直接使用。
如需安装指定版本的python，例如python2.7，可以按照如下步骤安装并激活：
```
conda create -n python27 python=2.7
conda activate python27
```

### 3.1 配置torch环境
首先用conda新建一个pytorch的环境，方便版本管理。根据[文档](https://pytorch.org/get-started/locally/#linux-python)建议，我们选择python3.8
```
conda create -n pytorch12 python=3.8
```
创建好后进入pytorch环境
```
conda activate pytorch12
```
下一步安装pytorch
```
conda install pytorch torchvision torchaudio cudatoolkit=10.2 -c pytorch
```
注：pytorch版本和cuda版本自行调整，如果不用gpu可以选cpu版本的torch安装，详见pytorch网站中的[Get Started](https://pytorch.org/get-started/locally/#linux-python)。
安装测试一下是否可以使用，进入python后
```python
import torch
print(torch.__version__)
print(torch.cuda.is_available())
```
如果第一行能显示版本号表示正常安装；第二行显示True表示cuda可用，即可以使用gpu训练模型，而显示False则表示不能使用gpu，正常情况下应该是True。

### 3.2 gpu的使用
首先查看gpu的使用率
nvidia-smi
用 `torch.cuda.set_device(xx)` 把gpu切换成使用率较低的，不要扎堆用0。

### 3.3 tensorboard的使用
对于83/86服务器，可以直接访问服务器ip:port使用tensorboard；
对于81服务器，可以借助vscode使用：
在vscode中按 `ctrl+shift+P`
输入 `python:launch tensorboard` 就可以打开使用了

## 4. 配置R环境
由于 R 的开发者和使用者多数都在胡写，版本管理和依赖关系一塌糊涂，这里推荐利用 conda 来安装 R 和 R 包。
首先创建一个 conda 环境来安装 R 
```
conda create -n R41 r-base=4.1
```
例如我们安装 R4.1，将 conda 环境命名为R41
这时，进入 R41 环境后再输入命令 `R` 就是用的刚刚安装的 R ，不是公共的 R，

tips0: 如果有 R 包用 `install.packages()` 装不上的情况，可以用 `conda install r-xx` 来安装。
tips1: 如果有需求可以请管理员装一个rstudio-server，大致效果是在本地浏览器打开一个网页就是Rstudio的界面。

## 5. 在pbs中如何指定 conda 环境
只需要在脚本里添加如下两行
```bash
export PATH=$HOME/miniconda3/bin:$PATH
source activate my_environment
```

## 6. 如何使用jupyter实现交互式coding

### 6.1 jupyter 的基本配置
切换到base环境，然后安装jupyter：
```
conda install jupyterlab
```
然后安装nb_conda_kernels，用于在jupyter里切换不同环境：
```
conda install nb_conda_kernels
```

接下来修改jupyter配置，首先生成配置文件
```
jupyter lab --generate-config
```
运行上述命令会在`$HOME/.jupyter/`目录自动创建配置文件`jupyter_lab_config.py`
修改配置文件：
```
vim ~/.jupyter/jupyter_lab_config.py
```
在最上面输入下列代码：
```python
c.NotebookApp.ip='0.0.0.0' #允许访问的IP地址
c.NotebookApp.open_browser = False
c.NotebookApp.port = xx #自行指定一个端口xx, 访问时使用该端口，范围1-65535，尽量大一点防止冲突
c.NotebookApp.allow_remote_access = True
```
(注：上述配置对jupyter notebook和jupyter lab都是适用的)

配置好后，对于83/86服务器，我们可以通过浏览器直接使用jupyter。
在服务器输入命令
```
jupyter lab
```
(注：不是在python里输入，是直接在shell里打)
然后在自己电脑上打开浏览器，访问59.77.1.83:xx (这里的xx是配置文件里设置的端口)
根据提示设置密码，token在服务器的输出里，设置好密码后在服务器用`ctrl+c`两次关闭jupyter
然后用pbs提交下述脚本
```bash
#!/bin/sh -x
#PBS -l nodes=1:ppn=1
#PBS -N jupyterlab
#PBS -l walltime=30000:00:00
cd $PBS_O_WORKDIR
date
hostname
jupyter lab
date
```
在自己电脑上访问59.77.1.83:xx就可以使用了

对于81服务器，因为服务器配置问题，可以借助vscode使用。

安装vscode然后在扩展里装一个remote-SSH，配置好后就可以直接打开服务器里的notebook并运行。如需切换不同conda环境只需点右上角，也很方便。
remark: 可能会提示没有ipykernel，根据提示装一下就行了

- 81的设置可以参考黎青山提供的[vscode连接远程服务器并实现本地编写jupyter_notebook](https://maiimg.com/dec/d94047648506@pdf)


### 6.2 用 jupyter 写 R 代码
首先进入安装好的 R 环境
```
conda activate Rxy 
```
安装交互式R解释器
```
conda install r-IRkernel 
```
进入R，然后输入以下命令启动IRkernel：
```R
IRkernel::installspec(name='irxy', displayname='Rx.y')
```
然后就会在jupyter显示名为Rx.y的kernel，打开就可以写 R 代码了

## 6. 配置tex、Julia等其他环境
TBD

--- 
本节撰写：王琨