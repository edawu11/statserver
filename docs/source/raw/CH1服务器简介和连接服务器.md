# 1 服务器简介和连接服务器
## 1.1 服务器配置
### 1.1.1 1号服务器
【地址】59.77.1.81

【线程】支持超线程技术，逻辑CPU个数4*26*2=208个

【GPU】3 * Nvidia 2080Ti

【硬盘】非系统盘共6.5T

【内存】1T，不包括交换扇区
### 1.1.2 2号服务器（集群）
【地址】59.77.1.83

【线程】支持超线程技术，逻辑CPU个数152*2=304个

【硬盘】非系统盘共3.9T

【内存】750G+750G，不包括交换扇区
## 1.2 网络设置
### 1.2.1 厦大内网

- 当连接无线网络**XMUNET+**（教室、实验楼、食堂）或**MATH**（自习室、办公室）时，可以直接连接服务器。
- **XMUNET+**的密码可在[WIFI密码修改重置](http://pass.xmu.edu.cn/)设置。
- **MATH**的密码请询问服务器管理员。
### 1.2.2 非厦大内网（需连接VPN）

- 当所使用的网络不是厦大内网时（如在宿舍、假期在家），同学们需要连接VPN才能连接服务器，VPN使用见参考[VPN仅支持厦门大学企业微信APP扫码登录的通知](https://open.work.weixin.qq.com/wwopen/mpnews?mixuin=zdCnDQAABwB7HS1PAAAUAA&mfid=WW0305-MbyB5QAABwCBWYpWLBj5NAwUdgs65&idx=0&sn=60fa72b001663906c6da6a7a59e3b335)。
## 1.3 进入服务器终端
### 1.3.1 通过软件进入——MobaXterm（Win端）

1. 在个人电脑上安装**MobaXterm**（[下载地址](https://mobaxterm.mobatek.net/download.html)）

![image.png](https://cdn.nlark.com/yuque/0/2022/png/12762052/1662197058837-5df9a7b6-028b-4334-8682-a8616d386fa4.png#averageHue=%23483733&clientId=u108e5d6b-b4cd-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=39&id=udd130d1f&margin=%5Bobject%20Object%5D&name=image.png&originHeight=59&originWidth=56&originalType=binary&ratio=1&rotation=0&showTitle=false&size=3798&status=done&style=none&taskId=ud4a9204a-3640-44b7-83c1-eed0914975c&title=&width=37.333333333333336)

![image.png](1.1.png)

2. 点击左上角**Session**后，在弹出的窗口中点击第一个**SSH**

![image.png](https://cdn.nlark.com/yuque/0/2022/png/12762052/1662196944240-b3cdeb61-0419-4e00-a783-874617781e4c.png#averageHue=%23faf4f2&clientId=u108e5d6b-b4cd-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=75&id=u35935960&margin=%5Bobject%20Object%5D&name=image.png&originHeight=116&originWidth=973&originalType=binary&ratio=1&rotation=0&showTitle=false&size=18054&status=done&style=stroke&taskId=u41035d91-f476-4a49-bfc1-1914d5a7588&title=&width=631.6666870117188)

![image.png](https://cdn.nlark.com/yuque/0/2022/png/12762052/1662197031511-0d268929-5017-4091-9a3d-b8c8f2c6f60e.png#averageHue=%23faf9f8&clientId=u108e5d6b-b4cd-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=420&id=u6f6c298e&margin=%5Bobject%20Object%5D&name=image.png&originHeight=844&originWidth=1276&originalType=binary&ratio=1&rotation=0&showTitle=false&size=49968&status=done&style=stroke&taskId=u791de35f-58f7-4386-992c-73c505b3ac7&title=&width=635)

3. 在窗口中输入**服务器地址（如1号服务器：59.77.1.81）**和**用户名（向服务器管理员申请）**，确认无误后点击OK

![image.png](https://cdn.nlark.com/yuque/0/2022/png/12762052/1662197212338-b8f5ecac-10e7-4249-873b-c3b8f3e5a3e5.png#averageHue=%23faf7f6&clientId=u108e5d6b-b4cd-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=394&id=u80e8dc35&margin=%5Bobject%20Object%5D&name=image.png&originHeight=819&originWidth=1260&originalType=binary&ratio=1&rotation=0&showTitle=false&size=50745&status=done&style=none&taskId=u59a00d49-2470-4bf1-9b3d-7ceaee82cd0&title=&width=606)

4. 进入服务器界面后需要输入密码。**注意，输入密码时是没有任何显示的**，所以一定要小心谨慎地输入。输入后回车即可。（输错三次会锁10分钟）

5. 当看到下面的界面时，说明已经成功连接服务器

![image.png](https://cdn.nlark.com/yuque/0/2022/png/12762052/1662197576764-3bf49e50-8b04-4850-91cf-64c074bcc36a.png#averageHue=%23545150&clientId=u108e5d6b-b4cd-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=329&id=uf50e8f58&margin=%5Bobject%20Object%5D&name=image.png&originHeight=1376&originWidth=2560&originalType=binary&ratio=1&rotation=0&showTitle=false&size=156317&status=done&style=none&taskId=u226ab621-76ae-40f7-ad84-d53c307b73d&title=&width=612)

6. 此后除非修改密码，否则登录时无需再输入密码，**只需在MobaXterm首页点击自己的用户名进入即可**



### 1.3.2 通过软件进入——Termius（Mac端）

1. 在个人电脑上安装**Termius**，Mac用户直接在Apple Store搜索即可![image.png](https://cdn.nlark.com/yuque/0/2022/png/12762052/1669984140783-699a7df0-d7c4-45ee-9486-142ca0b8c94b.png#averageHue=%23777f79&clientId=u2cda27fb-ff71-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=424&id=u7f7f93b8&margin=%5Bobject%20Object%5D&name=image.png&originHeight=1716&originWidth=2676&originalType=binary&ratio=1&rotation=0&showTitle=false&size=2652746&status=done&style=none&taskId=ucbd67708-6172-478c-be16-e06701dfdc4&title=&width=661)
2. 下载后完成设置和创建账户（与服务器账户无关）
3. 在相应窗口输入服务器地址**（如1号服务器：59.77.1.81），点击Create host**

![2e15f348a31979387b35f0218c8a96b.png](https://cdn.nlark.com/yuque/0/2022/png/12762052/1669984174008-ccd47c1c-6dd8-4901-b2c8-bd73f19fce37.png#averageHue=%23ebeff1&clientId=u2cda27fb-ff71-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=799&id=uf9b6c46f&margin=%5Bobject%20Object%5D&name=2e15f348a31979387b35f0218c8a96b.png&originHeight=1198&originWidth=1911&originalType=binary&ratio=1&rotation=0&showTitle=false&size=249408&status=done&style=none&taskId=uf296a12c-85b5-4c64-92e0-2b79a7af0b0&title=&width=1274)

4. 在右侧的信息栏输入**用户名（向服务器管理员申请）和密码**，确认无误后双击中间的地址后进入服务器终端

![image.png](https://cdn.nlark.com/yuque/0/2022/png/12762052/1669984366482-4cf3bd9f-22a0-4a77-9091-b9c9928be77b.png#averageHue=%23d0d4d9&clientId=u2cda27fb-ff71-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=464&id=uf1113b8e&margin=%5Bobject%20Object%5D&name=image.png&originHeight=1186&originWidth=1903&originalType=binary&ratio=1&rotation=0&showTitle=false&size=134153&status=done&style=none&taskId=u6fa501b6-7f96-44ec-a9ef-c14d147e12d&title=&width=745)

5. 若显示以下界面，说明已经成功进入服务器终端

![image.png](https://cdn.nlark.com/yuque/0/2022/png/12762052/1669984486257-62da2a7d-f8ac-4a28-86d6-9c0bf9f99d8c.png#averageHue=%2316192b&clientId=u2cda27fb-ff71-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=777&id=u76efff8f&margin=%5Bobject%20Object%5D&name=image.png&originHeight=1166&originWidth=1908&originalType=binary&ratio=1&rotation=0&showTitle=false&size=48649&status=done&style=none&taskId=ue374dc76-d81d-47f1-a1c3-3a0d219e1be&title=&width=1272)

## 1.4 账号创建

因课题研究需要使用服务器计算资源的同学，请联系服务器管理员创建账号，联系方式是**发送邮件到edawu11@163.com，并注明姓名、专业、年级和导师姓名**，谢谢配合！