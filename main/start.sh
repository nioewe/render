PORT=8080
UUID=5aaed9b7-7fe3-47c3-bb52-db59859ce198

tar -xzvf page.tar.gz

chmod +x ./caddy
./caddy start

echo '
 {
    "log": {"loglevel": "warning"},
    "inbounds": [
        {
            "port": 4000,
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "id": "$UUID"
                    }
                ],
                "decryption": "none",
                "fallbacks": [
                    {
                        "path": "$UUID_vless",
                        "dest": 4001
                    },{
                        "path": "$UUID_trojan",
                        "dest": 4002
                    },{
                        "path": "$UUID_vmess",
                        "dest": 4003
                    }
                ]
            },
            "streamSettings": {
                "network": "tcp"
            }
        },{
            "port": 4001,
            "listen": "127.0.0.1",
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "id": "'$UUID'"
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "ws",
                "security": "none",
                "wsSettings": {
                    "path": "$UUID_vless"
                }
            }
        },{
            "port": 4002,
            "listen": "127.0.0.1",
            "protocol": "trojan",
            "settings": {
                "clients": [
                    {
                        "password": "'$UUID'"
                    }
                ]
            },
            "streamSettings": {
                "network": "ws",
                "security": "none",
                "wsSettings": {
                    "path": "$UUID_trojan"
                }
            }
        },{
            "port": 4003,
            "listen": "127.0.0.1",
            "protocol": "vmess",
            "settings": {
                "clients": [
                    {
                        "id": "'$UUID'"
                    }
                ]
            },
            "streamSettings": {
                "network": "ws",
                "security": "none",
                "wsSettings": {
                    "path": "$UUID_vmess"
                }
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom"
        }
    ]
}
' > conf.json
chmod +x ./web
./web -config=conf.json