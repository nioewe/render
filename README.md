
#      使用Xry+caddy同时部署通过ws传输的vmess vless协议,客户端务必使用TLS连接

* 代理协议：vless 或 vmess 或 Trojan-go
* 地址：平台分配的域名链接
* 端口：443
* 默认UUID：
* 加密：none
* 传输协议：ws
* 伪装类型：none
* 路径：/api-vless // 默认vless使用/api-vless，vmess使用/api-vmess，Trojan使用/api-Trojan
* 底层传输安全：tls
