# -*- coding: utf-8 -*-
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import Select
from selenium.common.exceptions import NoSuchElementException
from selenium.common.exceptions import NoAlertPresentException
import unittest, time, re


class Form(unittest.TestCase):
    def setUp(self):
        self.driver = webdriver.Chrome()
        self.driver.implicitly_wait(30)
        self.base_url = "http://localhost:5555"
        self.verificationErrors = []
        self.accept_next_alert = True
    
    def test_rate(self):
        driver = self.driver
        driver.get(self.base_url + "/form.jl")

        for i in range(60):
            try:
                if self.is_element_present(By.CSS_SELECTOR, "div.flow.vertical  > span"): break
            except: pass
            time.sleep(1)
        else: self.fail("time out")
        time.sleep(1)
        try: self.assertEqual("Dict{Any,Any}()", driver.find_element_by_css_selector("div.flow.vertical  > span").text)
        except AssertionError as e: self.verificationErrors.append(str(e))

        time.sleep(1)

        # need to replace this with mouse events instead of directly editing the Polymer properties
        print("DEBUG: setting rating")
        myslider = driver.find_element_by_tag_name("paper-slider")
        driver.execute_script("document.getElementsByTagName('paper-slider')[0].value=5")
        driver.execute_script("document.getElementsByTagName('paper-slider')[0].fire('change')") # doesn't work in firefox

        driver.find_element_by_tag_name("paper-button").click()
        time.sleep(5)
        try: self.assertEqual(u'{:rating=>5,:submit=>LeftButton(),:_trigger=>:submit,:name=>""}', driver.find_element_by_css_selector("div.flow.vertical  > span").text)
        except AssertionError as e: self.verificationErrors.append(str(e))

    def test_name(self):
        driver = self.driver
        driver.get(self.base_url + "/form.jl")


        for i in range(60):
            try:
                if self.is_element_present(By.CSS_SELECTOR, "div.flow.vertical  > span"): break
            except: pass
            time.sleep(1)
        else: self.fail("time out")
        print("DEBUG: checking field")
        time.sleep(1)
        try: self.assertEqual("Dict{Any,Any}()", driver.find_element_by_css_selector("div.flow.vertical  > span").text)
        except AssertionError as e: self.verificationErrors.append(str(e))

        print("DEBUG: entering name")
        myname = driver.find_element_by_id("input")
        myname.clear()
        myname.send_keys("John Doe")
        time.sleep(1)

        driver.find_element_by_tag_name("paper-button").click()
        time.sleep(5)
        try: self.assertEqual(u'{:rating=>1,:submit=>LeftButton(),:_trigger=>:submit,:name=>"John Doe"}', driver.find_element_by_css_selector("div.flow.vertical  > span").text)
        except AssertionError as e: self.verificationErrors.append(str(e))

    
    def is_element_present(self, how, what):
        try: self.driver.find_element(by=how, value=what)
        except NoSuchElementException, e: return False
        return True
    
    def is_alert_present(self):
        try: self.driver.switch_to_alert()
        except NoAlertPresentException, e: return False
        return True
    
    def close_alert_and_get_its_text(self):
        try:
            alert = self.driver.switch_to_alert()
            alert_text = alert.text
            if self.accept_next_alert:
                alert.accept()
            else:
                alert.dismiss()
            return alert_text
        finally: self.accept_next_alert = True
    
    def tearDown(self):
        self.driver.quit()
        self.assertEqual([], self.verificationErrors)

if __name__ == "__main__":
    unittest.main()
