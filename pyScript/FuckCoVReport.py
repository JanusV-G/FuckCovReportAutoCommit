# coding:utf-8
import sys

import requests
from http import cookiejar
from bs4 import BeautifulSoup
import time
# import iMessage
import base64
import datetime
import random
import esprima
import re
import json
from smtplib import SMTP_SSL
from email.header import Header
from email.mime.text import MIMEText
import configPath


def send_Message(News='', sub='', receiver=""):
    # 使用 smtp 发送, 适用于国内
    mail_info = {
        "from": "",
        "to": receiver,
        "hostname": "",
        "port": "465",
        "username": "",
        "password": "",
        "mail_subject": sub,
        "mail_text": News,
        "mail_encoding": "utf-8"
    }

    # 这里使用SMTP_SSL就是默认使用465端口
    # try:
    # 创建SMTP对象
    smtp = SMTP_SSL(mail_info["hostname"], mail_info["port"])
    smtp.set_debuglevel(1)

    # 登录SMTP
    smtp.ehlo(mail_info["hostname"])
    smtp.login(mail_info["username"], mail_info["password"])

    # 准备邮件内容
    msg = MIMEText(mail_info["mail_text"], "plain", mail_info["mail_encoding"])     # 邮件内容
    msg["Subject"] = Header(mail_info["mail_subject"], mail_info["mail_encoding"])  # 邮件标题
    # msg["from"] = Header(mail_info["from"], 'utf-8')
    msg["from"] = mail_info["from"]         # 邮件显示的发件人
    msg["to"] = mail_info["to"]             # 邮件显示的收件人

    # 实际的发件人, 收件人, 邮件内容
    smtp.sendmail(mail_info["from"], mail_info["to"], msg.as_string())

    smtp.quit()
    print("SMTP success")


class STUPost:
    def __init__(self):
        self.cookies = {}
        # mock the build-in browser of WeChat:
        self.headers = {
            'User-Agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 14_4 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 MicroMessenger/8.0.2(0x18000237) NetType/4G Language/en',
            'Referer': 'https://stu.cugb.edu.cn/webApp/xuegong/index.html',
            'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'}
        self.session = requests.session()
        self.message1 = ''
        self.message2 = ''
        self.message3 = ''
        self.subj = ''
        self.content = ''
        # f = open('config.json', 'r', encoding='utf-8')
        f = open(configPath.configPath, 'r', encoding='utf-8')
        self.tmp = f.read()
        f.close()
        self.userconfig = json.loads(self.tmp)

    def login(self):
        try:
            url = 'https://cas.cugb.edu.cn/login'
            req = self.session.request('GET', url, verify=False).content
            soup = BeautifulSoup(req, 'html.parser')
            execution = soup.findAll("input", {"name": "execution"})[0]["value"]
            system = soup.findAll("input", {"id": "userLoginSystem"})[0]["value"]
            uname = self.userconfig['username']
            upwd = self.userconfig['password']
            data = {'username': uname,
                    'password': upwd,
                    'execution': execution,
                    '_eventId': 'submit',
                    'geolocation': '',
                    'loginType': 'username',
                    'system': system,  # '27A5A4DF0C874122A0AFE0367F0A3F46'
                    'enableCaptcha': 'N'}
            req = self.session.post(url=url, data=data, headers=self.headers, verify=False)
            self.cookies = requests.utils.dict_from_cookiejar(req.cookies)
            time.sleep(3)
            # To get the uid from javascript:
            uidurl = 'https://stu.cugb.edu.cn/'
            req = self.session.request('GET', uidurl, cookies=self.cookies, headers=self.headers, verify=False).content
            soup = BeautifulSoup(req, 'html.parser')
            scriptTags = str(soup.findAll('script')[1])
            rexp = re.compile(r'<[^>]+>', re.S)
            scriptCode = rexp.sub('', scriptTags)
            uid = esprima.tokenize(scriptCode)[48].value.replace('\'', '')
            uiddata = {'uid': uid}
            req = self.session.request('POST', "https://stu.cugb.edu.cn:443/caswisedu/login.htm", data=uiddata,
                                       verify=False)
            time.sleep(3)
            content = self.session.post(
                'https://stu.cugb.edu.cn/webApp/xuegong/index.html#/zizhu/apply?projectId=4a4ce9d6725c1d4001725e38fbdb07cd&type=YQSJCJ',
                verify=False)
            if content.status_code == 200:
                self.message1 = "Login status: Succeeded"
                time.sleep(3)
                self.clock_in()
            else:
                self.message1 = "Login status: Failed"
        except Exception as e:
            self.message1 = 'Error Code 0: ' + str(e)

    def clock_in(self):
        # cookie_para = {i.split("=")[0]: i.split("=")[1] for i in cookie.split("; ")}
        data = {
            'data': str(self.userconfig["data"]).replace("'", '"' ),
            'msgUrl': '''syt/zzapply/list.htm?type=YQSJCJ&xmid=4a4ce9d6725c1d4001725e38fbdb07cd''',
            'uploadFileStr': '''{}''', 'multiSelectData': '''{}'''}
        while True:
            try:
                r = self.session.request('POST', url='https://stu.cugb.edu.cn:443/syt/zzapply/operation.htm',
                                         headers=self.headers, cookies=self.cookies, data=data, verify=False)
                # print(r.status_code)
                if r.text == 'success':
                    self.message2 = 'Clocking-in status: Succeeded'
                    self.subj = '☛已提交每日健康信息...'
                    self.content = """
                    ✔今日打卡成功！
                    """
                elif r.text == 'Applied today':
                    self.message2 = 'Clocking-in status: Applied today'
                    self.subj = '☛健康信息今日已提交！'
                    self.content = """
                    ⚠已经打卡啦！
                    """
                else:
                    self.message2 = 'Clocking-in status: Failed. Please check it'
                    self.subj = '☛出现异常，请查看日志！'
                    self.content = self.message2
            except Exception as e:
                self.message2 = 'Error Code 1: ' + str(e)
                self.subj = '☛出现异常，请查看日志！'
                self.content = """
                【⚠警告！抛出异常代码！⚠】
                %s
                """ % self.message2
            else:
                break

    def send_to_phone(self):
        api = self.userconfig["push_api"]
        data = {
            "title": self.subj,
            "desp": self.content}
        requests.post(api, data=data, verify=False)


def printAns(msg=""):
    print(msg)

def mainFun(receiver=""):
    student = STUPost()
    student.login()
    send_Message(News=student.userconfig["username"] + "\n" + student.message1 + "\n" + student.message2,
                 sub="FuckCoVReport: " + student.subj,
                 receiver=receiver)
    student.send_to_phone()
    printAns(student.message1+"\n"+student.message2+"\n"+student.message3+"\n")

if __name__ == '__main__':

    mainFun(str(sys.argv[1]))

    pass
