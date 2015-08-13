# -*- coding: utf-8 -*-
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import Select
from selenium.common.exceptions import NoSuchElementException
from selenium.common.exceptions import NoAlertPresentException
import unittest, time, re

class Layout(unittest.TestCase):
    def setUp(self):
        self.driver = webdriver.Chrome()
        #self.driver = webdriver.Firefox()
        self.driver.implicitly_wait(30)
        self.base_url = "http://localhost:5555"
        self.verificationErrors = []
        self.accept_next_alert = True
    
    def test_layout(self):
        driver = self.driver
        driver.get(self.base_url + "/layout.jl")
        for i in range(60):
            try:
                if self.is_element_present(By.CSS_SELECTOR, "div.flow:nth-child(1)"): break
            except: pass
            time.sleep(1)
        else: self.fail("time out")
        self.assertTrue(self.is_element_present(By.CSS_SELECTOR, "div.flow.vertical  > div"))
        self.assertTrue(self.is_element_square(By.CSS_SELECTOR, "div.flow.vertical"))
    
    def is_element_present(self, how, what):
        try: self.driver.find_element(by=how, value=what)
        except NoSuchElementException, e: return False
        return True

    def is_element_square(self, how, what):
        try:
		el = self.driver.find_element(by=how, value=what)
		print(el.size)
        except NoSuchElementException, e: return False
        return el.size["width"]==el.size["height"]
    
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
