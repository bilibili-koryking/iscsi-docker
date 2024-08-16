# iscsi-docker
tgt in docker，基于[fujita/tgt](https://github.com/wtnb75/docker-stgt)和[wtnb75/docker-stgt](https://github.com/fujita/tgt)将配置融入到启动脚本，直接通过环境变量即可进行target配置，无需执行脚本
```
services:
    iscsi-docker:
        container_name: iscsi-docker
        restart: unless-stopped
        network_mode: host
        privileged: true
        volumes:
            - /run/lvm:/run/lvm
            - /lib/modules:/lib/modules
            - /sys/kernel/config:/sys/kernel/config
            - /dev:/dev
        environment:
            - targetname=koryking  ##弄一个自己可以识别的target name
            - lundev1=/dev/sda3
         ## - lundev2=/dev/sda4 ##还想加挂载盘就继续增加lundev后的数字，如lundev3,lundev4
            - ip_address=192.168.66.0/24 ## 修改成自己的ip网段
        image: koryking/iscsi-docker
```
