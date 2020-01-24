"""Unittest for one module
Test One
"""

import unittest
from logginglib.logger import testeable, logg


class TestConfig(unittest.TestCase):
    """Unittest class for one module"""

    def test_testeable(self):
        """Test one"""
        echo = testeable("aaa")
        self.assertTrue( echo == "aaa")
    
    def test_logger(self):
        """Test one"""
        echo = logg("bbb")
        self.assertTrue( echo == "bbb")


if __name__ == "__main__":
    unittest.main()