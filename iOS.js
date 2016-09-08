function isAndroid() {
    var u = navigator.userAgent;
    var isAndroid = u.indexOf('Android') > -1 || u.indexOf('Adr') > -1;
    return isAndroid;
}

function isiOS() {
    var u = navigator.userAgent;
    var isiOS = !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/);
    return isiOS;
}
                          
function loadURL(url) {
    var iFrame;
    iFrame = document.createElement("iframe");
    iFrame.setAttribute("src", url);
    iFrame.setAttribute("style", "display:none;");
    iFrame.setAttribute("height", "0px");
    iFrame.setAttribute("width", "0px");
    iFrame.setAttribute("frameborder", "0");
    document.body.appendChild(iFrame);
    // 发起请求后这个 iFrame 就没用了，所以把它从 dom 上移除掉
    iFrame.parentNode.removeChild(iFrame);
    iFrame = null;
}

/*
 * { 
 *  title: text
 *  desc: text
 *  thumb: text
 *  url: text
 * }
 */
function shareSocial(msg) {
    var json = JSON.stringify(msg);
    loadURL("iwebhybrid://com.iwebhybirid.share?" + json);
}

function nslog(msg) {
    loadURL("iwebhybrid://com.iwebhybirid.log?" + msg);
}
                        
function objc_sendMsg(argv) {
    window.webkit.messageHandlers.objcsendMsg.postMessage(argv);
}

function objc_log(msg) {
    window.webkit.messageHandlers.nslog.postMessage(msg);
}

function detect() {
    var x = navigator;
    var msg = "";
    msg += x.appCodeName ;
    msg += x.appMinorVersion;
    msg += x.appName;
    msg += x.appVersion;
    msg += x.cookieEnabled;
    msg += x.cpuClass;
    msg += x.onLine;
    msg += x.platform;
    msg += x.userAgent;
    msg += x.browserLanguage;
    msg += x.systemLanguage;
    msg += x.userLanguage;
    return msg;
}