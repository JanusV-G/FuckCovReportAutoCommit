import pymysql as pymysql

import FuckCoVReport
import main
import json
import logging
import smtplib
import sys
import smtplib
from email.mime.text import MIMEText
from email.header import Header
import configPath
import databaseConfig



# 从数据库中更新userList
def updateUserInfoFromDB():
    # 确定连接参数
    DB_URL=databaseConfig.DB_URL
    DB_NAME = databaseConfig.DB_NAME
    DB_USERNAME = databaseConfig.DB_USERNAME
    DB_PASSWORD = databaseConfig.DB_PASSWORD
    TABLE_NAME = databaseConfig.TABLE_NAME

    # 连接数据库
    db = pymysql.connect(host=DB_URL, user=DB_USERNAME, password=DB_PASSWORD, database=DB_NAME, charset="utf8mb4")
    # 创建游标对象
    cursor01 = db.cursor()
    # 使用游标对象执行SQL语句
    cursor01.execute("SELECT * FROM %s" %(TABLE_NAME))
    # 获取返回的数据
    data = cursor01.fetchall()

    # 逐条打印数据
    print(type(data))
    print(data[0][0])
    for tmp in data:
        print(tmp)
    print("--------------------------------")
    # 清理
    cursor01.close()
    db.close()

    # 写入到json中
    jsonOutputFile = open(configPath.userInfoPath, mode="w", encoding="utf-8")
    userDir = {}

    for nowUser in data:
        # username=
        userDir.update({nowUser[0]: {"username": nowUser[1], "password": nowUser[2], "email": nowUser[3],
                                     "push_api": "https://sctapi.ftqq.com/%s.send"%(nowUser[4])}})

    tempData = json.dumps(userDir, indent=4, ensure_ascii=False)
    print(tempData)
    jsonOutputFile.write(str(tempData))


def readJson():
    # jsonFile = open(r"D:\pycharm\projects\CoVReportAutoCommit\config.json", mode="r+", encoding="utf-8")
    jsonFile = open(configPath.configPath, mode="r+", encoding="utf-8")
    print("Function: ", sys._getframe().f_code.co_name)
    jsonData = json.load(jsonFile)
    print(jsonData)

    pass


def changeJson():
    # 读取配置文件
    userInfo = configPath.userInfoPath
    userInfoFile = open(userInfo, mode='r', encoding="utf-8")
    # jsonConfigFile = open(r"D:\pycharm\projects\CoVReportAutoCommit\configTemplate.json", mode="r", encoding="utf-8")
    jsonConfigFile = open(configPath.configTemplatePath, mode="r", encoding="utf-8")

    # 转换成json数据
    userInfoData = json.load(userInfoFile)
    jsonConfigData = json.load(jsonConfigFile)

    for nowUser in userInfoData:
        # 每次循环重新读取
        jsonOutputFile = open(configPath.configPath, mode="w+", encoding="utf-8")

        jsonConfigData["username"] = userInfoData[nowUser]["username"]
        jsonConfigData["password"] = userInfoData[nowUser]["password"]
        jsonConfigData["push_api"] = userInfoData[nowUser]["push_api"]
        # 重新encode成json
        tempByte = json.dumps(jsonConfigData, indent=4, ensure_ascii=False)

        jsonOutputFile.write(str(tempByte))
        jsonOutputFile.close()  # 关闭文件刷新缓冲区, 强制写回
        readJson()              # 读取当前的config.json

        FuckCoVReport.mainFun(userInfoData[nowUser]["email"])   # autoCommit

    pass


def mainFun():
    updateUserInfoFromDB()
    changeJson()  # 主程序

# 全局变量

if __name__ == '__main__':
    mainFun()

    pass
