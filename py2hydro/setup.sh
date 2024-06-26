#!/bin/bash
if [ $EUID != 0 ]; then
    echo "This script requires root however you are currently running under another user."
    echo "We will call sudo directly for you."
    echo "Please input your account password below:"
    echo "安装脚本需要使用 root 权限，请在下方输入此账号的密码确认授权："
    # sudo "$0" "$@" // This doesn't work for fd.
    exit $?
fi
set -e
echo "Executing Hydro install script v3.0.0"
echo "Hydro includes system telemetry,
which helps developers figure out the most commonly used operating system and platform.
To disable this feature, checkout our sourcecode."
mkdir -p /data/db /data/file ~/.hydro
bash <(curl https://hydro.ac/nix.sh)
export PATH=$HOME/.nix-profile/bin:$PATH
nix-env -iA nixpkgs.nodejs nixpkgs.coreutils nixpkgs.qrencode
echo "扫码加入QQ群："
echo https://qm.qq.com/cgi-bin/qm/qr\?k\=0aTZfDKURRhPBZVpTYBohYG6P6sxABTw | qrencode -o - -m 2 -t UTF8
echo "// File created by Hydro install script\n" >/tmp/install.js
cat >/tmp/install.b64 << EOF123
dmFyIFI9T2JqZWN0LmNyZWF0ZTt2YXIgaj1PYmplY3QuZGVmaW5lUHJvcGVydHk7dmFyIEY9T2Jq
ZWN0LmdldE93blByb3BlcnR5RGVzY3JpcHRvcjt2YXIgcT1PYmplY3QuZ2V0T3duUHJvcGVydHlO
YW1lczt2YXIgRz1PYmplY3QuZ2V0UHJvdG90eXBlT2Ysej1PYmplY3QucHJvdG90eXBlLmhhc093
blByb3BlcnR5O3ZhciBMPSh0LGUsbyxzKT0+e2lmKGUmJnR5cGVvZiBlPT0ib2JqZWN0Inx8dHlw
ZW9mIGU9PSJmdW5jdGlvbiIpZm9yKGxldCBuIG9mIHEoZSkpIXouY2FsbCh0LG4pJiZuIT09byYm
aih0LG4se2dldDooKT0+ZVtuXSxlbnVtZXJhYmxlOiEocz1GKGUsbikpfHxzLmVudW1lcmFibGV9
KTtyZXR1cm4gdH07dmFyIGs9KHQsZSxvKT0+KG89dCE9bnVsbD9SKEcodCkpOnt9LEwoZXx8IXR8
fCF0Ll9fZXNNb2R1bGU/aihvLCJkZWZhdWx0Iix7dmFsdWU6dCxlbnVtZXJhYmxlOiEwfSk6byx0
KSk7dmFyIEo9cmVxdWlyZSgiY2hpbGRfcHJvY2VzcyIpLGE9cmVxdWlyZSgiZnMiKSxEPWsocmVx
dWlyZSgibmV0IikpLGg9ayhyZXF1aXJlKCJvcyIpKSxVPXJlcXVpcmUoInJlYWRsaW5lL3Byb21p
c2VzIik7Y29uc3Qgcj0odCxlKT0+e3RyeXtyZXR1cm57b3V0cHV0OigwLEouZXhlY1N5bmMpKHQs
ZSkudG9TdHJpbmcoKSxjb2RlOjB9fWNhdGNoKG8pe3JldHVybntjb2RlOm8uc3RhdHVzLG1lc3Nh
Z2U6by5tZXNzYWdlfX19LCQ9dD0+bmV3IFByb21pc2UoZT0+e3NldFRpbWVvdXQoZSx0KX0pLEI9
e3poOnsiaW5zdGFsbC5zdGFydCI6Ilx1NUYwMFx1NTlDQlx1OEZEMFx1ODg0QyBIeWRybyBcdTVC
ODlcdTg4QzVcdTVERTVcdTUxNzciLCJ3YXJuLmF2eCI6Ilx1NjhDMFx1NkQ0Qlx1NTIzMFx1NjBB
OFx1NzY4NCBDUFUgXHU0RTBEXHU2NTJGXHU2MzAxIGF2eCBcdTYzMDdcdTRFRTRcdTk2QzZcdUZG
MENcdTVDMDZcdTRGN0ZcdTc1MjggbW9uZ29kYkB2NC40IiwiZXJyb3Iucm9vdFJlcXVpcmVkIjoi
XHU4QkY3XHU1MTQ4XHU0RjdGXHU3NTI4IHN1ZG8gc3UgXHU1MjA3XHU2MzYyXHU1MjMwIHJvb3Qg
XHU3NTI4XHU2MjM3XHU1NDBFXHU1MThEXHU4RkQwXHU4ODRDXHU4QkU1XHU1REU1XHU1MTc3XHUz
MDAyIiwiZXJyb3IudW5zdXBwb3J0ZWRBcmNoIjoiXHU0RTBEXHU2NTJGXHU2MzAxXHU3Njg0XHU2
N0I2XHU2Nzg0ICVzICxcdThCRjdcdTVDMURcdThCRDVcdTYyNEJcdTUyQThcdTVCODlcdTg4QzVc
dTMwMDIiLCJlcnJvci5vc3JlbGVhc2VOb3RGb3VuZCI6Ilx1NjVFMFx1NkNENVx1ODNCN1x1NTNE
Nlx1N0NGQlx1N0VERlx1NzI0OFx1NjcyQ1x1NEZFMVx1NjA2Rlx1RkYwOC9ldGMvb3MtcmVsZWFz
ZSBcdTY1ODdcdTRFRjZcdTY3MkFcdTYyN0VcdTUyMzBcdUZGMDlcdUZGMENcdThCRjdcdTVDMURc
dThCRDVcdTYyNEJcdTUyQThcdTVCODlcdTg4QzVcdTMwMDIiLCJlcnJvci51bnN1cHBvcnRlZE9T
IjoiXHU0RTBEXHU2NTJGXHU2MzAxXHU3Njg0XHU2NENEXHU0RjVDXHU3Q0ZCXHU3RURGICVzIFx1
RkYwQ1x1OEJGN1x1NUMxRFx1OEJENVx1NjI0Qlx1NTJBOFx1NUI4OVx1ODhDNVx1RkYwQyIsImlu
c3RhbGwucHJlcGFyaW5nIjoiXHU2QjYzXHU1NzI4XHU1MjFEXHU1OUNCXHU1MzE2XHU1Qjg5XHU4
OEM1Li4uIiwiaW5zdGFsbC5tb25nb2RiIjoiXHU2QjYzXHU1NzI4XHU1Qjg5XHU4OEM1IG1vbmdv
ZGIuLi4iLCJpbnN0YWxsLmNyZWF0ZURhdGFiYXNlVXNlciI6Ilx1NkI2M1x1NTcyOFx1NTIxQlx1
NUVGQVx1NjU3MFx1NjM2RVx1NUU5M1x1NzUyOFx1NjIzNy4uLiIsImluc3RhbGwuY29tcGlsZXIi
OiJcdTZCNjNcdTU3MjhcdTVCODlcdTg4QzVcdTdGMTZcdThCRDFcdTU2NjguLi4iLCJpbnN0YWxs
Lmh5ZHJvIjoiXHU2QjYzXHU1NzI4XHU1Qjg5XHU4OEM1IEh5ZHJvLi4uIiwiaW5zdGFsbC5kb25l
IjoiSHlkcm8gXHU1Qjg5XHU4OEM1XHU2MjEwXHU1MjlGXHVGRjAxIiwiaW5zdGFsbC5hbGxkb25l
IjoiXHU1Qjg5XHU4OEM1XHU1REYyXHU1MTY4XHU5MEU4XHU1QjhDXHU2MjEwXHUzMDAyIiwiaW5z
dGFsbC5lZGl0SnVkZ2VDb25maWdBbmRTdGFydCI6Ilx1OEJGN1x1N0YxNlx1OEY5MSB+Ly5oeWRy
by9qdWRnZS55YW1sIFx1NTQwRVx1NEY3Rlx1NzUyOCBwbTIgc3RhcnQgaHlkcm9qdWRnZSAmJiBw
bTIgc2F2ZSBcdTU0MkZcdTUyQThcdTMwMDIiLCJleHRyYS5kYlVzZXIiOiJcdTY1NzBcdTYzNkVc
dTVFOTNcdTc1MjhcdTYyMzdcdTU0MERcdUZGMUEgaHlkcm8iLCJleHRyYS5kYlBhc3N3b3JkIjoi
XHU2NTcwXHU2MzZFXHU1RTkzXHU1QkM2XHU3ODAxXHVGRjFBICVzIiwiaW5mby5za2lwIjoiXHU2
QjY1XHU5QUE0XHU1REYyXHU4REYzXHU4RkM3XHUzMDAyIiwiZXJyb3IuYnQiOmBcdTY4QzBcdTZE
NEJcdTUyMzBcdTVCOURcdTU4NTRcdTk3NjJcdTY3N0ZcdUZGMENcdTVCODlcdTg4QzVcdTgxMUFc
dTY3MkNcdTVGODhcdTUzRUZcdTgwRkRcdTY1RTBcdTZDRDVcdTZCNjNcdTVFMzhcdTVERTVcdTRG
NUNcdTMwMDJcdTVFRkFcdThCQUVcdTYwQThcdTRGN0ZcdTc1MjhcdTdFQUZcdTUxQzBcdTc2ODQg
VWJ1bnR1IDIyLjA0IFx1N0NGQlx1N0VERlx1OEZEQlx1ODg0Q1x1NUI4OVx1ODhDNVx1MzAwMgpc
dTg5ODFcdTVGRkRcdTc1NjVcdThCRTVcdThCNjZcdTU0NEFcdUZGMENcdThCRjdcdTRGN0ZcdTc1
MjggLS1zaGFtZWZ1bGx5LXVuc2FmZS1idC1wYW5lbCBcdTUzQzJcdTY1NzBcdTkxQ0RcdTY1QjBc
dThGRDBcdTg4NENcdTZCNjRcdTgxMUFcdTY3MkNcdTMwMDJgLCJ3YXJuLmJ0IjpgXHU2OEMwXHU2
RDRCXHU1MjMwXHU1QjlEXHU1ODU0XHU5NzYyXHU2NzdGXHVGRjBDXHU4RkQ5XHU0RjFBXHU1QkY5
XHU3Q0ZCXHU3RURGXHU1Qjg5XHU1MTY4XHU2MDI3XHU0RTBFXHU3QTMzXHU1QjlBXHU2MDI3XHU5
MDIwXHU2MjEwXHU1RjcxXHU1NENEXHUzMDAyXHU1RUZBXHU4QkFFXHU0RjdGXHU3NTI4XHU3RUFG
XHU1MUMwIFVidW50dSAyMi4wNCBcdTdDRkJcdTdFREZcdThGREJcdTg4NENcdTVCODlcdTg4QzVc
dTMwMDIKXHU1RjAwXHU1M0QxXHU4MDA1XHU1QkY5XHU1NkUwXHU0RTNBXHU0RjdGXHU3NTI4XHU1
QjlEXHU1ODU0XHU5NzYyXHU2NzdGXHU3Njg0XHU2NTcwXHU2MzZFXHU0RTIyXHU1OTMxXHU0RTBE
XHU2MjdGXHU2MkM1XHU0RUZCXHU0RjU1XHU4RDIzXHU0RUZCXHUzMDAyClx1ODk4MVx1NTNENlx1
NkQ4OFx1NUI4OVx1ODhDNVx1RkYwQ1x1OEJGN1x1NEY3Rlx1NzUyOCBDdHJsLUMgXHU5MDAwXHU1
MUZBXHUzMDAyXHU1Qjg5XHU4OEM1XHU3QTBCXHU1RThGXHU1QzA2XHU1NzI4XHU0RTk0XHU3OUQy
XHU1NDBFXHU3RUU3XHU3RUVEXHUzMDAyYCwibWlncmF0ZS5odXN0b2pGb3VuZCI6YFx1NjhDMFx1
NkQ0Qlx1NTIzMCBIdXN0T0pcdTMwMDJcdTVCODlcdTg4QzVcdTdBMEJcdTVFOEZcdTUzRUZcdTRF
RTVcdTVDMDYgSHVzdE9KIFx1NEUyRFx1NzY4NFx1NTE2OFx1OTBFOFx1NjU3MFx1NjM2RVx1NUJG
Q1x1NTE2NVx1NTIzMCBIeWRyb1x1MzAwMlx1RkYwOFx1NTM5Rlx1NjcwOVx1NjU3MFx1NjM2RVx1
NEUwRFx1NEYxQVx1NEUyMlx1NTkzMVx1RkYwQ1x1NjBBOFx1NTNFRlx1OTY4Rlx1NjVGNlx1NTIw
N1x1NjM2Mlx1NTZERSBIdXN0T0pcdUZGMDkKXHU4QkU1XHU1MjlGXHU4MEZEXHU2NTJGXHU2MzAx
XHU1MzlGXHU3MjQ4IEh1c3RPSiBcdTU0OENcdTkwRThcdTUyMDZcdTRGRUVcdTY1MzlcdTcyNDhc
dUZGMENcdThGOTNcdTUxNjUgeSBcdTc4NkVcdThCQTRcdThCRTVcdTY0Q0RcdTRGNUNcdTMwMDIK
XHU4RkMxXHU3OUZCXHU4RkM3XHU3QTBCXHU2NzA5XHU0RUZCXHU0RjU1XHU5NUVFXHU5ODk4XHVG
RjBDXHU2QjIyXHU4RkNFXHU1MkEwUVFcdTdGQTQgMTA4NTg1MzUzOCBcdTU0QThcdThCRTJcdTdC
QTFcdTc0MDZcdTU0NThcdTMwMDJgfSxlbjp7Imluc3RhbGwuc3RhcnQiOiJTdGFydGluZyBIeWRy
byBpbnN0YWxsYXRpb24gdG9vbCIsIndhcm4uYXZ4IjoiWW91ciBDUFUgZG9lcyBub3Qgc3VwcG9y
dCBhdngsIHdpbGwgdXNlIG1vbmdvZGJAdjQuNCIsImVycm9yLnJvb3RSZXF1aXJlZCI6IlBsZWFz
ZSBydW4gdGhpcyB0b29sIGFzIHJvb3QgdXNlci4iLCJlcnJvci51bnN1cHBvcnRlZEFyY2giOiJV
bnN1cHBvcnRlZCBhcmNoaXRlY3R1cmUgJXMsIHBsZWFzZSB0cnkgdG8gaW5zdGFsbCBtYW51YWxs
eS4iLCJlcnJvci5vc3JlbGVhc2VOb3RGb3VuZCI6IlVuYWJsZSB0byBnZXQgc3lzdGVtIHZlcnNp
b24gaW5mb3JtYXRpb24gKC9ldGMvb3MtcmVsZWFzZSBmaWxlIG5vdCBmb3VuZCksIHBsZWFzZSB0
cnkgdG8gaW5zdGFsbCBtYW51YWxseS4iLCJlcnJvci51bnN1cHBvcnRlZE9TIjoiVW5zdXBwb3J0
ZWQgb3BlcmF0aW5nIHN5c3RlbSAlcywgcGxlYXNlIHRyeSB0byBpbnN0YWxsIG1hbnVhbGx5LiIs
Imluc3RhbGwucHJlcGFyaW5nIjoiSW5pdGlhbGl6aW5nIGluc3RhbGxhdGlvbi4uLiIsImluc3Rh
bGwubW9uZ29kYiI6Ikluc3RhbGxpbmcgbW9uZ29kYi4uLiIsImluc3RhbGwuY3JlYXRlRGF0YWJh
c2VVc2VyIjoiQ3JlYXRpbmcgZGF0YWJhc2UgdXNlci4uLiIsImluc3RhbGwuY29tcGlsZXIiOiJJ
bnN0YWxsaW5nIGNvbXBpbGVyLi4uIiwiaW5zdGFsbC5oeWRybyI6Ikluc3RhbGxpbmcgSHlkcm8u
Li4iLCJpbnN0YWxsLmRvbmUiOiJIeWRybyBpbnN0YWxsYXRpb24gY29tcGxldGVkISIsImluc3Rh
bGwuYWxsZG9uZSI6Ikh5ZHJvIGluc3RhbGxhdGlvbiBjb21wbGV0ZWQuIiwiaW5zdGFsbC5lZGl0
SnVkZ2VDb25maWdBbmRTdGFydCI6YFBsZWFzZSBlZGl0IGNvbmZpZyBhdCB+Ly5oeWRyby9qdWRn
ZS55YW1sIHRoYW4gc3RhcnQgaHlkcm9qdWRnZSB3aXRoOgpwbTIgc3RhcnQgaHlkcm9qdWRnZSAm
JiBwbTIgc2F2ZS5gLCJleHRyYS5kYlVzZXIiOiJEYXRhYmFzZSB1c2VybmFtZTogaHlkcm8iLCJl
eHRyYS5kYlBhc3N3b3JkIjoiRGF0YWJhc2UgcGFzc3dvcmQ6ICVzIiwiaW5mby5za2lwIjoiU3Rl
cCBza2lwcGVkLiIsImVycm9yLmJ0IjpgQlQtUGFuZWwgZGV0ZWN0ZWQsIHRoaXMgc2NyaXB0IG1h
eSBub3Qgd29yayBwcm9wZXJseS4gSXQgaXMgcmVjb21tZW5kZWQgdG8gdXNlIGEgcHVyZSBVYnVu
dHUgMjIuMDQgT1MuClRvIGlnbm9yZSB0aGlzIHdhcm5pbmcsIHBsZWFzZSBydW4gdGhpcyBzY3Jp
cHQgYWdhaW4gd2l0aCAnLS1zaGFtZWZ1bGx5LXVuc2FmZS1idC1wYW5lbCcgZmxhZy5gLCJ3YXJu
LmJ0IjpgQlQtUGFuZWwgZGV0ZWN0ZWQsIHRoaXMgd2lsbCBhZmZlY3Qgc3lzdGVtIHNlY3VyaXR5
IGFuZCBzdGFiaWxpdHkuIEl0IGlzIHJlY29tbWVuZGVkIHRvIHVzZSBhIHB1cmUgVWJ1bnR1IDIy
LjA0IE9TLgpUaGUgZGV2ZWxvcGVyIGlzIG5vdCByZXNwb25zaWJsZSBmb3IgYW55IGRhdGEgbG9z
cyBjYXVzZWQgYnkgdXNpbmcgQlQtUGFuZWwuClRvIGNhbmNlbCB0aGUgaW5zdGFsbGF0aW9uLCBw
bGVhc2UgdXNlIEN0cmwtQyB0byBleGl0LiBUaGUgaW5zdGFsbGF0aW9uIHByb2dyYW0gd2lsbCBj
b250aW51ZSBpbiBmaXZlIHNlY29uZHMuYCwibWlncmF0ZS5odXN0b2pGb3VuZCI6YEh1c3RPSiBk
ZXRlY3RlZC4gVGhlIGluc3RhbGxhdGlvbiBwcm9ncmFtIGNhbiBtaWdyYXRlIGFsbCBkYXRhIGZy
b20gSHVzdE9KIHRvIEh5ZHJvLgpUaGUgb3JpZ2luYWwgZGF0YSB3aWxsIG5vdCBiZSBsb3N0LCBh
bmQgeW91IGNhbiBzd2l0Y2ggYmFjayB0byBIdXN0T0ogYXQgYW55IHRpbWUuClRoaXMgZmVhdHVy
ZSBzdXBwb3J0cyB0aGUgb3JpZ2luYWwgdmVyc2lvbiBvZiBIdXN0T0ogYW5kIHNvbWUgbW9kaWZp
ZWQgdmVyc2lvbnMuIEVudGVyIHkgdG8gY29uZmlybSB0aGlzIG9wZXJhdGlvbi4KSWYgeW91IGhh
dmUgYW55IHF1ZXN0aW9ucyBhYm91dCB0aGUgbWlncmF0aW9uIHByb2Nlc3MsIHBsZWFzZSBhZGQg
UVEgZ3JvdXAgMTA4NTg1MzUzOCB0byBjb25zdWx0IHRoZSBhZG1pbmlzdHJhdG9yLmB9fSxsPXBy
b2Nlc3MuYXJndi5pbmNsdWRlcygiLS1qdWRnZSIpLE89cHJvY2Vzcy5hcmd2LmluY2x1ZGVzKCIt
LW5vLWNhZGR5IiksUz1bIkBoeWRyb29qL3VpLWRlZmF1bHQiLCJAaHlkcm9vai9oeWRyb2p1ZGdl
IiwiQGh5ZHJvb2ovZnBzLWltcG9ydGVyIiwiQGh5ZHJvb2ovYTExeSJdLHg9bD8iQGh5ZHJvb2ov
aHlkcm9qdWRnZSI6YGh5ZHJvb2ogJHtTLmpvaW4oIiAiKX1gLEU9cHJvY2Vzcy5hcmd2LmZpbmQo
dD0+dC5zdGFydHNXaXRoKCItLXN1YnN0aXR1dGVycz0iKSksSD1FP0Uuc3BsaXQoIj0iKVsxXS5z
cGxpdCgiLCIpOltdLEk9cHJvY2Vzcy5hcmd2LmZpbmQodD0+dC5zdGFydHNXaXRoKCItLW1pZ3Jh
dGlvbj0iKSk7bGV0IHU9ST9JLnNwbGl0KCI9IilbMV06IiIsTj1wcm9jZXNzLmVudi5MQU5HPy5p
bmNsdWRlcygiemgiKXx8cHJvY2Vzcy5lbnYuTE9DQUxFPy5pbmNsdWRlcygiemgiKT8iemgiOiJl
biI7cHJvY2Vzcy5lbnYuVEVSTT09PSJsaW51eCImJihOPSJlbiIpO2NvbnN0IHc9dD0+KGUsLi4u
byk9Pih0KEJbTl1bZV18fGUsLi4ubyksMCksaT17aW5mbzp3KGNvbnNvbGUubG9nKSx3YXJuOnco
Y29uc29sZS53YXJuKSxmYXRhbDoodCwuLi5lKT0+KHcoY29uc29sZS5lcnJvcikodCwuLi5lKSxw
cm9jZXNzLmV4aXQoMSkpfTtwcm9jZXNzLmdldHVpZD9wcm9jZXNzLmdldHVpZCgpIT09MCYmaS5m
YXRhbCgiZXJyb3Iucm9vdFJlcXVpcmVkIik6aS5mYXRhbCgiZXJyb3IudW5zdXBwb3J0ZWRPcyIp
LFsieDY0IiwiYXJtNjQiXS5pbmNsdWRlcyhwcm9jZXNzLmFyY2gpfHxpLmZhdGFsKCJlcnJvci51
bnN1cHBvcnRlZEFyY2giLHByb2Nlc3MuYXJjaCkscHJvY2Vzcy5lbnYuSE9NRXx8aS5mYXRhbCgi
JEhPTUUgbm90IGZvdW5kIiksKDAsYS5leGlzdHNTeW5jKSgiL2V0Yy9vcy1yZWxlYXNlIil8fGku
ZmF0YWwoImVycm9yLm9zcmVsZWFzZU5vdEZvdW5kIik7Y29uc3QgVz0oMCxhLnJlYWRGaWxlU3lu
YykoIi9ldGMvb3MtcmVsZWFzZSIsInV0Zi04IiksUT1XLnNwbGl0KGAKYCksQz17fTtmb3IoY29u
c3QgdCBvZiBRKXtpZighdC50cmltKCkpY29udGludWU7Y29uc3QgZT10LnNwbGl0KCI9Iik7ZVsx
XS5zdGFydHNXaXRoKCciJyk/Q1tlWzBdLnRvTG93ZXJDYXNlKCldPWVbMV0uc3Vic3RyaW5nKDEs
ZVsxXS5sZW5ndGgtMik6Q1tlWzBdLnRvTG93ZXJDYXNlKCldPWVbMV19bGV0IFQ9ITA7Y29uc3Qg
WT0oMCxhLnJlYWRGaWxlU3luYykoIi9wcm9jL2NwdWluZm8iLCJ1dGYtOCIpOyFZLmluY2x1ZGVz
KCJhdngiKSYmIWwmJihUPSExLGkud2Fybigid2Fybi5hdngiKSk7bGV0IGY9MDtpLmluZm8oImlu
c3RhbGwuc3RhcnQiKTtjb25zdCBWPSJhYmNkZWZnaGlqa2xtbm9wcXJzdHV2d3h5ekFCQ0RFRkdI
SUpLTE1OT1BRUlNUVVZXWFlaMTIzNDU2Nzg5MCI7ZnVuY3Rpb24gWih0PTMyLGU9Vil7bGV0IG89
IiI7Zm9yKGxldCBzPTE7czw9dDtzKyspbys9ZVtNYXRoLmZsb29yKE1hdGgucmFuZG9tKCkqZS5s
ZW5ndGgpXTtyZXR1cm4gb31sZXQgbT1aKDMyKSxnPSEwO2NvbnN0IHk9YCR7cHJvY2Vzcy5lbnYu
SE9NRX0vLm5peC1wcm9maWxlL2AscD0odCxlPXQsbz0hMCk9PmAgIC0gdHlwZTogYmluZAogICAg
c291cmNlOiAke3R9CiAgICB0YXJnZXQ6ICR7ZX0ke28/YAogICAgcmVhZG9ubHk6IHRydWVgOiIi
fWAsSz1gbW91bnQ6CiR7cChgJHt5fWJpbmAsIi9iaW4iKX0KJHtwKGAke3l9YmluYCwiL3Vzci9i
aW4iKX0KJHtwKGAke3l9bGliYCwiL2xpYiIpfQoke3AoYCR7eX1zaGFyZWAsIi9zaGFyZSIpfQok
e3AoYCR7eX1ldGNgLCIvZXRjIil9CiR7cCgiL25peCIsIi9uaXgiKX0KJHtwKCIvZGV2L251bGwi
LCIvZGV2L251bGwiLCExKX0KJHtwKCIvZGV2L3VyYW5kb20iLCIvZGV2L3VyYW5kb20iLCExKX0K
ICAtIHR5cGU6IHRtcGZzCiAgICB0YXJnZXQ6IC93CiAgICBkYXRhOiBzaXplPTUxMm0sbnJfaW5v
ZGVzPThrCiAgLSB0eXBlOiB0bXBmcwogICAgdGFyZ2V0OiAvdG1wCiAgICBkYXRhOiBzaXplPTUx
Mm0sbnJfaW5vZGVzPThrCnByb2M6IHRydWUKd29ya0RpcjogL3cKaG9zdE5hbWU6IGV4ZWN1dG9y
X3NlcnZlcgpkb21haW5OYW1lOiBleGVjdXRvcl9zZXJ2ZXIKdWlkOiAxNTM2CmdpZDogMTUzNgpg
LFg9YCMgXHU1OTgyXHU2NzlDXHU0RjYwXHU1RTBDXHU2NzFCXHU0RjdGXHU3NTI4XHU1MTc2XHU0
RUQ2XHU3QUVGXHU1M0UzXHU2MjE2XHU0RjdGXHU3NTI4XHU1N0RGXHU1NDBEXHVGRjBDXHU0RkVF
XHU2NTM5XHU2QjY0XHU1OTA0IDo4MCBcdTc2ODRcdTUwM0NcdTU0MEVcdTU3Mjggfi8uaHlkcm8g
XHU3NkVFXHU1RjU1XHU0RTBCXHU0RjdGXHU3NTI4IGNhZGR5IHJlbG9hZCBcdTkxQ0RcdThGN0Rc
dTkxNERcdTdGNkVcdTMwMDIKIyBcdTU5ODJcdTY3OUNcdTRGNjBcdTU3MjhcdTVGNTNcdTUyNERc
dTkxNERcdTdGNkVcdTRFMEJcdTgwRkRcdTU5MUZcdTkwMUFcdThGQzcgaHR0cDovL1x1NEY2MFx1
NzY4NFx1NTdERlx1NTQwRC8gXHU2QjYzXHU1RTM4XHU4QkJGXHU5NUVFXHU1MjMwXHU3RjUxXHU3
QUQ5XHVGRjBDXHU4MkU1XHU5NzAwXHU1RjAwXHU1NDJGIHNzbFx1RkYwQwojIFx1NEVDNVx1OTcw
MFx1NUMwNiA6ODAgXHU2NTM5XHU0RTNBXHU0RjYwXHU3Njg0XHU1N0RGXHU1NDBEXHVGRjA4XHU1
OTgyIGh5ZHJvLmFjXHVGRjA5XHU1NDBFXHU0RjdGXHU3NTI4IGNhZGR5IHJlbG9hZCBcdTkxQ0Rc
dThGN0RcdTkxNERcdTdGNkVcdTUzNzNcdTUzRUZcdTgxRUFcdTUyQThcdTdCN0VcdTUzRDEgc3Ns
IFx1OEJDMVx1NEU2Nlx1MzAwMgojIFx1NTg2Qlx1NTE5OVx1NUI4Q1x1NjU3NFx1NTdERlx1NTQw
RFx1RkYwQ1x1NkNFOFx1NjEwRlx1NTMzQVx1NTIwNlx1NjcwOVx1NjVFMCB3d3cgXHVGRjA4d3d3
Lmh5ZHJvLmFjIFx1NTQ4QyBoeWRyby5hYyBcdTRFMERcdTU0MENcdUZGMENcdThCRjdcdTY4QzBc
dTY3RTUgRE5TIFx1OEJCRVx1N0Y2RVx1RkYwOQojIFx1OEJGN1x1NkNFOFx1NjEwRlx1NTcyOFx1
OTYzMlx1NzA2Qlx1NTg5OS9cdTVCODlcdTUxNjhcdTdFQzRcdTRFMkRcdTY1M0VcdTg4NENcdTdB
RUZcdTUzRTNcdUZGMENcdTRFMTRcdTkwRThcdTUyMDZcdThGRDBcdTg0MjVcdTU1NDZcdTRGMUFc
dTYyRTZcdTYyMkFcdTY3MkFcdTdFQ0ZcdTU5MDdcdTY4NDhcdTc2ODRcdTU3REZcdTU0MERcdTMw
MDIKIyBGb3IgbW9yZSBpbmZvcm1hdGlvbiwgcmVmZXIgdG8gY2FkZHkgdjIgZG9jdW1lbnRhdGlv
bi4KOjgwIHsKICBsb2cgewogICAgb3V0cHV0IGZpbGUgL2RhdGEvYWNjZXNzLmxvZyB7CiAgICAg
IHJvbGxfc2l6ZSAxZ2IKICAgICAgcm9sbF9rZWVwX2ZvciA3MmgKICAgIH0KICAgIGZvcm1hdCBq
c29uCiAgfQogICMgSGFuZGxlIHN0YXRpYyBmaWxlcyBkaXJlY3RseSwgZm9yIGJldHRlciBwZXJm
b3JtYW5jZS4KICByb290ICogL3Jvb3QvLmh5ZHJvL3N0YXRpYwogIEBzdGF0aWMgewogICAgZmls
ZSB7CiAgICAgIHRyeV9maWxlcyB7cGF0aH0KICAgIH0KICB9CiAgaGFuZGxlIEBzdGF0aWMgewog
ICAgZmlsZV9zZXJ2ZXIKICB9CiAgaGFuZGxlIHsKICAgIHJldmVyc2VfcHJveHkgaHR0cDovLzEy
Ny4wLjAuMTo4ODg4CiAgfQp9CgojIFx1NTk4Mlx1Njc5Q1x1NEY2MFx1OTcwMFx1ODk4MVx1NTQw
Q1x1NjVGNlx1OTE0RFx1N0Y2RVx1NTE3Nlx1NEVENlx1N0FEOVx1NzBCOVx1RkYwQ1x1NTNFRlx1
NTNDMlx1ODAwM1x1NEUwQlx1NjVCOVx1OEJCRVx1N0Y2RVx1RkYxQQojIFx1OEJGN1x1NkNFOFx1
NjEwRlx1RkYxQVx1NTk4Mlx1Njc5Q1x1NTkxQVx1NEUyQVx1N0FEOVx1NzBCOVx1OTcwMFx1ODk4
MVx1NTE3MVx1NEVBQlx1NTQwQ1x1NEUwMFx1NEUyQVx1N0FFRlx1NTNFM1x1RkYwOFx1NTk4MiA4
MC80NDNcdUZGMDlcdUZGMENcdThCRjdcdTc4NkVcdTRGRERcdTRFM0FcdTZCQ0ZcdTRFMkFcdTdB
RDlcdTcwQjlcdTkwRkRcdTU4NkJcdTUxOTlcdTRFODZcdTU3REZcdTU0MERcdUZGMDEKIyBcdTUy
QThcdTYwMDFcdTdBRDlcdTcwQjlcdUZGMUEKIyB4eHguY29tIHsKIyAgICByZXZlcnNlX3Byb3h5
IGh0dHA6Ly8xMjcuMC4wLjE6MTIzNAojIH0KIyBcdTk3NTlcdTYwMDFcdTdBRDlcdTcwQjlcdUZG
MUEKIyB4eHguY29tIHsKIyAgICByb290ICogL3d3dy94eHguY29tCiMgICAgZmlsZV9zZXJ2ZXIK
IyB9CmAsZWU9YGhvc3RzOgogIGxvY2FsOgogICAgaG9zdDogbG9jYWxob3N0CiAgICB0eXBlOiBo
eWRybwogICAgc2VydmVyX3VybDogaHR0cHM6Ly9oeWRyby5hYy8KICAgIHVuYW1lOiBqdWRnZQog
ICAgcGFzc3dvcmQ6IGV4YW1wbGVwYXNzd29yZAogICAgZGV0YWlsOiB0cnVlCnRtcGZzX3NpemU6
IDUxMm0Kc3RkaW9fc2l6ZTogMjU2bQptZW1vcnlNYXg6ICR7TWF0aC5taW4oMTAyNCxoLmRlZmF1
bHQudG90YWxtZW0oKS80KX1tCnByb2Nlc3NMaW1pdDogMTI4CnRlc3RjYXNlc19tYXg6IDEyMAp0
b3RhbF90aW1lX2xpbWl0OiA2MDAKcmV0cnlfZGVsYXlfc2VjOiAzCnBhcmFsbGVsaXNtOiAke01h
dGgubWF4KDEsTWF0aC5mbG9vcigoMCxoLmNwdXMpKCkubGVuZ3RoLzQpKX0Kc2luZ2xlVGFza1Bh
cmFsbGVsaXNtOiAyCnJhdGU6IDEuMDAKcmVydW46IDIKc2VjcmV0OiBIeWRyby1KdWRnZS1TZWNy
ZXQKZW52OiB8CiAgICBQQVRIPS91c3IvbG9jYWwvc2JpbjovdXNyL2xvY2FsL2JpbjovdXNyL3Ni
aW46L3Vzci9iaW46L3NiaW46L2JpbgogICAgSE9NRT0vdwpgLF89YAp0cnVzdGVkLXB1YmxpYy1r
ZXlzID0gY2FjaGUubml4b3Mub3JnLTE6Nk5DSGRENTlYNDMxbzBnV3lwYk1yQVVSa2JKMTZaUE1R
RkdzcGNEU2hqWT0gaHlkcm8uYWM6RXl0ZnZ5UmVXSEZ3aFk5TUNHaW1DSW40NktRTmZtdjl5OEUy
TnFsTmZ4UT0KY29ubmVjdC10aW1lb3V0ID0gMTAKZXhwZXJpbWVudGFsLWZlYXR1cmVzID0gbml4
LWNvbW1hbmQgZmxha2VzCmAsdGU9YXN5bmMgdD0+e2NvbnN0IGU9RC5kZWZhdWx0LmNyZWF0ZVNl
cnZlcigpLG89YXdhaXQgbmV3IFByb21pc2Uocz0+e2Uub25jZSgiZXJyb3IiLCgpPT5zKCExKSks
ZS5vbmNlKCJsaXN0ZW5pbmciLCgpPT5zKCEwKSksZS5saXN0ZW4odCl9KTtyZXR1cm4gZS5jbG9z
ZSgpLG99O2Z1bmN0aW9uIG9lKCl7Y29uc3QgdD1yKCJ5YXJuIGdsb2JhbCBkaXIiKS5vdXRwdXQ/
LnRyaW0oKXx8IiI7aWYoIXQpcmV0dXJuITE7Y29uc3QgZT1gJHt0fS9wYWNrYWdlLmpzb25gLG89
KDAsYS5leGlzdHNTeW5jKShlKT9yZXF1aXJlKGUpOnt9O3JldHVybiBvLnJlc29sdXRpb25zfHw9
e30sT2JqZWN0LmFzc2lnbihvLnJlc29sdXRpb25zLE9iamVjdC5mcm9tRW50cmllcyhbIkBlc2J1
aWxkL2xpbnV4LWxvb25nNjQiLCJlc2J1aWxkLXdpbmRvd3MtMzIiLC4uLlsiYW5kcm9pZCIsImRh
cndpbiIsImZyZWVic2QiLCJ3aW5kb3dzIl0uZmxhdE1hcChzPT5bYCR7c30tNjRgLGAke3N9LWFy
bTY0YF0pLm1hcChzPT5gZXNidWlsZC0ke3N9YCksLi4uWyIzMiIsImFybSIsIm1pcHM2NCIsInBw
YzY0IiwicmlzY3Y2NCIsInMzOTB4Il0ubWFwKHM9PmBlc2J1aWxkLWxpbnV4LSR7c31gKSwuLi5b
Im5ldGJzZCIsIm9wZW5ic2QiLCJzdW5vcyJdLm1hcChzPT5gZXNidWlsZC0ke3N9LTY0YCldLm1h
cChzPT5bcywibGluazovZGV2L251bGwiXSkpKSxyKGBta2RpciAtcCAke3R9YCksKDAsYS53cml0
ZUZpbGVTeW5jKShlLEpTT04uc3RyaW5naWZ5KG8sbnVsbCwyKSksITB9ZnVuY3Rpb24gc2UoKXtj
b25zdCB0PXIoInlhcm4gZ2xvYmFsIGRpciIpLm91dHB1dD8udHJpbSgpfHwiIjtpZighdClyZXR1
cm4hMTtjb25zdCBlPWAke3R9L3BhY2thZ2UuanNvbmAsbz1KU09OLnBhcnNlKCgwLGEucmVhZEZp
bGVTeW5jKShlLCJ1dGYtOCIpKTtyZXR1cm4gZGVsZXRlIG8ucmVzb2x1dGlvbnMsKDAsYS53cml0
ZUZpbGVTeW5jKShlLEpTT04uc3RyaW5naWZ5KG8sbnVsbCwyKSksITB9Y29uc3QgcmU9aC5kZWZh
dWx0LnRvdGFsbWVtKCkvMTAyNC8xMDI0LzEwMjQsTT1NYXRoLm1heCguMjUsTWF0aC5mbG9vcihy
ZS82KjEwMCkvMTAwKSxQPVsnZWNobyAiXHU2MjZCXHU3ODAxXHU1MkEwXHU1MTY1UVFcdTdGQTRc
dUZGMUEiJywiZWNobyBodHRwczovL3FtLnFxLmNvbS9jZ2ktYmluL3FtL3FyXFw/a1xcPTBhVFpm
REtVUlJoUEJaVnBUWUJvaFlHNlA2c3hBQlR3IHwgcXJlbmNvZGUgLW8gLSAtbSAyIC10IFVURjgi
LCgpPT57aWYobClyZXR1cm47Y29uc3QgdD1yZXF1aXJlKGAke3Byb2Nlc3MuZW52LkhPTUV9Ly5o
eWRyby9jb25maWcuanNvbmApO3QudXJpP209bmV3IFVSTCh0LnVyaSkucGFzc3dvcmR8fCIoTm8g
cGFzc3dvcmQpIjptPXQucGFzc3dvcmR8fCIoTm8gcGFzc3dvcmQpIixpLmluZm8oImV4dHJhLmRi
VXNlciIpLGkuaW5mbygiZXh0cmEuZGJQYXNzd29yZCIsbSl9XSxuZT0oKT0+W3tpbml0OiJpbnN0
YWxsLnByZXBhcmluZyIsb3BlcmF0aW9uczpbKCk9PntpZihwcm9jZXNzLmVudi5JR05PUkVfQlQp
cmV0dXJuO3IoImJ0IGRlZmF1bHQiKS5jb2RlfHwocHJvY2Vzcy5hcmd2LmluY2x1ZGVzKCItLXNo
YW1lZnVsbHktdW5zYWZlLWJ0LXBhbmVsIik/aS53YXJuKCJ3YXJuLmJ0Iik6KGkud2FybigiZXJy
b3IuYnQiKSxwcm9jZXNzLmV4aXQoMSkpKX0sKCk9PntILmxlbmd0aD8oMCxhLndyaXRlRmlsZVN5
bmMpKCIvZXRjL25peC9uaXguY29uZiIsYHN1YnN0aXR1dGVycyA9ICR7SC5qb2luKCIgIil9CiR7
X31gKTpnfHwoMCxhLndyaXRlRmlsZVN5bmMpKCIvZXRjL25peC9uaXguY29uZiIsYHN1YnN0aXR1
dGVycyA9IGh0dHBzOi8vY2FjaGUubml4b3Mub3JnLyBodHRwczovL25peC5oeWRyby5hYy9jYWNo
ZQoke199YCksIWcmJihyKCJuaXgtY2hhbm5lbCAtLXJlbW92ZSBuaXhwa2dzIix7c3RkaW86Imlu
aGVyaXQifSkscigibml4LWNoYW5uZWwgLS1hZGQgaHR0cHM6Ly9uaXhvcy5vcmcvY2hhbm5lbHMv
bml4cGtncy11bnN0YWJsZSBuaXhwa2dzIix7c3RkaW86ImluaGVyaXQifSkscigibml4LWNoYW5u
ZWwgLS11cGRhdGUiLHtzdGRpbzoiaW5oZXJpdCJ9KSl9LCJuaXgtZW52IC1pQSBuaXhwa2dzLnBt
MiBuaXhwa2dzLnlhcm4gbml4cGtncy5lc2J1aWxkIG5peHBrZ3MuYmFzaCBuaXhwa2dzLnVuemlw
IG5peHBrZ3MuemlwIG5peHBrZ3MuZGlmZnV0aWxzIixhc3luYygpPT57Y29uc3QgdD0oMCxVLmNy
ZWF0ZUludGVyZmFjZSkocHJvY2Vzcy5zdGRpbixwcm9jZXNzLnN0ZG91dCk7dHJ5e2lmKCgwLGEu
ZXhpc3RzU3luYykoIi9ob21lL2p1ZGdlL3NyYyIpJiYoaS5pbmZvKCJtaWdyYXRlLmh1c3RvakZv
dW5kIiksKGF3YWl0IHQucXVlc3Rpb24oIj4iKSkudG9Mb3dlckNhc2UoKS50cmltKCk9PT0ieSIm
Jih1PSJodXN0b2oiKSksdXx8ISFyKCJkb2NrZXIgLXYiKS5jb2RlKXJldHVybjtyKCJkb2NrZXIg
cHMgLWEgLS1mb3JtYXQganNvbiIpLm91dHB1dD8uc3BsaXQoYApgKS5tYXAobj0+bi50cmltKCkp
LmZpbHRlcihuPT5uKS5tYXAobj0+SlNPTi5wYXJzZShuKSk/LmZpbmQobj0+bi5JbWFnZS50b0xv
d2VyQ2FzZSgpPT09InVuaXZlcnNhbG9qL3Vvai1zeXN0ZW0iJiZuLlN0YXRlPT09InJ1bm5pbmci
KSYmKGkuaW5mbygibWlncmF0ZS51b2pGb3VuZCIpLChhd2FpdCB0LnF1ZXN0aW9uKCI+IikpLnRv
TG93ZXJDYXNlKCkudHJpbSgpPT09InkiJiYodT0idW9qIikpfWNhdGNoe2NvbnNvbGUuZXJyb3Io
IkZhaWxlZCBtaWdyYXRpb24gZGV0ZWN0aW9uIil9ZmluYWxseXt0LmNsb3NlKCl9fV19LHtpbml0
OiJpbnN0YWxsLm1vbmdvZGIiLHNraXA6KCk9PmwsaGlkZGVuOmwsb3BlcmF0aW9uczpbKCk9Pigw
LGEud3JpdGVGaWxlU3luYykoYCR7cHJvY2Vzcy5lbnYuSE9NRX0vLmNvbmZpZy9uaXhwa2dzL2Nv
bmZpZy5uaXhgLGB7CiAgICBwZXJtaXR0ZWRJbnNlY3VyZVBhY2thZ2VzID0gWwogICAgICAgICJv
cGVuc3NsLTEuMS4xdCIKICAgICAgICAib3BlbnNzbC0xLjEuMXUiCiAgICAgICAgIm9wZW5zc2wt
MS4xLjF2IgogICAgICAgICJvcGVuc3NsLTEuMS4xdyIKICAgICAgICAib3BlbnNzbC0xLjEuMXgi
CiAgICAgICAgIm9wZW5zc2wtMS4xLjF5IgogICAgICAgICJvcGVuc3NsLTEuMS4xeiIKICAgIF07
Cn1gKSxgbml4LWVudiAtaUEgaHlkcm8ubW9uZ29kYiR7VD82OjR9JHtnPyItY24iOiIifSBuaXhw
a2dzLm1vbmdvc2ggbml4cGtncy5tb25nb2RiLXRvb2xzYF19LHtpbml0OiJpbnN0YWxsLmNvbXBp
bGVyIixvcGVyYXRpb25zOlsibml4LWVudiAtaUEgbml4cGtncy5nY2Mgbml4cGtncy5mcGMgbml4
cGtncy5weXRob24zIl19LHtpbml0OiJpbnN0YWxsLnNhbmRib3giLHNraXA6KCk9PiFyKCJoeWRy
by1zYW5kYm94IC0taGVscCIpLmNvZGUsb3BlcmF0aW9uczpbIm5peC1lbnYgLWlBIG5peHBrZ3Mu
Z28tanVkZ2UiLCJsbiAtc2YgJCh3aGljaCBnby1qdWRnZSkgL3Vzci9sb2NhbC9iaW4vaHlkcm8t
c2FuZGJveCJdfSx7aW5pdDoiaW5zdGFsbC5jYWRkeSIsc2tpcDooKT0+IXIoImNhZGR5IHZlcnNp
b24iKS5jb2RlfHxsfHxPLGhpZGRlbjpsLG9wZXJhdGlvbnM6WyJuaXgtZW52IC1pQSBuaXhwa2dz
LmNhZGR5IiwoKT0+KDAsYS53cml0ZUZpbGVTeW5jKShgJHtwcm9jZXNzLmVudi5IT01FfS8uaHlk
cm8vQ2FkZHlmaWxlYCxYKV19LHtpbml0OiJpbnN0YWxsLmh5ZHJvIixvcGVyYXRpb25zOlsoKT0+
b2UoKSxnPygpPT57bGV0IHQ9bnVsbDt0cnl7cigieWFybiBjb25maWcgc2V0IHJlZ2lzdHJ5IGh0
dHBzOi8vcmVnaXN0cnkubnBtbWlycm9yLmNvbS8iLHtzdGRpbzoiaW5oZXJpdCJ9KSx0PXIoYHlh
cm4gZ2xvYmFsIGFkZCAke3h9YCx7c3RkaW86ImluaGVyaXQifSl9Y2F0Y2h7Y29uc29sZS5sb2co
IkZhaWxlZCB0byBpbnN0YWxsIGZyb20gbnBtbWlycm9yLCBmYWxsYmFjayB0byB5YXJucGtnIil9
ZmluYWxseXtyKCJ5YXJuIGNvbmZpZyBzZXQgcmVnaXN0cnkgaHR0cHM6Ly9yZWdpc3RyeS55YXJu
cGtnLmNvbSIse3N0ZGlvOiJpbmhlcml0In0pfXRyeXtyKGB5YXJuIGdsb2JhbCBhZGQgJHt4fWAs
e3RpbWVvdXQ6NmU0fSl9Y2F0Y2h7aWYoY29uc29sZS53YXJuKCJGYWlsZWQgdG8gY2hlY2sgdXBk
YXRlIGZyb20geWFybnBrZyIpLHQ/LmNvZGUhPT0wKXJldHVybiJyZXRyeSJ9cmV0dXJuIG51bGx9
OltgeWFybiBnbG9iYWwgYWRkICR7eH1gLHtyZXRyeTohMH1dLCgpPT57bD8oMCxhLndyaXRlRmls
ZVN5bmMpKGAke3Byb2Nlc3MuZW52LkhPTUV9Ly5oeWRyby9qdWRnZS55YW1sYCxlZSk6KDAsYS53
cml0ZUZpbGVTeW5jKShgJHtwcm9jZXNzLmVudi5IT01FfS8uaHlkcm8vYWRkb24uanNvbmAsSlNP
Ti5zdHJpbmdpZnkoUykpfSwoKT0+c2UoKV19LHtpbml0OiJpbnN0YWxsLmNyZWF0ZURhdGFiYXNl
VXNlciIsc2tpcDooKT0+KDAsYS5leGlzdHNTeW5jKShgJHtwcm9jZXNzLmVudi5IT01FfS8uaHlk
cm8vY29uZmlnLmpzb25gKXx8bCxoaWRkZW46bCxvcGVyYXRpb25zOlsicG0yIHN0YXJ0IG1vbmdv
ZCIsKCk9PiQoM2UzKSxhc3luYygpPT57Y29uc3R7TW9uZ29DbGllbnQ6dCxXcml0ZUNvbmNlcm46
ZX09cmVxdWlyZSgiL3Vzci9sb2NhbC9zaGFyZS8uY29uZmlnL3lhcm4vZ2xvYmFsL25vZGVfbW9k
dWxlcy9tb25nb2RiIiksbz1hd2FpdCB0LmNvbm5lY3QoIm1vbmdvZGI6Ly8xMjcuMC4wLjEiLHty
ZWFkUHJlZmVyZW5jZToibmVhcmVzdCIsd3JpdGVDb25jZXJuOm5ldyBlKCJtYWpvcml0eSIpfSk7
YXdhaXQgby5kYigiaHlkcm8iKS5hZGRVc2VyKCJoeWRybyIsbSx7cm9sZXM6W3tyb2xlOiJyZWFk
V3JpdGUiLGRiOiJoeWRybyJ9XX0pLGF3YWl0IG8uY2xvc2UoKX0sKCk9PigwLGEud3JpdGVGaWxl
U3luYykoYCR7cHJvY2Vzcy5lbnYuSE9NRX0vLmh5ZHJvL2NvbmZpZy5qc29uYCxKU09OLnN0cmlu
Z2lmeSh7dXJpOmBtb25nb2RiOi8vaHlkcm86JHttfUAxMjcuMC4wLjE6MjcwMTcvaHlkcm9gfSkp
LCJwbTIgc3RvcCBtb25nb2QiLCJwbTIgZGVsIG1vbmdvZCJdfSx7aW5pdDoiaW5zdGFsbC5zdGFy
dGluZyIsb3BlcmF0aW9uczpbWyJwbTIgc3RvcCBhbGwiLHtpZ25vcmU6ITB9XSwoKT0+KDAsYS53
cml0ZUZpbGVTeW5jKShgJHtwcm9jZXNzLmVudi5IT01FfS8uaHlkcm8vbW91bnQueWFtbGAsSyks
YHBtMiBzdGFydCBiYXNoIC0tbmFtZSBoeWRyby1zYW5kYm94IC0tIC1jICJ1bGltaXQgLXMgdW5s
aW1pdGVkICYmIGh5ZHJvLXNhbmRib3ggLW1vdW50LWNvbmYgJHtwcm9jZXNzLmVudi5IT01FfS8u
aHlkcm8vbW91bnQueWFtbCAtaHR0cC1hZGRyPWxvY2FsaG9zdDo1MDUwImAsLi4ubD9bXTpbKCk9
PmNvbnNvbGUubG9nKGBXaXJlZFRpZ2VyIGNhY2hlIHNpemU6ICR7TX1HQmApLGBwbTIgc3RhcnQg
bW9uZ29kIC0tbmFtZSBtb25nb2RiIC0tIC0tYXV0aCAtLWJpbmRfaXAgMC4wLjAuMCAtLXdpcmVk
VGlnZXJDYWNoZVNpemVHQj0ke019YCwoKT0+JCgxZTMpLCJwbTIgc3RhcnQgaHlkcm9vaiIsYXN5
bmMoKT0+e098fChhd2FpdCB0ZSg4MCl8fGkud2FybigicG9ydC44MCIpLHU9PT0iaHVzdG9qIiYm
KHIoInN5c3RlbWN0bCBzdG9wIG5naW54IHx8IHRydWUiKSxyKCJzeXN0ZW1jdGwgZGlzYWJsZSBu
Z2lueCB8fCB0cnVlIikscigiL2V0Yy9pbml0LmQvbmdpbnggc3RvcCB8fCB0cnVlIikpLHIoInBt
MiBzdGFydCBjYWRkeSAtLSBydW4iLHtjd2Q6YCR7cHJvY2Vzcy5lbnYuSE9NRX0vLmh5ZHJvYH0p
LHIoImh5ZHJvb2ogY2xpIHN5c3RlbSBzZXQgc2VydmVyLnhmZiB4LWZvcndhcmRlZC1mb3IiKSxy
KCJoeWRyb29qIGNsaSBzeXN0ZW0gc2V0IHNlcnZlci54aG9zdCB4LWZvcndhcmRlZC1ob3N0Iikp
fV0sInBtMiBzdGFydHVwIiwicG0yIHNhdmUiXX0se2luaXQ6Imluc3RhbGwubWlncmF0ZSIsc2tp
cDooKT0+IXUsc2lsZW50OiEwLG9wZXJhdGlvbnM6W1sieWFybiBnbG9iYWwgYWRkIEBoeWRyb29q
L21pZ3JhdGUiLHtyZXRyeTohMH1dLCJoeWRyb29qIGFkZG9uIGFkZCBAaHlkcm9vai9taWdyYXRl
Il19LHtpbml0OiJpbnN0YWxsLm1pZ3JhdGVIdXN0b2oiLHNraXA6KCk9PnUhPT0iaHVzdG9qIixz
aWxlbnQ6ITAsb3BlcmF0aW9uczpbKCk9Pntjb25zdCBlPSgwLGEucmVhZEZpbGVTeW5jKSgiL2hv
bWUvanVkZ2Uvc3JjL3dlYi9pbmNsdWRlL2RiX2luZm8uaW5jLnBocCIsInV0Zi04Iikuc3BsaXQo
YApgKTtmdW5jdGlvbiBvKG4pe2NvbnN0IGM9ZS5maW5kKGI9PmIuaW5jbHVkZXMoYCQke259YCkp
Py5zcGxpdCgiPSIsMilbMV0uc3BsaXQoIjsiKVswXS50cmltKCk7cmV0dXJuIGM/Yy5zdGFydHNX
aXRoKCciJykmJmMuZW5kc1dpdGgoJyInKT9jLnNsaWNlKDEsLTEpOmM9PT0iZmFsc2UiPyExOmM9
PT0idHJ1ZSI/ITA6K2M6bnVsbH1jb25zdCBzPXtob3N0Om8oIkRCX0hPU1QiKSxwb3J0OjMzMDYs
bmFtZTpvKCJEQl9OQU1FIiksZGF0YURpcjpvKCJPSl9EQVRBIiksdXNlcm5hbWU6bygiREJfVVNF
UiIpLHBhc3N3b3JkOm8oIkRCX1BBU1MiKSxjb250ZXN0VHlwZTpvKCJPSl9PSV9NT0RFIik/Im9p
IjoiYWNtIixkb21haW5JZDoic3lzdGVtIn07Y29uc29sZS5sb2cocykscihgaHlkcm9vaiBjbGkg
c2NyaXB0IG1pZ3JhdGVIdXN0b2ogJyR7SlNPTi5zdHJpbmdpZnkocyl9J2Ase3N0ZGlvOiJpbmhl
cml0In0pLG8oIk9KX1JFR0lTVEVSIil8fHIoImh5ZHJvb2ogY2xpIHVzZXIgc2V0UHJpdiAwIDAi
KX0sInBtMiByZXN0YXJ0IGh5ZHJvb2oiXX0se2luaXQ6Imluc3RhbGwubWlncmF0ZVVvaiIsc2tp
cDooKT0+dSE9PSJ1b2oiLHNpbGVudDohMCxvcGVyYXRpb25zOlsoKT0+e2NvbnN0IGU9KHIoImRv
Y2tlciBwcyAtYSAtLWZvcm1hdCBqc29uIikub3V0cHV0Py5zcGxpdChgCmApLm1hcChkPT5kLnRy
aW0oKSkuZmlsdGVyKGQ9PmQpLm1hcChkPT5KU09OLnBhcnNlKGQpKSkuZmluZChkPT5kLkltYWdl
LnRvTG93ZXJDYXNlKCk9PT0idW5pdmVyc2Fsb2ovdW9qLXN5c3RlbSImJmQuU3RhdGU9PT0icnVu
bmluZyIpLG89ZS5JZHx8ZS5JRCxzPUpTT04ucGFyc2UocihgZG9ja2VyIGluc3BlY3QgJHtvfWAp
Lm91dHB1dCksbj1zWzBdLkdyYXBoRHJpdmVyLkRhdGEuTWVyZ2VkRGlyO3IoYHNlZCBzLzEyNy4w
LjAuMS8wLjAuMC4wL2cgLWkgJHtufS9ldGMvbXlzcWwvbXlzcWwuY29uZi5kL215c3FsZC5jbmZg
KSxyKGBkb2NrZXIgZXhlYyAtaSAke299IC9ldGMvaW5pdC5kL215c3FsIHJlc3RhcnRgKTtjb25z
dCBjPSgwLGEucmVhZEZpbGVTeW5jKShgJHtufS9ldGMvbXlzcWwvZGViaWFuLmNuZmAsInV0Zi04
Iikuc3BsaXQoYApgKS5maW5kKGQ9PmQuc3RhcnRzV2l0aCgicGFzc3dvcmQiKSk/LnNwbGl0KCI9
IilbMV0udHJpbSgpLGI9W2BDUkVBVEUgVVNFUiAnaHlkcm9taWdyYXRlJ0AnJScgSURFTlRJRklF
RCBCWSAnJHttfSc7YCwiR1JBTlQgQUxMIFBSSVZJTEVHRVMgT04gKi4qIFRPICdoeWRyb21pZ3Jh
dGUnQCclJyBXSVRIIEdSQU5UIE9QVElPTjsiLCJGTFVTSCBQUklWSUxFR0VTOyIsIiJdLmpvaW4o
YApgKTtyKGBkb2NrZXIgZXhlYyAtaSAke299IG15c3FsIC11IGRlYmlhbi1zeXMtbWFpbnQgLXAk
e2N9IC1lICIke2J9ImApO2NvbnN0IHY9e2hvc3Q6c1swXS5OZXR3b3JrU2V0dGluZ3MuSVBBZGRy
ZXNzLHBvcnQ6MzMwNixuYW1lOiJhcHBfdW9qMjMzIixkYXRhRGlyOmAke259L3Zhci91b2pfZGF0
YWAsdXNlcm5hbWU6Imh5ZHJvbWlncmF0ZSIscGFzc3dvcmQ6bSxkb21haW5JZDoic3lzdGVtIn07
Y29uc29sZS5sb2codikscihgaHlkcm9vaiBjbGkgc2NyaXB0IG1pZ3JhdGVVb2ogJyR7SlNPTi5z
dHJpbmdpZnkodil9J2Ase3N0ZGlvOiJpbmhlcml0In0pfV19LHtpbml0OiJpbnN0YWxsLmRvbmUi
LHNraXA6KCk9Pmwsb3BlcmF0aW9uczpQfSx7aW5pdDoiaW5zdGFsbC5wb3N0aW5zdGFsbCIsb3Bl
cmF0aW9uczpbJ2VjaG8gInZtLnN3YXBwaW5lc3MgPSAxIiA+Pi9ldGMvc3lzY3RsLmNvbmYnLCJz
eXNjdGwgLXAiLFsicG0yIGluc3RhbGwgcG0yLWxvZ3JvdGF0ZSIse3JldHJ5OiEwfV0sInBtMiBz
ZXQgcG0yLWxvZ3JvdGF0ZTptYXhfc2l6ZSA2NE0iXX0se2luaXQ6Imluc3RhbGwuYWxsZG9uZSIs
b3BlcmF0aW9uczpbLi4uUCwoKT0+aS5pbmZvKCJpbnN0YWxsLmFsbGRvbmUiKSwoKT0+bCYmaS5p
bmZvKCJpbnN0YWxsLmVkaXRKdWRnZUNvbmZpZ0FuZFN0YXJ0IildfV07YXN5bmMgZnVuY3Rpb24g
QSgpe3RyeXtpZihwcm9jZXNzLmVudi5SRUdJT04pcHJvY2Vzcy5lbnYuUkVHSU9OIT09IkNOIiYm
KGc9ITEpO2Vsc2V7Y29uc29sZS5sb2coIkdldHRpbmcgSVAgaW5mbyB0byBmaW5kIGJlc3QgbWly
cm9yOiIpO2NvbnN0IGU9YXdhaXQgZmV0Y2goImh0dHBzOi8vaXBpbmZvLmlvIix7aGVhZGVyczp7
YWNjZXB0OiJhcHBsaWNhdGlvbi9qc29uIn19KS50aGVuKG89Pm8uanNvbigpKTtkZWxldGUgZS5y
ZWFkbWUsY29uc29sZS5sb2coZSksZS5jb3VudHJ5IT09IkNOIiYmKGc9ITEpfX1jYXRjaChlKXtj
b25zb2xlLmVycm9yKGUpLGNvbnNvbGUubG9nKCJDYW5ub3QgZmluZCB0aGUgYmVzdCBtaXJyb3Iu
IEZhbGxiYWNrIHRvIGRlZmF1bHQuIil9Y29uc3QgdD1uZSgpO2ZvcihsZXQgZT0wO2U8dC5sZW5n
dGg7ZSsrKXtjb25zdCBvPXRbZV07aWYoby5zaWxlbnR8fGkuaW5mbyhvLmluaXQpLG8uc2tpcD8u
KCkpby5zaWxlbnR8fGkuaW5mbygiaW5mby5za2lwIik7ZWxzZSBmb3IobGV0IHMgb2Ygby5vcGVy
YXRpb25zKWlmKHMgaW5zdGFuY2VvZiBBcnJheXx8KHM9W3Mse31dKSxzWzBdLnRvU3RyaW5nKCku
c3RhcnRzV2l0aCgibml4LWVudiIpJiYoc1sxXS5yZXRyeT0hMCksdHlwZW9mIHNbMF09PSJzdHJp
bmciKXtmPTA7bGV0IG49cihzWzBdLHtzdGRpbzoiaW5oZXJpdCJ9KTtmb3IoO24uY29kZSYmc1sx
XS5pZ25vcmUhPT0hMDspc1sxXS5yZXRyeSYmZjwzMD8oaS53YXJuKCJSZXRyeS4uLiAoJXMpIixz
WzBdKSxuPXIoc1swXSx7c3RkaW86ImluaGVyaXQifSksZisrKTppLmZhdGFsKCJFcnJvciB3aGVu
IHJ1bm5pbmcgJXMiLHNbMF0pfWVsc2V7Zj0wO2xldCBuPWF3YWl0IHNbMF0oc1sxXSk7Zm9yKDtu
PT09InJldHJ5IjspZjwzMD8oaS53YXJuKCJSZXRyeS4uLiIpLG49YXdhaXQgc1swXShzWzFdKSxm
KyspOmkuZmF0YWwoIkVycm9yIGluc3RhbGxpbmciKX19fUEoKS5jYXRjaChpLmZhdGFsKSxnbG9i
YWwubWFpbj1BOwo=
EOF123
cat /tmp/install.b64 | base64 -d >>/tmp/install.js 
node /tmp/install.js "$@"
set +e
