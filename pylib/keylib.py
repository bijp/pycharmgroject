from selenium import webdriver
import time
from selenium.webdriver.common.action_chains import ActionChains
from cfg import *


class keylib:
    # def perform(self,locator):
    #     element = self.find_element(locator)
    #     action = ActionChains(self.driver)
    #     action.move_to_element(element).perform()
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'

    def __init__(self):
        pass
    def open_browser2(self):
        self.wd = webdriver.Chrome('D:\seleniumtool\chromedriver_win32v73\chromedriver.exe')
        self.wd.implicitly_wait(10)
        self.wd.maximize_window()

    def close_browser2(self):
        self.wd.quit()



    def teacher_login(self,username,password):
        self.wd.get(g_teacher_login_url)
        self.wd.find_element_by_id('username').send_keys(username)
        self.wd.find_element_by_id('password').send_keys(password)
        self.wd.find_element_by_id('submit').click()

        self.wd.find_element_by_id('topbar')

    def performs_student(self):
        self.onepath='.main-menu >ul> li:nth-of-type(4)'
        self.twopath = 'a[href="#/student_group"] span'
        stop = self.wd.find_element_by_css_selector(self.onepath)
        ActionChains(self.wd).move_to_element(stop).perform()
        self.wd.find_element_by_css_selector(self.twopath).click()
        # stop.find_elements_by_css_selector('a[href="#/student_group"] span').click()

    #验证首页 学校、姓名、学科、金币、已发布微课、已发布作业 的信息正确
    def get_teacher_homepage_info(self):
        self.wd.find_element_by_css_selector('a[href="#/home"] > li').click()
        self.wd.find_element_by_id('home_div')
        time.sleep(2)
        #读取首页相关信息并输出
        eles = self.wd.find_elements_by_css_selector('#home_div .ng-binding')
        return [ele.text for ele in eles]

    def get_teacher_class_students_info(self):
        #点击班级学生菜单
        self.onepath = '.main-menu >ul> li:nth-of-type(4)'
        self.twopath = 'a[href="#/student_group"] span'
        stop = self.wd.find_element_by_css_selector(self.onepath)
        ActionChains(self.wd).move_to_element(stop).perform()
        self.wd.find_element_by_css_selector(self.twopath).click()
        time.sleep(2)
        #拿到学生列表，div.panel首页信息
        classes = self.wd.find_elements_by_css_selector('div.panel')
        if not classes:
            return {}
        classStudentTab = {}
        #gradeclass是拿到 班级信息  七年级   实验9班，nameEles是学生信息
        for cla in classes:
            gradeclass = cla.find_element_by_class_name('panel-heading').text.replace(' ','')
            cla.click()
            time.sleep(2)
            self.wd.implicitly_wait(1)

            nameEles = cla.find_elements_by_css_selector('tr > td:nth-child(2)')
            self.wd.implicitly_wait(10)
            names = [nameEle.text for nameEle in nameEles]

            classStudentTab[gradeclass]=names

        return classStudentTab
    #
    # def student_login(self,username,password):
    #     self.wd.get(g_student_login_url)
    #     self.wd.find_element_by_id('username').send_keys(username)
    #     self.wd.find_element_by_id('password').send_keys(password)
    #     self.wd.find_element_by_id('submit').click()
    #
    #     # 确保首页打开，登录成功
    #     self.wd.find_element_by_id('div-home')
    #
    # def get_student_homepage_info(self):
    #     # 查看 a 元素发现其位置不是主页按钮位置
    #     self.wd.find_element_by_css_selector("a[href='#/home']>li").click()
    #     # 确保首页打开
    #     self.wd.find_element_by_id('div-home')
    #
    #     # 由于数据是异步获取，需要sleep一段时间，假设需求是2秒必须获取数据
    #     time.sleep(2)
    #
    #     eles = self.wd.find_elements_by_css_selector('#div-home .ng-binding')
    #
    #     ret = [ele.text for ele in eles]
    #     ret.pop(2)
    #     return ret
    #
    # def get_student_wrongquestions(self):
    #     self.wd.find_element_by_css_selector("div.main-menu>ul>a:nth-of-type(4)>li").click()
    #
    #     # 由于数据是异步获取，需要sleep一段时间，假设需求是2秒必须获取数据
    #     time.sleep(2)
    #
    #     return self.wd.find_element_by_id('page-wrapper').text


if __name__ == '__main__':
    op = keylib()
    # op.open_browser()