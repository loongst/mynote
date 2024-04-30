var R=Object.create;var j=Object.defineProperty;var F=Object.getOwnPropertyDescriptor;var q=Object.getOwnPropertyNames;var G=Object.getPrototypeOf,z=Object.prototype.hasOwnProperty;var L=(t,e,o,s)=>{if(e&&typeof e=="object"||typeof e=="function")for(let n of q(e))!z.call(t,n)&&n!==o&&j(t,n,{get:()=>e[n],enumerable:!(s=F(e,n))||s.enumerable});return t};var k=(t,e,o)=>(o=t!=null?R(G(t)):{},L(e||!t||!t.__esModule?j(o,"default",{value:t,enumerable:!0}):o,t));var J=require("child_process"),a=require("fs"),D=k(require("net")),h=k(require("os")),U=require("readline/promises");const r=(t,e)=>{try{return{output:(0,J.execSync)(t,e).toString(),code:0}}catch(o){return{code:o.status,message:o.message}}},$=t=>new Promise(e=>{setTimeout(e,t)}),B={zh:{"install.start":"\u5F00\u59CB\u8FD0\u884C Hydro \u5B89\u88C5\u5DE5\u5177","warn.avx":"\u68C0\u6D4B\u5230\u60A8\u7684 CPU \u4E0D\u652F\u6301 avx \u6307\u4EE4\u96C6\uFF0C\u5C06\u4F7F\u7528 mongodb@v4.4","error.rootRequired":"\u8BF7\u5148\u4F7F\u7528 sudo su \u5207\u6362\u5230 root \u7528\u6237\u540E\u518D\u8FD0\u884C\u8BE5\u5DE5\u5177\u3002","error.unsupportedArch":"\u4E0D\u652F\u6301\u7684\u67B6\u6784 %s ,\u8BF7\u5C1D\u8BD5\u624B\u52A8\u5B89\u88C5\u3002","error.osreleaseNotFound":"\u65E0\u6CD5\u83B7\u53D6\u7CFB\u7EDF\u7248\u672C\u4FE1\u606F\uFF08/etc/os-release \u6587\u4EF6\u672A\u627E\u5230\uFF09\uFF0C\u8BF7\u5C1D\u8BD5\u624B\u52A8\u5B89\u88C5\u3002","error.unsupportedOS":"\u4E0D\u652F\u6301\u7684\u64CD\u4F5C\u7CFB\u7EDF %s \uFF0C\u8BF7\u5C1D\u8BD5\u624B\u52A8\u5B89\u88C5\uFF0C","install.preparing":"\u6B63\u5728\u521D\u59CB\u5316\u5B89\u88C5...","install.mongodb":"\u6B63\u5728\u5B89\u88C5 mongodb...","install.createDatabaseUser":"\u6B63\u5728\u521B\u5EFA\u6570\u636E\u5E93\u7528\u6237...","install.compiler":"\u6B63\u5728\u5B89\u88C5\u7F16\u8BD1\u5668...","install.hydro":"\u6B63\u5728\u5B89\u88C5 Hydro...","install.done":"Hydro \u5B89\u88C5\u6210\u529F\uFF01","install.alldone":"\u5B89\u88C5\u5DF2\u5168\u90E8\u5B8C\u6210\u3002","install.editJudgeConfigAndStart":"\u8BF7\u7F16\u8F91 ~/.hydro/judge.yaml \u540E\u4F7F\u7528 pm2 start hydrojudge && pm2 save \u542F\u52A8\u3002","extra.dbUser":"\u6570\u636E\u5E93\u7528\u6237\u540D\uFF1A hydro","extra.dbPassword":"\u6570\u636E\u5E93\u5BC6\u7801\uFF1A %s","info.skip":"\u6B65\u9AA4\u5DF2\u8DF3\u8FC7\u3002","error.bt":`\u68C0\u6D4B\u5230\u5B9D\u5854\u9762\u677F\uFF0C\u5B89\u88C5\u811A\u672C\u5F88\u53EF\u80FD\u65E0\u6CD5\u6B63\u5E38\u5DE5\u4F5C\u3002\u5EFA\u8BAE\u60A8\u4F7F\u7528\u7EAF\u51C0\u7684 Ubuntu 22.04 \u7CFB\u7EDF\u8FDB\u884C\u5B89\u88C5\u3002
\u8981\u5FFD\u7565\u8BE5\u8B66\u544A\uFF0C\u8BF7\u4F7F\u7528 --shamefully-unsafe-bt-panel \u53C2\u6570\u91CD\u65B0\u8FD0\u884C\u6B64\u811A\u672C\u3002`,"warn.bt":`\u68C0\u6D4B\u5230\u5B9D\u5854\u9762\u677F\uFF0C\u8FD9\u4F1A\u5BF9\u7CFB\u7EDF\u5B89\u5168\u6027\u4E0E\u7A33\u5B9A\u6027\u9020\u6210\u5F71\u54CD\u3002\u5EFA\u8BAE\u4F7F\u7528\u7EAF\u51C0 Ubuntu 22.04 \u7CFB\u7EDF\u8FDB\u884C\u5B89\u88C5\u3002
\u5F00\u53D1\u8005\u5BF9\u56E0\u4E3A\u4F7F\u7528\u5B9D\u5854\u9762\u677F\u7684\u6570\u636E\u4E22\u5931\u4E0D\u627F\u62C5\u4EFB\u4F55\u8D23\u4EFB\u3002
\u8981\u53D6\u6D88\u5B89\u88C5\uFF0C\u8BF7\u4F7F\u7528 Ctrl-C \u9000\u51FA\u3002\u5B89\u88C5\u7A0B\u5E8F\u5C06\u5728\u4E94\u79D2\u540E\u7EE7\u7EED\u3002`,"migrate.hustojFound":`\u68C0\u6D4B\u5230 HustOJ\u3002\u5B89\u88C5\u7A0B\u5E8F\u53EF\u4EE5\u5C06 HustOJ \u4E2D\u7684\u5168\u90E8\u6570\u636E\u5BFC\u5165\u5230 Hydro\u3002\uFF08\u539F\u6709\u6570\u636E\u4E0D\u4F1A\u4E22\u5931\uFF0C\u60A8\u53EF\u968F\u65F6\u5207\u6362\u56DE HustOJ\uFF09
\u8BE5\u529F\u80FD\u652F\u6301\u539F\u7248 HustOJ \u548C\u90E8\u5206\u4FEE\u6539\u7248\uFF0C\u8F93\u5165 y \u786E\u8BA4\u8BE5\u64CD\u4F5C\u3002
\u8FC1\u79FB\u8FC7\u7A0B\u6709\u4EFB\u4F55\u95EE\u9898\uFF0C\u6B22\u8FCE\u52A0QQ\u7FA4 1085853538 \u54A8\u8BE2\u7BA1\u7406\u5458\u3002`},en:{"install.start":"Starting Hydro installation tool","warn.avx":"Your CPU does not support avx, will use mongodb@v4.4","error.rootRequired":"Please run this tool as root user.","error.unsupportedArch":"Unsupported architecture %s, please try to install manually.","error.osreleaseNotFound":"Unable to get system version information (/etc/os-release file not found), please try to install manually.","error.unsupportedOS":"Unsupported operating system %s, please try to install manually.","install.preparing":"Initializing installation...","install.mongodb":"Installing mongodb...","install.createDatabaseUser":"Creating database user...","install.compiler":"Installing compiler...","install.hydro":"Installing Hydro...","install.done":"Hydro installation completed!","install.alldone":"Hydro installation completed.","install.editJudgeConfigAndStart":`Please edit config at ~/.hydro/judge.yaml than start hydrojudge with:
pm2 start hydrojudge && pm2 save.`,"extra.dbUser":"Database username: hydro","extra.dbPassword":"Database password: %s","info.skip":"Step skipped.","error.bt":`BT-Panel detected, this script may not work properly. It is recommended to use a pure Ubuntu 22.04 OS.
To ignore this warning, please run this script again with '--shamefully-unsafe-bt-panel' flag.`,"warn.bt":`BT-Panel detected, this will affect system security and stability. It is recommended to use a pure Ubuntu 22.04 OS.
The developer is not responsible for any data loss caused by using BT-Panel.
To cancel the installation, please use Ctrl-C to exit. The installation program will continue in five seconds.`,"migrate.hustojFound":`HustOJ detected. The installation program can migrate all data from HustOJ to Hydro.
The original data will not be lost, and you can switch back to HustOJ at any time.
This feature supports the original version of HustOJ and some modified versions. Enter y to confirm this operation.
If you have any questions about the migration process, please add QQ group 1085853538 to consult the administrator.`}},l=process.argv.includes("--judge"),O=process.argv.includes("--no-caddy"),S=["@hydrooj/ui-default","@hydrooj/hydrojudge","@hydrooj/fps-importer","@hydrooj/a11y"],x=l?"@hydrooj/hydrojudge":`hydrooj ${S.join(" ")}`,E=process.argv.find(t=>t.startsWith("--substituters=")),H=E?E.split("=")[1].split(","):[],I=process.argv.find(t=>t.startsWith("--migration="));let u=I?I.split("=")[1]:"",N=process.env.LANG?.includes("zh")||process.env.LOCALE?.includes("zh")?"zh":"en";process.env.TERM==="linux"&&(N="en");const w=t=>(e,...o)=>(t(B[N][e]||e,...o),0),i={info:w(console.log),warn:w(console.warn),fatal:(t,...e)=>(w(console.error)(t,...e),process.exit(1))};process.getuid?process.getuid()!==0&&i.fatal("error.rootRequired"):i.fatal("error.unsupportedOs"),["x64","arm64"].includes(process.arch)||i.fatal("error.unsupportedArch",process.arch),process.env.HOME||i.fatal("$HOME not found"),(0,a.existsSync)("/etc/os-release")||i.fatal("error.osreleaseNotFound");const W=(0,a.readFileSync)("/etc/os-release","utf-8"),Q=W.split(`
`),C={};for(const t of Q){if(!t.trim())continue;const e=t.split("=");e[1].startsWith('"')?C[e[0].toLowerCase()]=e[1].substring(1,e[1].length-2):C[e[0].toLowerCase()]=e[1]}let T=!0;const Y=(0,a.readFileSync)("/proc/cpuinfo","utf-8");!Y.includes("avx")&&!l&&(T=!1,i.warn("warn.avx"));let f=0;i.info("install.start");const V="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";function Z(t=32,e=V){let o="";for(let s=1;s<=t;s++)o+=e[Math.floor(Math.random()*e.length)];return o}let m=Z(32),g=!0;const y=`${process.env.HOME}/.nix-profile/`,p=(t,e=t,o=!0)=>`  - type: bind
    source: ${t}
    target: ${e}${o?`
    readonly: true`:""}`,K=`mount:
${p(`${y}bin`,"/bin")}
${p(`${y}bin`,"/usr/bin")}
${p(`${y}lib`,"/lib")}
${p(`${y}share`,"/share")}
${p(`${y}etc`,"/etc")}
${p("/nix","/nix")}
${p("/dev/null","/dev/null",!1)}
${p("/dev/urandom","/dev/urandom",!1)}
  - type: tmpfs
    target: /w
    data: size=512m,nr_inodes=8k
  - type: tmpfs
    target: /tmp
    data: size=512m,nr_inodes=8k
proc: true
workDir: /w
hostName: executor_server
domainName: executor_server
uid: 1536
gid: 1536
`,X=`# \u5982\u679C\u4F60\u5E0C\u671B\u4F7F\u7528\u5176\u4ED6\u7AEF\u53E3\u6216\u4F7F\u7528\u57DF\u540D\uFF0C\u4FEE\u6539\u6B64\u5904 :80 \u7684\u503C\u540E\u5728 ~/.hydro \u76EE\u5F55\u4E0B\u4F7F\u7528 caddy reload \u91CD\u8F7D\u914D\u7F6E\u3002
# \u5982\u679C\u4F60\u5728\u5F53\u524D\u914D\u7F6E\u4E0B\u80FD\u591F\u901A\u8FC7 http://\u4F60\u7684\u57DF\u540D/ \u6B63\u5E38\u8BBF\u95EE\u5230\u7F51\u7AD9\uFF0C\u82E5\u9700\u5F00\u542F ssl\uFF0C
# \u4EC5\u9700\u5C06 :80 \u6539\u4E3A\u4F60\u7684\u57DF\u540D\uFF08\u5982 hydro.ac\uFF09\u540E\u4F7F\u7528 caddy reload \u91CD\u8F7D\u914D\u7F6E\u5373\u53EF\u81EA\u52A8\u7B7E\u53D1 ssl \u8BC1\u4E66\u3002
# \u586B\u5199\u5B8C\u6574\u57DF\u540D\uFF0C\u6CE8\u610F\u533A\u5206\u6709\u65E0 www \uFF08www.hydro.ac \u548C hydro.ac \u4E0D\u540C\uFF0C\u8BF7\u68C0\u67E5 DNS \u8BBE\u7F6E\uFF09
# \u8BF7\u6CE8\u610F\u5728\u9632\u706B\u5899/\u5B89\u5168\u7EC4\u4E2D\u653E\u884C\u7AEF\u53E3\uFF0C\u4E14\u90E8\u5206\u8FD0\u8425\u5546\u4F1A\u62E6\u622A\u672A\u7ECF\u5907\u6848\u7684\u57DF\u540D\u3002
# For more information, refer to caddy v2 documentation.
:80 {
  log {
    output file /data/access.log {
      roll_size 1gb
      roll_keep_for 72h
    }
    format json
  }
  # Handle static files directly, for better performance.
  root * /root/.hydro/static
  @static {
    file {
      try_files {path}
    }
  }
  handle @static {
    file_server
  }
  handle {
    reverse_proxy http://127.0.0.1:8888
  }
}

# \u5982\u679C\u4F60\u9700\u8981\u540C\u65F6\u914D\u7F6E\u5176\u4ED6\u7AD9\u70B9\uFF0C\u53EF\u53C2\u8003\u4E0B\u65B9\u8BBE\u7F6E\uFF1A
# \u8BF7\u6CE8\u610F\uFF1A\u5982\u679C\u591A\u4E2A\u7AD9\u70B9\u9700\u8981\u5171\u4EAB\u540C\u4E00\u4E2A\u7AEF\u53E3\uFF08\u5982 80/443\uFF09\uFF0C\u8BF7\u786E\u4FDD\u4E3A\u6BCF\u4E2A\u7AD9\u70B9\u90FD\u586B\u5199\u4E86\u57DF\u540D\uFF01
# \u52A8\u6001\u7AD9\u70B9\uFF1A
# xxx.com {
#    reverse_proxy http://127.0.0.1:1234
# }
# \u9759\u6001\u7AD9\u70B9\uFF1A
# xxx.com {
#    root * /www/xxx.com
#    file_server
# }
`,ee=`hosts:
  local:
    host: localhost
    type: hydro
    server_url: https://hydro.ac/
    uname: judge
    password: examplepassword
    detail: true
tmpfs_size: 512m
stdio_size: 256m
memoryMax: ${Math.min(1024,h.default.totalmem()/4)}m
processLimit: 128
testcases_max: 120
total_time_limit: 600
retry_delay_sec: 3
parallelism: ${Math.max(1,Math.floor((0,h.cpus)().length/4))}
singleTaskParallelism: 2
rate: 1.00
rerun: 2
secret: Hydro-Judge-Secret
env: |
    PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
    HOME=/w
`,_=`
trusted-public-keys = cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY= hydro.ac:EytfvyReWHFwhY9MCGimCIn46KQNfmv9y8E2NqlNfxQ=
connect-timeout = 10
experimental-features = nix-command flakes
`,te=async t=>{const e=D.default.createServer(),o=await new Promise(s=>{e.once("error",()=>s(!1)),e.once("listening",()=>s(!0)),e.listen(t)});return e.close(),o};function oe(){const t=r("yarn global dir").output?.trim()||"";if(!t)return!1;const e=`${t}/package.json`,o=(0,a.existsSync)(e)?require(e):{};return o.resolutions||={},Object.assign(o.resolutions,Object.fromEntries(["@esbuild/linux-loong64","esbuild-windows-32",...["android","darwin","freebsd","windows"].flatMap(s=>[`${s}-64`,`${s}-arm64`]).map(s=>`esbuild-${s}`),...["32","arm","mips64","ppc64","riscv64","s390x"].map(s=>`esbuild-linux-${s}`),...["netbsd","openbsd","sunos"].map(s=>`esbuild-${s}-64`)].map(s=>[s,"link:/dev/null"]))),r(`mkdir -p ${t}`),(0,a.writeFileSync)(e,JSON.stringify(o,null,2)),!0}function se(){const t=r("yarn global dir").output?.trim()||"";if(!t)return!1;const e=`${t}/package.json`,o=JSON.parse((0,a.readFileSync)(e,"utf-8"));return delete o.resolutions,(0,a.writeFileSync)(e,JSON.stringify(o,null,2)),!0}const re=h.default.totalmem()/1024/1024/1024,M=Math.max(.25,Math.floor(re/6*100)/100),P=['echo "\u626B\u7801\u52A0\u5165QQ\u7FA4\uFF1A"',"echo https://qm.qq.com/cgi-bin/qm/qr\\?k\\=0aTZfDKURRhPBZVpTYBohYG6P6sxABTw | qrencode -o - -m 2 -t UTF8",()=>{if(l)return;const t=require(`${process.env.HOME}/.hydro/config.json`);t.uri?m=new URL(t.uri).password||"(No password)":m=t.password||"(No password)",i.info("extra.dbUser"),i.info("extra.dbPassword",m)}],ne=()=>[{init:"install.preparing",operations:[()=>{if(process.env.IGNORE_BT)return;r("bt default").code||(process.argv.includes("--shamefully-unsafe-bt-panel")?i.warn("warn.bt"):(i.warn("error.bt"),process.exit(1)))},()=>{H.length?(0,a.writeFileSync)("/etc/nix/nix.conf",`substituters = ${H.join(" ")}
${_}`):g||(0,a.writeFileSync)("/etc/nix/nix.conf",`substituters = https://cache.nixos.org/ https://nix.hydro.ac/cache
${_}`),!g&&(r("nix-channel --remove nixpkgs",{stdio:"inherit"}),r("nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs",{stdio:"inherit"}),r("nix-channel --update",{stdio:"inherit"}))},"nix-env -iA nixpkgs.pm2 nixpkgs.yarn nixpkgs.esbuild nixpkgs.bash nixpkgs.unzip nixpkgs.zip nixpkgs.diffutils",async()=>{const t=(0,U.createInterface)(process.stdin,process.stdout);try{if((0,a.existsSync)("/home/judge/src")&&(i.info("migrate.hustojFound"),(await t.question(">")).toLowerCase().trim()==="y"&&(u="hustoj")),u||!!r("docker -v").code)return;r("docker ps -a --format json").output?.split(`
`).map(n=>n.trim()).filter(n=>n).map(n=>JSON.parse(n))?.find(n=>n.Image.toLowerCase()==="universaloj/uoj-system"&&n.State==="running")&&(i.info("migrate.uojFound"),(await t.question(">")).toLowerCase().trim()==="y"&&(u="uoj"))}catch{console.error("Failed migration detection")}finally{t.close()}}]},{init:"install.mongodb",skip:()=>l,hidden:l,operations:[()=>(0,a.writeFileSync)(`${process.env.HOME}/.config/nixpkgs/config.nix`,`{
    permittedInsecurePackages = [
        "openssl-1.1.1t"
        "openssl-1.1.1u"
        "openssl-1.1.1v"
        "openssl-1.1.1w"
        "openssl-1.1.1x"
        "openssl-1.1.1y"
        "openssl-1.1.1z"
    ];
}`),`nix-env -iA hydro.mongodb${T?6:4}${g?"-cn":""} nixpkgs.mongosh nixpkgs.mongodb-tools`]},{init:"install.compiler",operations:["nix-env -iA nixpkgs.gcc nixpkgs.fpc nixpkgs.python3"]},{init:"install.sandbox",skip:()=>!r("hydro-sandbox --help").code,operations:["nix-env -iA nixpkgs.go-judge","ln -sf $(which go-judge) /usr/local/bin/hydro-sandbox"]},{init:"install.caddy",skip:()=>!r("caddy version").code||l||O,hidden:l,operations:["nix-env -iA nixpkgs.caddy",()=>(0,a.writeFileSync)(`${process.env.HOME}/.hydro/Caddyfile`,X)]},{init:"install.hydro",operations:[()=>oe(),g?()=>{let t=null;try{r("yarn config set registry https://registry.npmmirror.com/",{stdio:"inherit"}),t=r(`yarn global add ${x}`,{stdio:"inherit"})}catch{console.log("Failed to install from npmmirror, fallback to yarnpkg")}finally{r("yarn config set registry https://registry.yarnpkg.com",{stdio:"inherit"})}try{r(`yarn global add ${x}`,{timeout:6e4})}catch{if(console.warn("Failed to check update from yarnpkg"),t?.code!==0)return"retry"}return null}:[`yarn global add ${x}`,{retry:!0}],()=>{l?(0,a.writeFileSync)(`${process.env.HOME}/.hydro/judge.yaml`,ee):(0,a.writeFileSync)(`${process.env.HOME}/.hydro/addon.json`,JSON.stringify(S))},()=>se()]},{init:"install.createDatabaseUser",skip:()=>(0,a.existsSync)(`${process.env.HOME}/.hydro/config.json`)||l,hidden:l,operations:["pm2 start mongod",()=>$(3e3),async()=>{const{MongoClient:t,WriteConcern:e}=require("/usr/local/share/.config/yarn/global/node_modules/mongodb"),o=await t.connect("mongodb://127.0.0.1",{readPreference:"nearest",writeConcern:new e("majority")});await o.db("hydro").addUser("hydro",m,{roles:[{role:"readWrite",db:"hydro"}]}),await o.close()},()=>(0,a.writeFileSync)(`${process.env.HOME}/.hydro/config.json`,JSON.stringify({uri:`mongodb://hydro:${m}@127.0.0.1:27017/hydro`})),"pm2 stop mongod","pm2 del mongod"]},{init:"install.starting",operations:[["pm2 stop all",{ignore:!0}],()=>(0,a.writeFileSync)(`${process.env.HOME}/.hydro/mount.yaml`,K),`pm2 start bash --name hydro-sandbox -- -c "ulimit -s unlimited && hydro-sandbox -mount-conf ${process.env.HOME}/.hydro/mount.yaml -http-addr=localhost:5050"`,...l?[]:[()=>console.log(`WiredTiger cache size: ${M}GB`),`pm2 start mongod --name mongodb -- --auth --bind_ip 0.0.0.0 --wiredTigerCacheSizeGB=${M}`,()=>$(1e3),"pm2 start hydrooj",async()=>{O||(await te(80)||i.warn("port.80"),u==="hustoj"&&(r("systemctl stop nginx || true"),r("systemctl disable nginx || true"),r("/etc/init.d/nginx stop || true")),r("pm2 start caddy -- run",{cwd:`${process.env.HOME}/.hydro`}),r("hydrooj cli system set server.xff x-forwarded-for"),r("hydrooj cli system set server.xhost x-forwarded-host"))}],"pm2 startup","pm2 save"]},{init:"install.migrate",skip:()=>!u,silent:!0,operations:[["yarn global add @hydrooj/migrate",{retry:!0}],"hydrooj addon add @hydrooj/migrate"]},{init:"install.migrateHustoj",skip:()=>u!=="hustoj",silent:!0,operations:[()=>{const e=(0,a.readFileSync)("/home/judge/src/web/include/db_info.inc.php","utf-8").split(`
`);function o(n){const c=e.find(b=>b.includes(`$${n}`))?.split("=",2)[1].split(";")[0].trim();return c?c.startsWith('"')&&c.endsWith('"')?c.slice(1,-1):c==="false"?!1:c==="true"?!0:+c:null}const s={host:o("DB_HOST"),port:3306,name:o("DB_NAME"),dataDir:o("OJ_DATA"),username:o("DB_USER"),password:o("DB_PASS"),contestType:o("OJ_OI_MODE")?"oi":"acm",domainId:"system"};console.log(s),r(`hydrooj cli script migrateHustoj '${JSON.stringify(s)}'`,{stdio:"inherit"}),o("OJ_REGISTER")||r("hydrooj cli user setPriv 0 0")},"pm2 restart hydrooj"]},{init:"install.migrateUoj",skip:()=>u!=="uoj",silent:!0,operations:[()=>{const e=(r("docker ps -a --format json").output?.split(`
`).map(d=>d.trim()).filter(d=>d).map(d=>JSON.parse(d))).find(d=>d.Image.toLowerCase()==="universaloj/uoj-system"&&d.State==="running"),o=e.Id||e.ID,s=JSON.parse(r(`docker inspect ${o}`).output),n=s[0].GraphDriver.Data.MergedDir;r(`sed s/127.0.0.1/0.0.0.0/g -i ${n}/etc/mysql/mysql.conf.d/mysqld.cnf`),r(`docker exec -i ${o} /etc/init.d/mysql restart`);const c=(0,a.readFileSync)(`${n}/etc/mysql/debian.cnf`,"utf-8").split(`
`).find(d=>d.startsWith("password"))?.split("=")[1].trim(),b=[`CREATE USER 'hydromigrate'@'%' IDENTIFIED BY '${m}';`,"GRANT ALL PRIVILEGES ON *.* TO 'hydromigrate'@'%' WITH GRANT OPTION;","FLUSH PRIVILEGES;",""].join(`
`);r(`docker exec -i ${o} mysql -u debian-sys-maint -p${c} -e "${b}"`);const v={host:s[0].NetworkSettings.IPAddress,port:3306,name:"app_uoj233",dataDir:`${n}/var/uoj_data`,username:"hydromigrate",password:m,domainId:"system"};console.log(v),r(`hydrooj cli script migrateUoj '${JSON.stringify(v)}'`,{stdio:"inherit"})}]},{init:"install.done",skip:()=>l,operations:P},{init:"install.postinstall",operations:['echo "vm.swappiness = 1" >>/etc/sysctl.conf',"sysctl -p",["pm2 install pm2-logrotate",{retry:!0}],"pm2 set pm2-logrotate:max_size 64M"]},{init:"install.alldone",operations:[...P,()=>i.info("install.alldone"),()=>l&&i.info("install.editJudgeConfigAndStart")]}];async function A(){try{if(process.env.REGION)process.env.REGION!=="CN"&&(g=!1);else{console.log("Getting IP info to find best mirror:");const e=await fetch("https://ipinfo.io",{headers:{accept:"application/json"}}).then(o=>o.json());delete e.readme,console.log(e),e.country!=="CN"&&(g=!1)}}catch(e){console.error(e),console.log("Cannot find the best mirror. Fallback to default.")}const t=ne();for(let e=0;e<t.length;e++){const o=t[e];if(o.silent||i.info(o.init),o.skip?.())o.silent||i.info("info.skip");else for(let s of o.operations)if(s instanceof Array||(s=[s,{}]),s[0].toString().startsWith("nix-env")&&(s[1].retry=!0),typeof s[0]=="string"){f=0;let n=r(s[0],{stdio:"inherit"});for(;n.code&&s[1].ignore!==!0;)s[1].retry&&f<30?(i.warn("Retry... (%s)",s[0]),n=r(s[0],{stdio:"inherit"}),f++):i.fatal("Error when running %s",s[0])}else{f=0;let n=await s[0](s[1]);for(;n==="retry";)f<30?(i.warn("Retry..."),n=await s[0](s[1]),f++):i.fatal("Error installing")}}}A().catch(i.fatal),global.main=A;
