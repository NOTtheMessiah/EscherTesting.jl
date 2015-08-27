# -*- coding: utf-8 -*-
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import Select
from selenium.common.exceptions import NoSuchElementException
from selenium.common.exceptions import NoAlertPresentException
import unittest, time, re

class TestMinesweeper(unittest.TestCase):
    def setUp(self):
        self.driver = webdriver.Chrome()
        self.driver.implicitly_wait(30)
        self.base_url = "http://localhost:5555/"
        self.verificationErrors = []
        self.accept_next_alert = True
    
    def test_minesweeper(self):
        driver = self.driver
        driver.get(self.base_url + "/minesweeper.jl")
        for i in range(60):
            try:
                if self.is_element_present(By.XPATH, "//div[2]/div/paper-material/div"): break
            except: pass
            time.sleep(1)
        else: self.fail("time out")
        print("DEBUG: Clicking 3rd tile")
        time.sleep(1)
        driver.find_element_by_xpath("//div[3]/div/paper-material/div").click()
        time.sleep(1)
        self.assertEqual("3", driver.find_element_by_xpath("//div[3]/div/paper-material/div/span").text)
        time.sleep(1)
        driver.find_element_by_xpath("//div[4]/div/paper-material/div").click()
        time.sleep(1)
        #self.assertTrue(self.is_element_present(By.TAG_NAME, "paper-element"))
        time.sleep(1)
        #self.assertEqual("START AGAIN", driver.find_element_by_tag_name("paper-element").text)
        time.sleep(1)
        #driver.find_element_by_xpath("//paper-material/span").click()
        #driver.find_element_by_tag_name("paper-element").click()
        time.sleep(1)
    
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
